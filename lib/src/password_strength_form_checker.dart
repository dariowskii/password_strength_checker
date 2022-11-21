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
  const PasswordStrengthFormChecker({
    Key? key,
    required this.onChanged,
    required this.minimumStrengthRequired,
    this.emptyTextErrorMessage = 'Password cannot be empty',
    this.errorMessage = 'Password is not strong enough',
    this.confirmationErrorMessage = 'Passwords do not match',
    this.hideErrorMessage = false,
    this.hideConfirmationErrorMessageWhenEmpty = false,
    this.topInstructions,
    this.needConfirmation = true,
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
  }) : super(key: key);

  /// The function that will be called when the text changes. You need to update the [ValueNotifier] to update the widget.
  final Function(String password, ValueNotifier<T?> strengthNotifier) onChanged;

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

  /// If true, the confirmation field will be shown. If true, you need to set the [textFormFieldConfiguration.controller] to work.
  final bool needConfirmation;

  /// The configuration for the password field [TextFormField].
  final TextFormFieldConfiguration textFormFieldConfiguration;

  /// The configuration for the confirmation field [TextFormField].
  final TextFormFieldConfiguration confirmationTextFormFieldConfiguration;

  /// The configuration for the [PasswordStrengthChecker].
  final PasswordStrengthCheckerConfiguration
      passwordStrengthCheckerConfiguration;

  @override
  State<PasswordStrengthFormChecker<T>> createState() =>
      _PasswordStrengthFormCheckerState<T>();
}

class _PasswordStrengthFormCheckerState<T extends PasswordStrengthItem>
    extends State<PasswordStrengthFormChecker<T>> {
  final passNotifier = ValueNotifier<T?>(null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.topInstructions != null) widget.topInstructions!,
        TextFormField(
          decoration: widget.textFormFieldConfiguration.decoration,
          onChanged: (value) => widget.onChanged(value, passNotifier),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return widget.hideErrorMessage
                  ? ''
                  : widget.emptyTextErrorMessage;
            }
            final strength = passNotifier.value!;
            if (strength.index < widget.minimumStrengthRequired.index) {
              return widget.hideErrorMessage ? '' : widget.errorMessage;
            }
            return null;
          },
          key: widget.textFormFieldConfiguration.key,
          controller: widget.textFormFieldConfiguration.controller,
          focusNode: widget.textFormFieldConfiguration.focusNode,
          autofocus: widget.textFormFieldConfiguration.autofocus,
          textInputAction: widget.textFormFieldConfiguration.textInputAction,
          textCapitalization:
              widget.textFormFieldConfiguration.textCapitalization,
          style: widget.textFormFieldConfiguration.style,
          textAlign: widget.textFormFieldConfiguration.textAlign,
          textDirection: widget.textFormFieldConfiguration.textDirection,
          readOnly: widget.textFormFieldConfiguration.readOnly,
          toolbarOptions: widget.textFormFieldConfiguration.toolbarOptions,
          showCursor: widget.textFormFieldConfiguration.showCursor,
          obscuringCharacter:
              widget.textFormFieldConfiguration.obscuringCharacter,
          obscureText: widget.textFormFieldConfiguration.obscureText,
          autocorrect: widget.textFormFieldConfiguration.autocorrect,
          smartDashesType: widget.textFormFieldConfiguration.smartDashesType,
          smartQuotesType: widget.textFormFieldConfiguration.smartQuotesType,
          enableSuggestions:
              widget.textFormFieldConfiguration.enableSuggestions,
          maxLines: widget.textFormFieldConfiguration.maxLines,
          minLines: widget.textFormFieldConfiguration.minLines,
          expands: widget.textFormFieldConfiguration.expands,
          maxLength: widget.textFormFieldConfiguration.maxLength,
          maxLengthEnforcement:
              widget.textFormFieldConfiguration.maxLengthEnforcement,
          onEditingComplete:
              widget.textFormFieldConfiguration.onEditingComplete,
          onFieldSubmitted: widget.textFormFieldConfiguration.onFieldSubmitted,
          onSaved: widget.textFormFieldConfiguration.onSaved,
          inputFormatters: widget.textFormFieldConfiguration.inputFormatters,
          enabled: widget.textFormFieldConfiguration.enabled,
          cursorWidth: widget.textFormFieldConfiguration.cursorWidth,
          cursorHeight: widget.textFormFieldConfiguration.cursorHeight,
          cursorRadius: widget.textFormFieldConfiguration.cursorRadius,
          cursorColor: widget.textFormFieldConfiguration.cursorColor,
          keyboardAppearance:
              widget.textFormFieldConfiguration.keyboardAppearance,
          scrollPadding: widget.textFormFieldConfiguration.scrollPadding,
          enableInteractiveSelection:
              widget.textFormFieldConfiguration.enableInteractiveSelection,
          selectionControls:
              widget.textFormFieldConfiguration.selectionControls,
          onTap: widget.textFormFieldConfiguration.onTap,
          buildCounter: widget.textFormFieldConfiguration.buildCounter,
          scrollPhysics: widget.textFormFieldConfiguration.scrollPhysics,
          autofillHints: widget.textFormFieldConfiguration.autofillHints,
          autovalidateMode: widget.textFormFieldConfiguration.autovalidateMode,
          restorationId: widget.textFormFieldConfiguration.restorationId,
          enableIMEPersonalizedLearning:
              widget.textFormFieldConfiguration.enableIMEPersonalizedLearning,
          mouseCursor: widget.textFormFieldConfiguration.mouseCursor,
        ),
        if (widget.needConfirmation &&
            widget.textFormFieldConfiguration.controller != null) ...[
          const SizedBox(height: 10),
          TextFormField(
            decoration:
                widget.confirmationTextFormFieldConfiguration.decoration,
            validator: (value) {
              if (value == null ||
                  (value.isEmpty &&
                      !widget.hideConfirmationErrorMessageWhenEmpty) ||
                  value != widget.textFormFieldConfiguration.controller!.text) {
                return widget.confirmationErrorMessage;
              }
              return null;
            },
            key: widget.confirmationTextFormFieldConfiguration.key,
            controller:
                widget.confirmationTextFormFieldConfiguration.controller,
            focusNode: widget.confirmationTextFormFieldConfiguration.focusNode,
            autofocus: widget.confirmationTextFormFieldConfiguration.autofocus,
            textInputAction:
                widget.confirmationTextFormFieldConfiguration.textInputAction,
            textCapitalization: widget
                .confirmationTextFormFieldConfiguration.textCapitalization,
            style: widget.confirmationTextFormFieldConfiguration.style,
            textAlign: widget.confirmationTextFormFieldConfiguration.textAlign,
            textDirection:
                widget.confirmationTextFormFieldConfiguration.textDirection,
            readOnly: widget.confirmationTextFormFieldConfiguration.readOnly,
            toolbarOptions:
                widget.confirmationTextFormFieldConfiguration.toolbarOptions,
            showCursor:
                widget.confirmationTextFormFieldConfiguration.showCursor,
            obscuringCharacter: widget
                .confirmationTextFormFieldConfiguration.obscuringCharacter,
            obscureText:
                widget.confirmationTextFormFieldConfiguration.obscureText,
            autocorrect:
                widget.confirmationTextFormFieldConfiguration.autocorrect,
            smartDashesType:
                widget.confirmationTextFormFieldConfiguration.smartDashesType,
            smartQuotesType:
                widget.confirmationTextFormFieldConfiguration.smartQuotesType,
            enableSuggestions:
                widget.confirmationTextFormFieldConfiguration.enableSuggestions,
            maxLines: widget.confirmationTextFormFieldConfiguration.maxLines,
            minLines: widget.confirmationTextFormFieldConfiguration.minLines,
            expands: widget.confirmationTextFormFieldConfiguration.expands,
            maxLength: widget.confirmationTextFormFieldConfiguration.maxLength,
            maxLengthEnforcement: widget
                .confirmationTextFormFieldConfiguration.maxLengthEnforcement,
            onEditingComplete:
                widget.confirmationTextFormFieldConfiguration.onEditingComplete,
            onFieldSubmitted:
                widget.confirmationTextFormFieldConfiguration.onFieldSubmitted,
            onSaved: widget.confirmationTextFormFieldConfiguration.onSaved,
            inputFormatters:
                widget.confirmationTextFormFieldConfiguration.inputFormatters,
            enabled: widget.confirmationTextFormFieldConfiguration.enabled,
            mouseCursor:
                widget.confirmationTextFormFieldConfiguration.mouseCursor,
          ),
        ],
        const SizedBox(height: 20),
        PasswordStrengthChecker(
          strength: passNotifier,
          configuration: widget.passwordStrengthCheckerConfiguration,
        ),
      ],
    );
  }
}
