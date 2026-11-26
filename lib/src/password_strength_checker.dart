import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'config/password_strength_checker_configuration.dart';
import 'enum/password_strength_enum.dart';

/// An animated bar that shows the current password strength.
///
/// ```dart
/// final strength = ValueNotifier<PasswordStrength?>(null);
/// PasswordStrengthChecker(strength: strength);
/// ```
class PasswordStrengthChecker<T extends PasswordStrengthItem>
    extends StatelessWidget {
  /// Creates a [PasswordStrengthChecker].
  const PasswordStrengthChecker({
    super.key,
    required this.strength,
    this.configuration = const PasswordStrengthCheckerConfiguration(),
  });

  /// The current strength, or `null` when there is no password.
  final ValueListenable<T?> strength;

  /// The look and feel of the bar.
  final PasswordStrengthCheckerConfiguration configuration;

  @override
  Widget build(BuildContext context) {
    final config = configuration;
    final inactiveColor =
        config.inactiveBorderColor ??
        Theme.of(context).colorScheme.outlineVariant;

    return ValueListenableBuilder<T?>(
      valueListenable: strength,
      builder: (context, current, _) {
        final status = config.showStatusWidget ? current?.statusWidget : null;
        return Semantics(
          container: true,
          label: config.semanticsLabel,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: config.animationDuration,
                curve: config.animationCurve,
                height: config.height,
                width: config.width,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: config.externalBorderRadius,
                  border: config.hasBorder
                      ? Border.all(
                          color:
                              config.borderColor ??
                              current?.statusColor ??
                              inactiveColor,
                          width: config.borderWidth,
                        )
                      : null,
                ),
                child: AnimatedFractionallySizedBox(
                  duration: config.animationDuration,
                  curve: config.animationCurve,
                  alignment: config.leftToRight
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  widthFactor: current?.widthPerc ?? 0,
                  child: AnimatedContainer(
                    duration: config.animationDuration,
                    curve: config.animationCurve,
                    decoration: BoxDecoration(
                      color: current?.statusColor,
                      borderRadius: config.internalBorderRadius,
                    ),
                  ),
                ),
              ),
              if (status != null)
                Padding(
                  padding: config.statusMargin,
                  child: Align(
                    alignment: config.statusWidgetAlignment,
                    child: status,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
