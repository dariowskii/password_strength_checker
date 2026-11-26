import 'package:flutter/material.dart';

import 'config/password_generator_configuration.dart';
import 'config/password_strength_checker_configuration.dart';
import 'enum/password_strength_enum.dart';
import 'password_generator/password_generator.dart';
import 'password_strength_checker.dart';

/// Builds a custom password field for [PasswordStrengthFormChecker].
typedef PasswordFieldBuilder =
    Widget Function(BuildContext context, PasswordFieldData data);

/// What a [PasswordFieldBuilder] needs to wire its own field.
final class PasswordFieldData {
  const PasswordFieldData._({
    required this.controller,
    required this.validator,
    required this.isConfirmation,
    this.focusNode,
  });

  /// The controller to attach to the field.
  final TextEditingController controller;

  /// The validator to attach to the field.
  final FormFieldValidator<String> validator;

  /// The focus node to attach to the field, if any.
  final FocusNode? focusNode;

  /// Whether this is the confirmation field.
  final bool isConfirmation;
}

/// A password field with a strength bar, ready to use inside a [Form].
///
/// The form is valid only when the password reaches
/// [minimumStrengthRequired]:
///
/// ```dart
/// PasswordStrengthFormChecker(
///   minimumStrengthRequired: PasswordStrength.secure,
///   strengthCalculator: (text) => PasswordStrength.calculate(text: text),
/// )
/// ```
class PasswordStrengthFormChecker<T extends PasswordStrengthItem>
    extends StatefulWidget {
  /// Creates a [PasswordStrengthFormChecker].
  const PasswordStrengthFormChecker({
    super.key,
    required this.minimumStrengthRequired,
    required this.strengthCalculator,
    this.onChanged,
    this.controller,
    this.confirmationController,
    this.focusNode,
    this.decoration = const InputDecoration(
      border: OutlineInputBorder(),
      labelText: 'Password',
    ),
    this.confirmationDecoration = const InputDecoration(
      border: OutlineInputBorder(),
      labelText: 'Confirm password',
    ),
    this.obscureText = true,
    this.autofillHints = const [AutofillHints.newPassword],
    this.autovalidateMode,
    this.fieldBuilder,
    this.emptyTextErrorMessage = 'Password cannot be empty',
    this.errorMessage = 'Password is not strong enough',
    this.confirmationErrorMessage = 'Passwords do not match',
    this.hideErrorMessage = false,
    this.hideConfirmationErrorMessageWhenEmpty = false,
    this.topInstructions,
    this.needConfirmation = false,
    this.passwordStrengthCheckerConfiguration =
        const PasswordStrengthCheckerConfiguration(),
    this.showGenerator = false,
    this.passwordGeneratorConfiguration =
        const PasswordGeneratorConfiguration(),
    this.onPasswordGenerated,
    this.generateButtonStyle,
    this.generateButtonChild = const Text('Generate password'),
    this.automaticallyFillWithGeneratedPassword = true,
  });

  /// The minimum strength the password must reach to be valid.
  final T minimumStrengthRequired;

  /// Computes the strength of a password, e.g. `PasswordStrength.calculate`.
  final T? Function(String password) strengthCalculator;

  /// Called whenever the password or its strength changes.
  final void Function(String password, T? strength)? onChanged;

  /// The controller of the password field. One is created if `null`.
  final TextEditingController? controller;

  /// The controller of the confirmation field. One is created if `null`.
  final TextEditingController? confirmationController;

  /// The focus node of the password field.
  final FocusNode? focusNode;

  /// The decoration of the password field.
  final InputDecoration decoration;

  /// The decoration of the confirmation field.
  final InputDecoration confirmationDecoration;

  /// Whether the fields hide the text.
  final bool obscureText;

  /// The autofill hints of the password field.
  final Iterable<String>? autofillHints;

  /// When the fields validate themselves.
  final AutovalidateMode? autovalidateMode;

  /// Replaces the default [TextFormField]s with your own fields.
  final PasswordFieldBuilder? fieldBuilder;

  /// The error shown when the password is empty.
  final String emptyTextErrorMessage;

  /// The error shown when the password is not strong enough.
  final String errorMessage;

  /// The error shown when the confirmation does not match.
  final String confirmationErrorMessage;

  /// Whether to hide error texts. The fields still turn invalid.
  final bool hideErrorMessage;

  /// Whether to hide the confirmation error while the confirmation is empty.
  final bool hideConfirmationErrorMessageWhenEmpty;

  /// A widget shown above the password field.
  final Widget? topInstructions;

  /// Whether to show a confirmation field.
  final bool needConfirmation;

  /// The look and feel of the strength bar.
  final PasswordStrengthCheckerConfiguration
  passwordStrengthCheckerConfiguration;

  /// Whether to show a button that generates a password.
  final bool showGenerator;

  /// The rules used by the generate button.
  final PasswordGeneratorConfiguration passwordGeneratorConfiguration;

  /// Called with every generated password.
  final ValueChanged<String>? onPasswordGenerated;

  /// The style of the generate button.
  final ButtonStyle? generateButtonStyle;

  /// The content of the generate button.
  final Widget generateButtonChild;

  /// Whether a generated password fills the fields.
  final bool automaticallyFillWithGeneratedPassword;

  @override
  State<PasswordStrengthFormChecker<T>> createState() =>
      _PasswordStrengthFormCheckerState<T>();
}

class _PasswordStrengthFormCheckerState<T extends PasswordStrengthItem>
    extends State<PasswordStrengthFormChecker<T>> {
  final _strength = ValueNotifier<T?>(null);
  TextEditingController? _ownController;
  TextEditingController? _ownConfirmation;
  String? _lastText;

  TextEditingController get _controller =>
      widget.controller ?? (_ownController ??= TextEditingController());

  TextEditingController get _confirmation =>
      widget.confirmationController ??
      (_ownConfirmation ??= TextEditingController());

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
    _update(_controller.text, notify: false);
  }

  @override
  void didUpdateWidget(PasswordStrengthFormChecker<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final old = oldWidget.controller ?? _ownController;
    if (old != _controller) {
      old?.removeListener(_onTextChanged);
      _controller.addListener(_onTextChanged);
      _update(_controller.text);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _ownController?.dispose();
    _ownConfirmation?.dispose();
    _strength.dispose();
    super.dispose();
  }

  void _onTextChanged() => _update(_controller.text);

  void _update(String text, {bool notify = true}) {
    if (text == _lastText) return;
    _lastText = text;
    final strength = text.isEmpty ? null : widget.strengthCalculator(text);
    _strength.value = strength;
    if (notify) widget.onChanged?.call(text, strength);
  }

  String? _error(String message) => widget.hideErrorMessage ? '' : message;

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return _error(widget.emptyTextErrorMessage);
    }
    final strength = widget.strengthCalculator(value);
    if (strength == null ||
        strength.index < widget.minimumStrengthRequired.index) {
      return _error(widget.errorMessage);
    }
    return null;
  }

  String? _validateConfirmation(String? value) {
    if (value == _controller.text) return null;
    if ((value ?? '').isEmpty && widget.hideConfirmationErrorMessageWhenEmpty) {
      return '';
    }
    return _error(widget.confirmationErrorMessage);
  }

  void _generate() {
    final password = PasswordGenerator(
      widget.passwordGeneratorConfiguration,
    ).generate();
    if (widget.automaticallyFillWithGeneratedPassword) {
      _controller.text = password;
      if (widget.needConfirmation) _confirmation.text = password;
    }
    widget.onPasswordGenerated?.call(password);
  }

  Widget _field(PasswordFieldData data, InputDecoration decoration) {
    if (widget.fieldBuilder case final builder?) {
      return builder(context, data);
    }
    return TextFormField(
      controller: data.controller,
      focusNode: data.focusNode,
      validator: data.validator,
      decoration: decoration,
      obscureText: widget.obscureText,
      autocorrect: false,
      enableSuggestions: false,
      autofillHints: data.isConfirmation ? null : widget.autofillHints,
      autovalidateMode: widget.autovalidateMode,
      keyboardType: TextInputType.visiblePassword,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ?widget.topInstructions,
        _field(
          PasswordFieldData._(
            controller: _controller,
            focusNode: widget.focusNode,
            validator: _validatePassword,
            isConfirmation: false,
          ),
          widget.decoration,
        ),
        if (widget.needConfirmation) ...[
          const SizedBox(height: 10),
          _field(
            PasswordFieldData._(
              controller: _confirmation,
              validator: _validateConfirmation,
              isConfirmation: true,
            ),
            widget.confirmationDecoration,
          ),
        ],
        const SizedBox(height: 20),
        PasswordStrengthChecker<T>(
          strength: _strength,
          configuration: widget.passwordStrengthCheckerConfiguration,
        ),
        if (widget.showGenerator) ...[
          const SizedBox(height: 20),
          FilledButton.tonal(
            style: widget.generateButtonStyle,
            onPressed: _generate,
            child: widget.generateButtonChild,
          ),
        ],
      ],
    );
  }
}
