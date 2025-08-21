import 'package:flutter/material.dart';
import 'package:password_strength_checker/password_strength_checker.dart';

/// The widget that shows the password strength.
class PasswordStrengthChecker<T extends PasswordStrengthItem>
    extends StatelessWidget {
  /// Creates a [PasswordStrengthChecker] widget with the specified configuration.
  const PasswordStrengthChecker({
    super.key,
    required this.strength,
    this.configuration = const PasswordStrengthCheckerConfiguration(),
  });

  /// The [ValueNotifier] that contains the [PasswordStrengthItem].
  final ValueNotifier<T?> strength;

  /// The object that keeps all the widget configuration.
  final PasswordStrengthCheckerConfiguration configuration;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: strength,
      builder: (_, currentStrength, __) {
        final statusWidget = currentStrength?.statusWidget;
        return Column(
          children: [
            AnimatedContainer(
              duration: configuration.animationDuration,
              curve: configuration.animationCurve,
              height: configuration.height,
              width: configuration.width,
              alignment: configuration.leftToRight
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: configuration.externalBorderRadius,
                border: configuration.hasBorder
                    ? Border.all(
                        color: configuration.borderColor ??
                            currentStrength?.statusColor ??
                            configuration.inactiveBorderColor,
                        width: configuration.borderWidth,
                      )
                    : null,
              ),
              child: LayoutBuilder(
                builder: (_, constraints) {
                  return Padding(
                    padding: const EdgeInsets.all(2),
                    child: AnimatedContainer(
                      duration: configuration.animationDuration,
                      curve: configuration.animationCurve,
                      width: constraints.maxWidth *
                          (currentStrength?.widthPerc ?? 0),
                      decoration: BoxDecoration(
                        color: currentStrength?.statusColor,
                        borderRadius: configuration.internalBorderRadius,
                      ),
                    ),
                  );
                },
              ),
            ),
            if (configuration.showStatusWidget && statusWidget != null) ...[
              Container(
                margin: configuration.statusMargin,
                child: Row(
                  mainAxisAlignment: configuration.statusWidgetAlignment,
                  children: [
                    statusWidget,
                  ],
                ),
              )
            ],
          ],
        );
      },
    );
  }
}
