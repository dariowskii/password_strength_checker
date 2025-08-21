import 'package:flutter/material.dart';

import '../password_strength_checker.dart';

/// The widget to use into a [Form] widget.
///
/// You need to set a [minimumStrengthRequired] for the password field,
/// in this way the form will not be valid until at least the indicated
/// security level is reached.
///
/// You need also to set a [onChanged] callback to manage the current strength
/// of the password based on the text. For example:
///
/// ```
/// PasswordStrengthFormChecker(
///   minimumStrengthRequired: PasswordStrength.secure,
///   onChanged: (password, notifier) {
///     notifier.value = PasswordStrength.calculate(text: password);
///   },
/// ),
/// ```
class PasswordStrengthFormChecker<T extends PasswordStrengthItem>
    extends StatefulWidget {
  /// Creates a [PasswordStrengthFormChecker] widget with the specified parameters.
  const PasswordStrengthFormChecker({
    super.key,
    required this.onChanged,
    required this.minimumStrengthRequired,
    this.emptyTextErrorMessage = 'Password cannot be empty',
    this.errorMessage = 'Password is not strong enough',
    this.confirmationErrorMessage = 'Passwords do not match',
    this.hideErrorMessage = false,
    this.hideConfirmationErrorMessageWhenEmpty = false,
    this.topInstructions,
    this.needConfirmation = false,
    this.textFormFieldConfiguration = const TextFormFieldConfiguration(),
    this.confirmationTextFormFieldConfiguration =
        const TextFormFieldConfiguration(
      decoration: InputDecoration(
        errorStyle: TextStyle(height: 0),
        border: OutlineInputBorder(),
        labelText: 'Confirm Password',
      ),
    ),
    this.passwordStrengthCheckerConfiguration =
        const PasswordStrengthCheckerConfiguration(),
    this.showGenerator = false,
    this.passwordGeneratorConfiguration =
        const PasswordGeneratorConfiguration(),
    this.onPasswordGenerated,
    this.generateButtonStyle,
    this.generateButtonChild = const Text("Generate Password"),
    this.generateButtonSize = const Size(double.maxFinite, 48),
    this.automaticallyFillWithGeneratedPassword = true,
  });

  /// The function that will be called when the text changes. You need to update the [ValueNotifier] to update the widget.
  final void Function(String password, ValueNotifier<T?> strengthNotifier)
      onChanged;

  /// The minimum strength required to consider the password strong enough.
  final T minimumStrengthRequired;

  /// The text to show when the password is empty.
  final String? emptyTextErrorMessage;

  /// The text to show when the password is not strong enough.
  final String errorMessage;

  /// The text to show when the password confirmation is not the same as the password.
  final String confirmationErrorMessage;

  /// If true, the confirmation error message will not be shown when the confirmation is empty.
  final bool hideConfirmationErrorMessageWhenEmpty;

  /// If true, the error message will not be shown.
  final bool hideErrorMessage;

  /// The instructions to show above the password field.
  final Widget? topInstructions;

  /// If true, you need to set the [textFormFieldConfiguration.controller] to work and the confirmation field will be shown.
  final bool needConfirmation;

  /// The configuration for the password field [TextFormField].
  final TextFormFieldConfiguration textFormFieldConfiguration;

  /// The configuration for the confirmation field [TextFormField].
  final TextFormFieldConfiguration confirmationTextFormFieldConfiguration;

  /// The configuration for the [PasswordStrengthChecker].
  final PasswordStrengthCheckerConfiguration
      passwordStrengthCheckerConfiguration;

  /// If true, a button to generate a password will be shown.
  final bool showGenerator;

  /// The configuration for the [PasswordGenerator].
  final PasswordGeneratorConfiguration passwordGeneratorConfiguration;

  /// The function that will be called when the password is generated.
  final Function(String password, ValueNotifier<T?> strengthNotifier)?
      onPasswordGenerated;

  /// The style for the generate button.
  final ButtonStyle? generateButtonStyle;

  /// The child for the generate button.
  final Widget? generateButtonChild;

  /// The size for the generate button.
  final Size generateButtonSize;

  /// Fill the fields with the generated [password].
  final bool automaticallyFillWithGeneratedPassword;

  @override
  State<PasswordStrengthFormChecker<T>> createState() =>
      _PasswordStrengthFormCheckerState<T>();
}

class _PasswordStrengthFormCheckerState<T extends PasswordStrengthItem>
    extends State<PasswordStrengthFormChecker<T>> {
  late final _passNotifier = ValueNotifier<T?>(null);
  late var _passwordGenerator = PasswordGenerator.fromConfig(
    configuration: widget.passwordGeneratorConfiguration,
  );

  @override
  void dispose() {
    _passNotifier.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant PasswordStrengthFormChecker<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.passwordGeneratorConfiguration !=
        widget.passwordGeneratorConfiguration) {
      _passwordGenerator = PasswordGenerator.fromConfig(
        configuration: widget.passwordGeneratorConfiguration,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.topInstructions != null) widget.topInstructions!,
        TextFormField().fromConfig(
          configuration: widget.textFormFieldConfiguration.copyWith(
            onChanged: (value) => widget.onChanged(value, _passNotifier),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return widget.hideErrorMessage
                    ? ''
                    : widget.emptyTextErrorMessage;
              }
              final strength = _passNotifier.value!;
              if (strength.index < widget.minimumStrengthRequired.index) {
                return widget.hideErrorMessage ? '' : widget.errorMessage;
              }
              return null;
            },
          ),
        ),
        if (widget.needConfirmation &&
            widget.textFormFieldConfiguration.controller != null) ...[
          const SizedBox(height: 10),
          TextFormField().fromConfig(
            configuration:
                widget.confirmationTextFormFieldConfiguration.copyWith(
              validator: (value) {
                if (value == null ||
                    (value.isEmpty &&
                        !widget.hideConfirmationErrorMessageWhenEmpty) ||
                    value !=
                        widget.textFormFieldConfiguration.controller!.text) {
                  return widget.confirmationErrorMessage;
                }
                return null;
              },
            ),
          ),
        ],
        const SizedBox(height: 20),
        PasswordStrengthChecker(
          strength: _passNotifier,
          configuration: widget.passwordStrengthCheckerConfiguration,
        ),
        if (widget.showGenerator) ...[
          const SizedBox(height: 20),
          SizedBox(
            width: widget.generateButtonSize.width,
            height: widget.generateButtonSize.height,
            child: ElevatedButton(
              style: widget.generateButtonStyle,
              onPressed: () {
                final password = _passwordGenerator.generate();

                if (widget.automaticallyFillWithGeneratedPassword) {
                  widget.textFormFieldConfiguration.controller?.text = password;
                  widget.confirmationTextFormFieldConfiguration.controller
                      ?.text = password;
                }

                widget.onPasswordGenerated?.call(password, _passNotifier);
              },
              child: widget.generateButtonChild,
            ),
          ),
        ],
      ],
    );
  }
}
