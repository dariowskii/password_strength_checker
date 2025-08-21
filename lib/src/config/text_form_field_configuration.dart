import 'dart:ui' show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Helper class that contains the [TextFormField] configuration.
final class TextFormFieldConfiguration {
  /// The widget key.
  final Key? key;

  /// The group ID for the text field.
  final Object groupId;

  /// The controller for the text field.
  final TextEditingController? controller;

  /// The initial value of the text field.
  final String? initialValue;

  /// The focus node for the text field.
  final FocusNode? focusNode;

  /// The error text to force display.
  final String? forceErrorText;

  /// The decoration for the text field.
  final InputDecoration? decoration;

  /// The keyboard type for the text field.
  final TextInputType? keyboardType;

  /// The text capitalization strategy.
  final TextCapitalization textCapitalization;

  /// The action button on the keyboard.
  final TextInputAction? textInputAction;

  /// The style to use for the text being edited.
  final TextStyle? style;

  /// The strut style for the text field.
  final StrutStyle? strutStyle;

  /// The text direction for the text field.
  final TextDirection? textDirection;

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// How the text should be aligned vertically.
  final TextAlignVertical? textAlignVertical;

  /// Whether the text field should focus itself if nothing else is already focused.
  final bool autofocus;

  /// Whether the text field is read-only.
  final bool readOnly;

  /// Toolbar options for the text field.
  final ToolbarOptions? toolbarOptions;

  /// Whether to show the cursor.
  final bool? showCursor;

  /// The character used for obscuring text if obscureText is true.
  final String obscuringCharacter;

  /// Whether to hide the text being edited (e.g. for passwords).
  final bool obscureText;

  /// Whether to enable autocorrect.
  final bool autocorrect;

  /// The type of smart dashes to use.
  final SmartDashesType? smartDashesType;

  /// The type of smart quotes to use.
  final SmartQuotesType? smartQuotesType;

  /// Whether to enable suggestions.
  final bool enableSuggestions;

  /// The enforcement of the max length limit.
  final MaxLengthEnforcement? maxLengthEnforcement;

  /// The maximum number of lines for the text field.
  final int? maxLines;

  /// The minimum number of lines for the text field.
  final int? minLines;

  /// Whether the text field expands to fill its parent.
  final bool expands;

  /// The maximum length of the text field.
  final int? maxLength;

  /// Called when the text field is tapped.
  final void Function()? onTap;

  /// Whether onTap is always called.
  final bool onTapAlwaysCalled;

  /// Called when a pointer that might cause a tap with a primary button has contacted the screen.
  final void Function(PointerDownEvent)? onTapOutside;

  /// Called when a pointer that might cause a tap with a primary button has stopped contacting the screen.
  final void Function(PointerUpEvent)? onTapUpOutside;

  /// Called when editing is complete.
  final void Function()? onEditingComplete;

  /// Called when the user indicates that they are done editing the text in the field.
  final void Function(String)? onFieldSubmitted;

  /// Called when the text field should save its current value.
  final void Function(String?)? onSaved;

  /// The error builder for the text field.
  final Widget Function(BuildContext, String)? errorBuilder;

  /// The list of input formatters to apply to the text field.
  final List<TextInputFormatter>? inputFormatters;

  /// Whether the text field is enabled.
  final bool? enabled;

  /// Whether to ignore pointer events.
  final bool? ignorePointers;

  /// The width of the cursor.
  final double cursorWidth;

  /// The height of the cursor.
  final double? cursorHeight;

  /// The radius of the cursor.
  final Radius? cursorRadius;

  /// The color of the cursor.
  final Color? cursorColor;

  /// The color of the cursor when in error state.
  final Color? cursorErrorColor;

  /// The appearance of the keyboard.
  final Brightness? keyboardAppearance;

  /// The amount of space by which to inset the text field.
  final EdgeInsets scrollPadding;

  /// Whether interactive selection is enabled for the text field.
  final bool? enableInteractiveSelection;

  /// Whether to select all text on focus.
  final bool? selectAllOnFocus;

  /// The selection controls for the text field.
  final TextSelectionControls? selectionControls;

  /// The build counter widget for the text field.
  final Widget? Function(BuildContext,
      {required int currentLength,
      required bool isFocused,
      required int? maxLength})? buildCounter;

  /// The scroll physics for the text field.
  final ScrollPhysics? scrollPhysics;

  /// The autofill hints for the text field.
  final Iterable<String>? autofillHints;

  /// The auto validation mode for the text field.
  final AutovalidateMode? autovalidateMode;

  /// The scroll controller for the text field.
  final ScrollController? scrollController;

  /// The restoration ID for the text field.
  final String? restorationId;

  /// Whether to enable IME personalized learning.
  final bool enableIMEPersonalizedLearning;

  /// The mouse cursor for the text field.
  final MouseCursor? mouseCursor;

  /// The context menu builder for the text field.
  final Widget Function(BuildContext, EditableTextState)? contextMenuBuilder;

  /// The spell check configuration for the text field.
  final SpellCheckConfiguration? spellCheckConfiguration;

  /// The text magnifier configuration for the text field.
  final TextMagnifierConfiguration? magnifierConfiguration;

  /// The undo history controller for the text field.
  final UndoHistoryController? undoController;

  /// Called when an app private command is received.
  final void Function(String, Map<String, dynamic>)? onAppPrivateCommand;

  /// Whether the cursor opacity animates.
  final bool? cursorOpacityAnimates;

  /// The selection height style.
  final BoxHeightStyle? selectionHeightStyle;

  /// The selection width style.
  final BoxWidthStyle? selectionWidthStyle;

  /// The drag start behavior for the text field.
  final DragStartBehavior dragStartBehavior;

  /// The content insertion configuration for the text field.
  final ContentInsertionConfiguration? contentInsertionConfiguration;

  /// The widget states controller for the text field.
  final WidgetStatesController? statesController;

  /// The clip behavior for the text field.
  final Clip clipBehavior;

  /// Whether scribble is enabled for the text field.
  final bool scribbleEnabled;

  /// Whether stylus handwriting is enabled for the text field.
  final bool stylusHandwritingEnabled;

  /// Whether the text field can request focus.
  final bool canRequestFocus;

  /// The list of hint locales for the text field.
  final List<Locale>? hintLocales;

  /// Creates a [TextFormFieldConfiguration] with the specified parameters.
  const TextFormFieldConfiguration({
    this.key,
    this.groupId = EditableText,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.forceErrorText,
    this.decoration = const InputDecoration(),
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
    this.obscureText = false,
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
    this.onTapAlwaysCalled = false,
    this.onTapOutside,
    this.onTapUpOutside,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.errorBuilder,
    this.inputFormatters,
    this.enabled,
    this.ignorePointers,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.cursorErrorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection,
    this.selectAllOnFocus,
    this.selectionControls,
    this.buildCounter,
    this.scrollPhysics,
    this.autofillHints,
    this.autovalidateMode,
    this.scrollController,
    this.restorationId,
    this.enableIMEPersonalizedLearning = true,
    this.mouseCursor,
    this.contextMenuBuilder,
    this.spellCheckConfiguration,
    this.magnifierConfiguration,
    this.undoController,
    this.onAppPrivateCommand,
    this.cursorOpacityAnimates,
    this.selectionHeightStyle,
    this.selectionWidthStyle,
    this.dragStartBehavior = DragStartBehavior.start,
    this.contentInsertionConfiguration,
    this.statesController,
    this.clipBehavior = Clip.hardEdge,
    this.scribbleEnabled = true,
    this.stylusHandwritingEnabled =
        EditableText.defaultStylusHandwritingEnabled,
    this.canRequestFocus = true,
    this.hintLocales,
  });

  /// Creates a copy of the [TextFormFieldConfiguration] with the given parameters.
  TextFormFieldConfiguration copyWith({
    Key? key,
    Object? groupId,
    TextEditingController? controller,
    String? initialValue,
    FocusNode? focusNode,
    String? forceErrorText,
    InputDecoration? decoration,
    TextInputType? keyboardType,
    TextCapitalization? textCapitalization,
    TextInputAction? textInputAction,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    TextAlign? textAlign,
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
    MaxLengthEnforcement? maxLengthEnforcement,
    int? maxLines,
    int? minLines,
    bool? expands,
    int? maxLength,
    void Function()? onTap,
    bool? onTapAlwaysCalled,
    void Function(PointerDownEvent)? onTapOutside,
    void Function(PointerUpEvent)? onTapUpOutside,
    void Function()? onEditingComplete,
    void Function(String)? onFieldSubmitted,
    void Function(String?)? onSaved,
    Widget Function(BuildContext, String)? errorBuilder,
    List<TextInputFormatter>? inputFormatters,
    bool? enabled,
    bool? ignorePointers,
    double? cursorWidth,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    Color? cursorErrorColor,
    Brightness? keyboardAppearance,
    EdgeInsets? scrollPadding,
    bool? enableInteractiveSelection,
    bool? selectAllOnFocus,
    TextSelectionControls? selectionControls,
    Widget? Function(BuildContext,
            {required int currentLength,
            required bool isFocused,
            required int? maxLength})?
        buildCounter,
    ScrollPhysics? scrollPhysics,
    Iterable<String>? autofillHints,
    AutovalidateMode? autovalidateMode,
    ScrollController? scrollController,
    String? restorationId,
    bool? enableIMEPersonalizedLearning,
    MouseCursor? mouseCursor,
    Widget Function(BuildContext, EditableTextState)? contextMenuBuilder,
    SpellCheckConfiguration? spellCheckConfiguration,
    TextMagnifierConfiguration? magnifierConfiguration,
    UndoHistoryController? undoController,
    void Function(String, Map<String, dynamic>)? onAppPrivateCommand,
    bool? cursorOpacityAnimates,
    BoxHeightStyle? selectionHeightStyle,
    BoxWidthStyle? selectionWidthStyle,
    DragStartBehavior? dragStartBehavior,
    ContentInsertionConfiguration? contentInsertionConfiguration,
    WidgetStatesController? statesController,
    Clip? clipBehavior,
    bool? scribbleEnabled,
    bool? stylusHandwritingEnabled,
    bool? canRequestFocus,
    List<Locale>? hintLocales,
  }) {
    return TextFormFieldConfiguration(
      key: key ?? this.key,
      groupId: groupId ?? this.groupId,
      controller: controller ?? this.controller,
      initialValue: initialValue ?? this.initialValue,
      focusNode: focusNode ?? this.focusNode,
      forceErrorText: forceErrorText ?? this.forceErrorText,
      decoration: decoration ?? this.decoration,
      keyboardType: keyboardType ?? this.keyboardType,
      textCapitalization: textCapitalization ?? this.textCapitalization,
      textInputAction: textInputAction ?? this.textInputAction,
      style: style ?? this.style,
      strutStyle: strutStyle ?? this.strutStyle,
      textDirection: textDirection ?? this.textDirection,
      textAlign: textAlign ?? this.textAlign,
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
      onTapAlwaysCalled: onTapAlwaysCalled ?? this.onTapAlwaysCalled,
      onTapOutside: onTapOutside ?? this.onTapOutside,
      onTapUpOutside: onTapUpOutside ?? this.onTapUpOutside,
      onEditingComplete: onEditingComplete ?? this.onEditingComplete,
      onFieldSubmitted: onFieldSubmitted ?? this.onFieldSubmitted,
      onSaved: onSaved ?? this.onSaved,
      errorBuilder: errorBuilder ?? this.errorBuilder,
      inputFormatters: inputFormatters ?? this.inputFormatters,
      enabled: enabled ?? this.enabled,
      ignorePointers: ignorePointers ?? this.ignorePointers,
      cursorWidth: cursorWidth ?? this.cursorWidth,
      cursorHeight: cursorHeight ?? this.cursorHeight,
      cursorRadius: cursorRadius ?? this.cursorRadius,
      cursorColor: cursorColor ?? this.cursorColor,
      cursorErrorColor: cursorErrorColor ?? this.cursorErrorColor,
      keyboardAppearance: keyboardAppearance ?? this.keyboardAppearance,
      scrollPadding: scrollPadding ?? this.scrollPadding,
      enableInteractiveSelection:
          enableInteractiveSelection ?? this.enableInteractiveSelection,
      selectAllOnFocus: selectAllOnFocus ?? this.selectAllOnFocus,
      selectionControls: selectionControls ?? this.selectionControls,
      buildCounter: buildCounter ?? this.buildCounter,
      scrollPhysics: scrollPhysics ?? this.scrollPhysics,
      autofillHints: autofillHints ?? this.autofillHints,
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
      scrollController: scrollController ?? this.scrollController,
      restorationId: restorationId ?? this.restorationId,
      enableIMEPersonalizedLearning:
          enableIMEPersonalizedLearning ?? this.enableIMEPersonalizedLearning,
      mouseCursor: mouseCursor ?? this.mouseCursor,
      contextMenuBuilder: contextMenuBuilder ?? this.contextMenuBuilder,
      spellCheckConfiguration:
          spellCheckConfiguration ?? this.spellCheckConfiguration,
      magnifierConfiguration:
          magnifierConfiguration ?? this.magnifierConfiguration,
      undoController: undoController ?? this.undoController,
      onAppPrivateCommand: onAppPrivateCommand ?? this.onAppPrivateCommand,
      cursorOpacityAnimates:
          cursorOpacityAnimates ?? this.cursorOpacityAnimates,
      selectionHeightStyle: selectionHeightStyle ?? this.selectionHeightStyle,
      selectionWidthStyle: selectionWidthStyle ?? this.selectionWidthStyle,
      dragStartBehavior: dragStartBehavior ?? this.dragStartBehavior,
      contentInsertionConfiguration:
          contentInsertionConfiguration ?? this.contentInsertionConfiguration,
      statesController: statesController ?? this.statesController,
      clipBehavior: clipBehavior ?? this.clipBehavior,
      scribbleEnabled: scribbleEnabled ?? this.scribbleEnabled,
      stylusHandwritingEnabled:
          stylusHandwritingEnabled ?? this.stylusHandwritingEnabled,
      canRequestFocus: canRequestFocus ?? this.canRequestFocus,
      hintLocales: hintLocales ?? this.hintLocales,
    );
  }
}
