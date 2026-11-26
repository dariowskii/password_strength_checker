import 'package:flutter/material.dart';

/// The look and feel of a [PasswordStrengthChecker].
final class PasswordStrengthCheckerConfiguration {
  /// Creates a [PasswordStrengthCheckerConfiguration].
  const PasswordStrengthCheckerConfiguration({
    this.width = double.infinity,
    this.height = 20,
    this.leftToRight = true,
    this.showStatusWidget = true,
    this.statusWidgetAlignment = AlignmentDirectional.centerStart,
    this.statusMargin = const EdgeInsets.only(top: 10, left: 10),
    this.animationDuration = const Duration(milliseconds: 600),
    this.animationCurve = Curves.easeInOut,
    this.hasBorder = true,
    this.borderWidth = 2,
    this.borderColor,
    this.inactiveBorderColor,
    this.externalBorderRadius = const BorderRadius.all(Radius.circular(10)),
    this.internalBorderRadius = const BorderRadius.all(Radius.circular(10)),
    this.semanticsLabel = 'Password strength',
  });

  /// The width of the bar.
  final double width;

  /// The height of the bar.
  final double height;

  /// Whether the bar fills from left to right.
  final bool leftToRight;

  /// Whether the status widget is shown under the bar.
  final bool showStatusWidget;

  /// The alignment of the status widget.
  final AlignmentGeometry statusWidgetAlignment;

  /// The margin around the status widget.
  final EdgeInsetsGeometry statusMargin;

  /// The duration of the fill and color animation.
  final Duration animationDuration;

  /// The curve of the fill and color animation.
  final Curve animationCurve;

  /// Whether the bar has a border.
  final bool hasBorder;

  /// The width of the border.
  final double borderWidth;

  /// A fixed border color. When `null`, the border takes the strength color.
  final Color? borderColor;

  /// The border color when there is no strength yet.
  ///
  /// Defaults to [ColorScheme.outlineVariant], so it adapts to dark mode.
  final Color? inactiveBorderColor;

  /// The border radius of the bar.
  final BorderRadiusGeometry? externalBorderRadius;

  /// The border radius of the fill.
  final BorderRadiusGeometry? internalBorderRadius;

  /// The label announced by screen readers.
  final String semanticsLabel;
}
