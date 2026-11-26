import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:password_strength_checker/password_strength_checker.dart';

void main() {
  group('isCommonPassword', () {
    test('matches exact and case-insensitive', () {
      expect(isCommonPassword('password'), isTrue);
      expect(isCommonPassword('PassWord'), isTrue);
      expect(isCommonPassword('xQ7!not-common-at-all'), isFalse);
    });

    test('exposed check runs before the length check', () {
      expect(
        PasswordStrength.calculate(text: 'Password'),
        PasswordStrength.alreadyExposed,
      );
    });
  });

  test('unicode special characters count as special', () {
    expect(
      PasswordStrength.calculate(text: 'gzmrtkWP7€xvq'),
      PasswordStrength.secure,
    );
    expect(
      PasswordStrength.calculate(text: 'gzmrtkWP7.xvq'),
      PasswordStrength.secure,
    );
  });

  group('PasswordGeneratorConfiguration', () {
    const config = PasswordGeneratorConfiguration();

    test('== and hashCode are value based', () {
      const other = PasswordGeneratorConfiguration();
      expect(config, other);
      expect(config.hashCode, other.hashCode);
      expect(config == config.copyWith(length: 20), isFalse);
    });

    test('copyWith keeps the other fields', () {
      final copy = config.copyWith(length: 32, useDigits: false);
      expect(copy.length, 32);
      expect(copy.useDigits, isFalse);
      expect(copy.minSpecial, config.minSpecial);
      expect(copy.specialChars, config.specialChars);
    });

    test('generated password honours the configuration', () {
      final password = PasswordGenerator(
        config.copyWith(length: 40, useSpecialChars: false),
      ).generate();
      expect(password.length, 40);
      expect(password, matches(RegExp(r'^[a-zA-Z0-9]+$')));
    });
  });

  group('PasswordStrengthFormChecker', () {
    Widget app(Widget child, {ThemeData? theme}) => MaterialApp(
      theme: theme,
      home: Scaffold(body: SingleChildScrollView(child: child)),
    );

    testWidgets('validates a text set without typing (no crash)', (
      tester,
    ) async {
      final formKey = GlobalKey<FormState>();
      final controller = TextEditingController(text: 'gzmrtkWP7.xvq');
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        app(
          Form(
            key: formKey,
            child: PasswordStrengthFormChecker<PasswordStrength>(
              minimumStrengthRequired: PasswordStrength.secure,
              strengthCalculator: (text) =>
                  PasswordStrength.calculate(text: text),
              controller: controller,
            ),
          ),
        ),
      );

      expect(formKey.currentState!.validate(), isTrue);
      expect(find.text('Secure'), findsOneWidget);

      controller.text = 'weak';
      await tester.pump();
      expect(formKey.currentState!.validate(), isFalse);
      expect(find.text('Weak'), findsOneWidget);
    });

    testWidgets('generator fills both fields and the form is valid', (
      tester,
    ) async {
      final formKey = GlobalKey<FormState>();
      String? generated;
      PasswordStrength? lastStrength;

      await tester.pumpWidget(
        app(
          Form(
            key: formKey,
            child: PasswordStrengthFormChecker<PasswordStrength>(
              minimumStrengthRequired: PasswordStrength.secure,
              strengthCalculator: (text) =>
                  PasswordStrength.calculate(text: text),
              needConfirmation: true,
              showGenerator: true,
              onPasswordGenerated: (p) => generated = p,
              onChanged: (_, s) => lastStrength = s,
            ),
          ),
        ),
      );

      expect(formKey.currentState!.validate(), isFalse);
      await tester.tap(find.text('Generate password'));
      await tester.pumpAndSettle();

      expect(generated, isNotNull);
      expect(lastStrength, PasswordStrength.secure);
      expect(formKey.currentState!.validate(), isTrue);
    });

    testWidgets('confirmation mismatch is invalid', (tester) async {
      final formKey = GlobalKey<FormState>();
      final password = TextEditingController(text: 'gzmrtkWP7.xvq');
      final confirmation = TextEditingController(text: 'different');
      addTearDown(password.dispose);
      addTearDown(confirmation.dispose);

      await tester.pumpWidget(
        app(
          Form(
            key: formKey,
            child: PasswordStrengthFormChecker<PasswordStrength>(
              minimumStrengthRequired: PasswordStrength.weak,
              strengthCalculator: (text) =>
                  PasswordStrength.calculate(text: text),
              controller: password,
              confirmationController: confirmation,
              needConfirmation: true,
            ),
          ),
        ),
      );

      expect(formKey.currentState!.validate(), isFalse);
      await tester.pump();
      expect(find.text('Passwords do not match'), findsOneWidget);
    });

    testWidgets('follows a new controller after didUpdateWidget', (
      tester,
    ) async {
      final a = TextEditingController();
      final b = TextEditingController();
      addTearDown(a.dispose);
      addTearDown(b.dispose);

      Widget build(TextEditingController c) => app(
        PasswordStrengthFormChecker<PasswordStrength>(
          minimumStrengthRequired: PasswordStrength.weak,
          strengthCalculator: (text) => PasswordStrength.calculate(text: text),
          controller: c,
        ),
      );

      await tester.pumpWidget(build(a));
      await tester.pumpWidget(build(b));
      b.text = 'gzmrtkWP7.xvq';
      await tester.pumpAndSettle();
      expect(find.text('Secure'), findsOneWidget);

      a.text = 'weak';
      await tester.pumpAndSettle();
      expect(find.text('Secure'), findsOneWidget);
    });

    testWidgets('fieldBuilder replaces the default field', (tester) async {
      await tester.pumpWidget(
        app(
          PasswordStrengthFormChecker<PasswordStrength>(
            minimumStrengthRequired: PasswordStrength.weak,
            strengthCalculator: (text) =>
                PasswordStrength.calculate(text: text),
            fieldBuilder: (context, data) => TextFormField(
              key: const Key('custom'),
              controller: data.controller,
              validator: data.validator,
            ),
          ),
        ),
      );
      expect(find.byKey(const Key('custom')), findsOneWidget);
    });
  });

  group('PasswordStrengthChecker', () {
    testWidgets('fill follows the strength and border adapts to theme', (
      tester,
    ) async {
      final strength = ValueNotifier<PasswordStrength?>(null);
      addTearDown(strength.dispose);
      final theme = ThemeData(brightness: Brightness.dark);

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: SizedBox(
              width: 400,
              child: PasswordStrengthChecker(strength: strength),
            ),
          ),
        ),
      );

      final bar = tester.widget<AnimatedContainer>(
        find.byType(AnimatedContainer).first,
      );
      final border = (bar.decoration! as BoxDecoration).border! as Border;
      expect(border.top.color, theme.colorScheme.outlineVariant);

      double fill() => tester
          .widget<AnimatedFractionallySizedBox>(
            find.byType(AnimatedFractionallySizedBox),
          )
          .widthFactor!;

      expect(fill(), 0);
      strength.value = PasswordStrength.medium;
      await tester.pumpAndSettle();
      expect(fill(), PasswordStrength.medium.widthPerc);
      expect(find.text('Medium'), findsOneWidget);
    });
  });
}
