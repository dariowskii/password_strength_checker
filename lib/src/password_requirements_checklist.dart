import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'rules/password_requirement.dart';

/// A live checklist that ticks each [PasswordRequirement] as the user types.
///
/// Pass the [TextEditingController] of your password field:
///
/// ```dart
/// PasswordRequirementsChecklist(
///   password: controller,
///   requirements: PasswordRequirement.defaults,
/// )
/// ```
class PasswordRequirementsChecklist extends StatelessWidget {
  /// Creates a [PasswordRequirementsChecklist].
  const PasswordRequirementsChecklist({
    super.key,
    required this.password,
    this.requirements,
    this.metColor,
    this.unmetColor,
    this.textStyle,
    this.spacing = 6,
    this.iconSize = 18,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  /// The password to check, usually a [TextEditingController].
  final ValueListenable<TextEditingValue> password;

  /// The rules to show. Defaults to [PasswordRequirement.defaults].
  final List<PasswordRequirement>? requirements;

  /// The icon color of a met requirement. Defaults to a theme-aware green.
  final Color? metColor;

  /// The icon color of an unmet requirement.
  ///
  /// Defaults to [ColorScheme.onSurfaceVariant].
  final Color? unmetColor;

  /// The style of the labels.
  final TextStyle? textStyle;

  /// The vertical space between rows.
  final double spacing;

  /// The size of the status icons.
  final double iconSize;

  /// The duration of the icon swap.
  final Duration animationDuration;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final met =
        metColor ??
        (theme.brightness == Brightness.dark
            ? Colors.green.shade400
            : Colors.green.shade700);
    final unmet = unmetColor ?? scheme.onSurfaceVariant;
    final rules = requirements ?? PasswordRequirement.defaults;

    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: password,
      builder: (context, value, _) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spacing,
        children: [
          for (final rule in rules)
            _Row(
              label: rule.label,
              isMet: rule.isMetBy(value.text),
              metColor: met,
              unmetColor: unmet,
              textStyle: textStyle,
              iconSize: iconSize,
              duration: animationDuration,
            ),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.label,
    required this.isMet,
    required this.metColor,
    required this.unmetColor,
    required this.textStyle,
    required this.iconSize,
    required this.duration,
  });

  final String label;
  final bool isMet;
  final Color metColor;
  final Color unmetColor;
  final TextStyle? textStyle;
  final double iconSize;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return MergeSemantics(
      child: Semantics(
        checked: isMet,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            AnimatedSwitcher(
              duration: duration,
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: Icon(
                isMet ? Icons.check_circle : Icons.radio_button_unchecked,
                key: ValueKey(isMet),
                size: iconSize,
                color: isMet ? metColor : unmetColor,
              ),
            ),
            Flexible(
              child: Text(
                label,
                style: (textStyle ?? const TextStyle()).copyWith(
                  color: isMet ? scheme.onSurface : scheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
