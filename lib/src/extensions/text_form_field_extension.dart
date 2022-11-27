import 'package:flutter/material.dart';

import '../../password_strength_checker.dart';

extension FromConfig on TextFormField {

  /// Creates a [TextFormField] based on the [TextFormFieldConfiguration].
  TextFormField fromConfig(
      {required TextFormFieldConfiguration configuration}) {
    return TextFormField(
      decoration: configuration.decoration,
      validator: configuration.validator,
      key: configuration.key,
      controller: configuration.controller,
      focusNode: configuration.focusNode,
      autofocus: configuration.autofocus,
      textInputAction: configuration.textInputAction,
      textCapitalization: configuration.textCapitalization,
      style: configuration.style,
      textAlign: configuration.textAlign,
      textDirection: configuration.textDirection,
      readOnly: configuration.readOnly,
      toolbarOptions: configuration.toolbarOptions,
      showCursor: configuration.showCursor,
      obscuringCharacter: configuration.obscuringCharacter,
      obscureText: configuration.obscureText,
      autocorrect: configuration.autocorrect,
      smartDashesType: configuration.smartDashesType,
      smartQuotesType: configuration.smartQuotesType,
      enableSuggestions: configuration.enableSuggestions,
      maxLines: configuration.maxLines,
      minLines: configuration.minLines,
      expands: configuration.expands,
      maxLength: configuration.maxLength,
      maxLengthEnforcement: configuration.maxLengthEnforcement,
      onEditingComplete: configuration.onEditingComplete,
      onFieldSubmitted: configuration.onFieldSubmitted,
      onSaved: configuration.onSaved,
      inputFormatters: configuration.inputFormatters,
      enabled: configuration.enabled,
      cursorWidth: configuration.cursorWidth,
      cursorHeight: configuration.cursorHeight,
      cursorRadius: configuration.cursorRadius,
      cursorColor: configuration.cursorColor,
      keyboardAppearance: configuration.keyboardAppearance,
      scrollPadding: configuration.scrollPadding,
      enableInteractiveSelection: configuration.enableInteractiveSelection,
      selectionControls: configuration.selectionControls,
      onTap: configuration.onTap,
      buildCounter: configuration.buildCounter,
      scrollPhysics: configuration.scrollPhysics,
      autofillHints: configuration.autofillHints,
      restorationId: configuration.restorationId,
      enableIMEPersonalizedLearning:
          configuration.enableIMEPersonalizedLearning,
      mouseCursor: configuration.mouseCursor,
    );
  }
}
