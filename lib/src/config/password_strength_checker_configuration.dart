import 'package:flutter/material.dart';

/// The configuration for the [PasswordStrengthChecker] widget.
final class PasswordStrengthCheckerConfiguration {
  /// The width of the widget.
  final double width;

  /// The height of the widget.
  final double height;

  /// The direction of the animation.
  final bool leftToRight;

  /// The flag that indicates if the status widget should be shown.
  final bool showStatusWidget;

  /// The alignment of the status widget.
  final MainAxisAlignment statusWidgetAlignment;

  /// The margin of the status widget.
  final EdgeInsetsGeometry statusMargin;

  /// The duration of the animation.
  final Duration animationDuration;

  /// The curve of the animation.
  final Curve animationCurve;

  /// The flag that indicates if the widget has a border.
  final bool hasBorder;

  /// The width of the border.
  final double borderWidth;

  /// The color of the border.
  final Color? borderColor;

  /// The color of the inactive border.
  final Color inactiveBorderColor;

  /// The external border radius.
  final BorderRadiusGeometry? externalBorderRadius;

  /// The internal border radius.
  final BorderRadiusGeometry? internalBorderRadius;

  /// Creates a [PasswordStrengthCheckerConfiguration] with the specified parameters.
  const PasswordStrengthCheckerConfiguration({
    this.width = double.maxFinite,
    this.height = 20,
    this.leftToRight = true,
    this.showStatusWidget = true,
    this.statusWidgetAlignment = MainAxisAlignment.start,
    this.statusMargin = const EdgeInsets.only(top: 10, left: 10),
    this.animationDuration = const Duration(milliseconds: 600),
    this.animationCurve = Curves.easeInOut,
    this.hasBorder = true,
    this.borderWidth = 2,
    this.borderColor,
    this.inactiveBorderColor = Colors.black,
    this.externalBorderRadius = const BorderRadius.all(Radius.circular(10)),
    this.internalBorderRadius = const BorderRadius.all(Radius.circular(10)),
  });
}
