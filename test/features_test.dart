import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:password_strength_checker/password_strength_checker.dart';

void main() {
  group('findWeakPatterns', () {
    test('finds repeats, sequences and keyboard runs', () {
      expect(findWeakPatterns('xAAAA1234!'), ['AAAA', '1234']);
      expect(findWeakPatterns('Zqwer9'), ['qwer']);
      expect(findWeakPatterns('lkjh!'), ['lkjh']);
      expect(findWeakPatterns('DCBA'), ['DCBA']);
      expect(findWeakPatterns('!!!!'), ['!!!!']);
    });

    test('ignores short or mixed runs', () {
      expect(findWeakPatterns('abc'), isEmpty);
      expect(findWeakPatterns('ab12'), isEmpty);
      expect(findWeakPatterns('k7#Vq9!mRz2@Lp'), isEmpty);
    });

    test('merges overlapping runs and survives special casing', () {
      expect(findWeakPatterns('aaaab'), ['aaaa']);
      expect(findWeakPatterns('xİİİİ'), hasLength(1));
    });

    test('effective length collapses runs to two characters', () {
      expect(effectivePasswordLength('Aaaaaaaaaaa1!'), 4);
      expect(effectivePasswordLength('k7#Vq9!mRz2@Lp'), 14);
    });
  });

  group('calculate with weak patterns', () {
    test('padding with predictable runs is weak', () {
      expect(
        PasswordStrength.calculate(text: 'Aaaaaaaaaaa1!'),
        PasswordStrength.weak,
      );
      expect(
        PasswordStrength.calculate(text: 'Qwerty123456!x'),
        PasswordStrength.weak,
      );
    });

    test('a long password survives a short run', () {
      expect(
        PasswordStrength.calculate(text: 'k7#Vq9!mRz2@Lp1234'),
        PasswordStrength.secure,
      );
    });
  });

  test('generator avoids weak patterns by default', () {
    const generator = PasswordGenerator(
      PasswordGeneratorConfiguration(
        length: 12,
        useLowercase: false,
        useUppercase: false,
        useSpecialChars: false,
      ),
    );
    for (var i = 0; i < 200; i++) {
      final password = generator.generate();
      expect(findWeakPatterns(password), isEmpty, reason: password);
    }
  });

  group('PassphraseGenerator', () {
    test('defaults to 5 EFF words joined by "-"', () {
      final passphrase = const PassphraseGenerator(
        PassphraseConfiguration(separator: ' '),
      ).generate();
      final words = passphrase.split(' ');
      expect(words, hasLength(5));
      expect(words.every(effShortWordlist.contains), isTrue);
      expect(effShortWordlist, hasLength(1296));
    });

    test('capitalizes and appends a number', () {
      final passphrase = const PassphraseGenerator(
        PassphraseConfiguration(
          wordCount: 4,
          separator: '_',
          capitalize: true,
          includeNumber: true,
          words: ['alpha', 'bravo', 'charlie'],
        ),
      ).generate();
      final words = passphrase.split('_');
      expect(words, hasLength(4));
      expect(words.every((w) => w[0] == w[0].toUpperCase()), isTrue);
      expect(RegExp(r'\d').allMatches(passphrase), hasLength(1));
    });

    test('reports entropy', () {
      expect(const PassphraseGenerator().entropyBits, closeTo(51.7, 0.05));
      expect(
        const PassphraseGenerator(
          PassphraseConfiguration(wordCount: 6, includeNumber: true),
        ).entropyBits,
        greaterThan(66),
      );
    });

    test('configuration copyWith and equality', () {
      const config = PassphraseConfiguration();
      expect(config, const PassphraseConfiguration());
      expect(config.copyWith(wordCount: 7).wordCount, 7);
      expect(config == config.copyWith(capitalize: true), isFalse);
    });
  });

  group('PasswordRequirement', () {
    test('defaults mirror the secure rules', () {
      bool allMet(String p) =>
          PasswordRequirement.defaults.every((r) => r.isMetBy(p));
      expect(allMet('k7#Vq9!mRz2@Lp'), isTrue);
      expect(allMet('k7#Vq9!mRz2'), isFalse);
      expect(allMet('k7#vq9!mrz2@lp'), isFalse);
    });

    test('built-in extras', () {
      expect(PasswordRequirement.notCommon().isMetBy('Password'), isFalse);
      expect(PasswordRequirement.noWeakPatterns().isMetBy('ab1234'), isFalse);
      expect(PasswordRequirement.noWeakPatterns().isMetBy(''), isFalse);
      expect(PasswordRequirement.minLength(3, label: 'Tre').label, 'Tre');
    });
  });

  group('PasswordRequirementsChecklist', () {
    testWidgets('ticks requirements as the text changes', (tester) async {
      final controller = TextEditingController();
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PasswordRequirementsChecklist(password: controller),
          ),
        ),
      );

      expect(find.byIcon(Icons.check_circle), findsNothing);
      expect(find.byIcon(Icons.radio_button_unchecked), findsNWidgets(5));

      controller.text = 'abc1';
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.check_circle), findsNWidgets(2));

      controller.text = 'k7#Vq9!mRz2@Lp';
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.check_circle), findsNWidgets(5));
    });

    testWidgets('form checker shows the checklist when asked', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PasswordStrengthFormChecker<PasswordStrength>(
              minimumStrengthRequired: PasswordStrength.secure,
              strengthCalculator: (t) => PasswordStrength.calculate(text: t),
              requirements: PasswordRequirement.defaults,
            ),
          ),
        ),
      );
      expect(find.byType(PasswordRequirementsChecklist), findsOneWidget);
      expect(find.text('One symbol'), findsOneWidget);
    });
  });
}
