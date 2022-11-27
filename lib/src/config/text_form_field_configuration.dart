import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Helper class that contains the [TextFormField] configuration.
class TextFormFieldConfiguration {
  /// The TextFormField key.
  final Key? key;

  /// The TextFormField controller.
  final TextEditingController? controller;

  /// The TextFormField initialValue.
  final String? initialValue;

  /// The TextFormField validator.
  final String? Function(String?)? validator;

  /// The TextFormField onChanged callback.
  final Function(String)? onChanged;

  /// The TextFormField decoration.
  final InputDecoration? decoration;

  /// The TextFormField focusNode.
  final FocusNode? focusNode;

  /// The TextFormField keyboardType.
  final TextInputType? keyboardType;

  /// The TextFormField textInputAction.
  final TextInputAction? textInputAction;

  /// The TextFormField textCapitalization.
  final TextCapitalization textCapitalization;

  /// The TextFormField style.
  final TextStyle? style;

  /// The TextFormField strutStyle.
  final StrutStyle? strutStyle;

  /// The TextFormField textAlign.
  final TextAlign textAlign;

  /// The TextFormField textDirection.
  final TextDirection? textDirection;

  /// The TextFormField textAlignVertical.
  final TextAlignVertical? textAlignVertical;

  /// The TextFormField autofocus.
  final bool autofocus;

  /// The TextFormField readOnly.
  final bool readOnly;

  /// The TextFormField toolbarOptions.
  final ToolbarOptions? toolbarOptions;

  /// The TextFormField showCursor.
  final bool? showCursor;

  /// The TextFormField obscuringCharacter.
  final String obscuringCharacter;

  /// The TextFormField obscureText.
  final bool obscureText;

  /// The TextFormField autocorrect.
  final bool autocorrect;

  /// The TextFormField smartDashesType.
  final SmartDashesType? smartDashesType;

  /// The TextFormField smartQuotesType.
  final SmartQuotesType? smartQuotesType;

  /// The TextFormField enableSuggestions.
  final bool enableSuggestions;

  /// The TextFormField maxLines.
  final int? maxLines;

  /// The TextFormField minLines.
  final int? minLines;

  /// The TextFormField maxLengthEnforcement.
  final MaxLengthEnforcement? maxLengthEnforcement;

  /// The TextFormField expands.
  final bool expands;

  /// The TextFormField maxLength.
  final int? maxLength;

  /// The TextFormField onTap.
  final void Function()? onTap;

  /// The TextFormField onEditingComplete.
  final void Function()? onEditingComplete;

  /// The TextFormField onFieldSubmitted.
  final void Function(String)? onFieldSubmitted;

  /// The TextFormField onSaved.
  final void Function(String?)? onSaved;

  /// The TextFormField inputFormatters.
  final List<TextInputFormatter>? inputFormatters;

  /// The TextFormField enabled.
  final bool? enabled;

  /// The TextFormField cursorWidth.
  final double cursorWidth;

  /// The TextFormField cursorHeight.
  final double? cursorHeight;

  /// The TextFormField cursorRadius.
  final Radius? cursorRadius;

  /// The TextFormField cursorColor.
  final Color? cursorColor;

  /// The TextFormField keyboardAppearance.
  final Brightness? keyboardAppearance;

  /// The TextFormField scrollPadding.
  final EdgeInsets scrollPadding;

  /// The TextFormField enableInteractiveSelection.
  final bool? enableInteractiveSelection;

  /// The TextFormField selectionControls.
  final TextSelectionControls? selectionControls;

  /// The TextFormField buildCounter.
  final Widget? Function(BuildContext,
      {required int currentLength,
      required bool isFocused,
      required int? maxLength})? buildCounter;

  /// The TextFormField scrollPhysics.
  final ScrollPhysics? scrollPhysics;

  /// The TextFormField autofillHints.
  final Iterable<String>? autofillHints;

  /// The TextFormField autovalidateMode.
  final AutovalidateMode? autovalidateMode;

  /// The TextFormField restorationId.
  final String? restorationId;

  /// The TextFormField scrollController.
  final ScrollController? scrollController;

  /// The TextFormField enableIMEPersonalizedLearning.
  final bool enableIMEPersonalizedLearning;

  /// The TextFormField mouseCursor.
  final MouseCursor? mouseCursor;

  const TextFormFieldConfiguration({
    this.key,
    this.controller,
    this.initialValue,
    this.validator,
    this.onChanged,
    this.focusNode,
    this.decoration = const InputDecoration(
      errorStyle: TextStyle(height: 0),
      border: OutlineInputBorder(),
      labelText: 'Password',
    ),
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.style,
    this.strutStyle,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.autofocus = false,
    this.readOnly = false,
    this.toolbarOptions,
    this.showCursor,
    this.obscuringCharacter = '•',
    this.obscureText = true,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.maxLengthEnforcement,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection,
    this.selectionControls,
    this.buildCounter,
    this.scrollPhysics,
    this.autofillHints,
    this.autovalidateMode,
    this.scrollController,
    this.restorationId,
    this.enableIMEPersonalizedLearning = true,
    this.mouseCursor,
  });

  TextFormFieldConfiguration copyWith({
    Key? key,
    TextEditingController? controller,
    String? initialValue,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    FocusNode? focusNode,
    InputDecoration? decoration,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    TextCapitalization? textCapitalization,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    TextAlignVertical? textAlignVertical,
    bool? autofocus,
    bool? readOnly,
    ToolbarOptions? toolbarOptions,
    bool? showCursor,
    String? obscuringCharacter,
    bool? obscureText,
    bool? autocorrect,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool? enableSuggestions,
    int? maxLines,
    int? minLines,
    MaxLengthEnforcement? maxLengthEnforcement,
    bool? expands,
    int? maxLength,
    void Function()? onTap,
    void Function()? onEditingComplete,
    void Function(String)? onFieldSubmitted,
    void Function(String?)? onSaved,
    List<TextInputFormatter>? inputFormatters,
    bool? enabled,
    double? cursorWidth,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    Brightness? keyboardAppearance,
    EdgeInsets? scrollPadding,
    bool? enableInteractiveSelection,
    TextSelectionControls? selectionControls,
    Widget? Function(BuildContext,
            {required int currentLength,
            required bool isFocused,
            required int? maxLength})?
        buildCounter,
    ScrollPhysics? scrollPhysics,
    Iterable<String>? autofillHints,
    AutovalidateMode? autovalidateMode,
    String? restorationId,
    ScrollController? scrollController,
    bool? enableIMEPersonalizedLearning,
    MouseCursor? mouseCursor,
  }) {
    return TextFormFieldConfiguration(
      key: key ?? this.key,
      controller: controller ?? this.controller,
      initialValue: initialValue ?? this.initialValue,
      validator: validator ?? this.validator,
      focusNode: focusNode ?? this.focusNode,
      decoration: decoration ?? this.decoration,
      keyboardType: keyboardType ?? this.keyboardType,
      textInputAction: textInputAction ?? this.textInputAction,
      textCapitalization: textCapitalization ?? this.textCapitalization,
      style: style ?? this.style,
      strutStyle: strutStyle ?? this.strutStyle,
      textAlign: textAlign ?? this.textAlign,
      textDirection: textDirection ?? this.textDirection,
      textAlignVertical: textAlignVertical ?? this.textAlignVertical,
      autofocus: autofocus ?? this.autofocus,
      readOnly: readOnly ?? this.readOnly,
      toolbarOptions: toolbarOptions ?? this.toolbarOptions,
      showCursor: showCursor ?? this.showCursor,
      obscuringCharacter: obscuringCharacter ?? this.obscuringCharacter,
      obscureText: obscureText ?? this.obscureText,
      autocorrect: autocorrect ?? this.autocorrect,
      smartDashesType: smartDashesType ?? this.smartDashesType,
      smartQuotesType: smartQuotesType ?? this.smartQuotesType,
      enableSuggestions: enableSuggestions ?? this.enableSuggestions,
      maxLengthEnforcement: maxLengthEnforcement ?? this.maxLengthEnforcement,
      maxLines: maxLines ?? this.maxLines,
      minLines: minLines ?? this.minLines,
      expands: expands ?? this.expands,
      maxLength: maxLength ?? this.maxLength,
      onTap: onTap ?? this.onTap,
      onEditingComplete: onEditingComplete ?? this.onEditingComplete,
      onFieldSubmitted: onFieldSubmitted ?? this.onFieldSubmitted,
      onSaved: onSaved ?? this.onSaved,
      inputFormatters: inputFormatters ?? this.inputFormatters,
      enabled: enabled ?? this.enabled,
      cursorWidth: cursorWidth ?? this.cursorWidth,
      cursorHeight: cursorHeight ?? this.cursorHeight,
      cursorRadius: cursorRadius ?? this.cursorRadius,
      cursorColor: cursorColor ?? this.cursorColor,
      keyboardAppearance: keyboardAppearance ?? this.keyboardAppearance,
      scrollPadding: scrollPadding ?? this.scrollPadding,
      enableInteractiveSelection:
          enableInteractiveSelection ?? this.enableInteractiveSelection,
      selectionControls: selectionControls ?? this.selectionControls,
      buildCounter: buildCounter ?? this.buildCounter,
      scrollPhysics: scrollPhysics ?? this.scrollPhysics,
      autofillHints: autofillHints ?? this.autofillHints,
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
      restorationId: restorationId ?? this.restorationId,
      scrollController: scrollController ?? this.scrollController,
      enableIMEPersonalizedLearning:
          enableIMEPersonalizedLearning ?? this.enableIMEPersonalizedLearning,
      mouseCursor: mouseCursor ?? this.mouseCursor,
    );
  }
}
