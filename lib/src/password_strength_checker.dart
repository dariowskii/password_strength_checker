import 'package:flutter/material.dart';

/// The abstract class for the password strength enum.
abstract class PasswordStrengthItem {
  Color get statusColor;
  double get widthPerc;
  Widget? get statusWidget => null;
}

/// The default enum for the password strength.
enum PasswordStrength implements PasswordStrengthItem {
  weak,
  medium,
  strong,
  secure;

  @override
  Color get statusColor {
    switch (this) {
      case PasswordStrength.weak:
        return Colors.red;
      case PasswordStrength.medium:
        return Colors.orange;
      case PasswordStrength.strong:
        return Colors.green;
      case PasswordStrength.secure:
        return const Color(0xFF0B6C0E);
      default:
        return Colors.red;
    }
  }

  @override
  double get widthPerc {
    switch (this) {
      case PasswordStrength.weak:
        return 0.15;
      case PasswordStrength.medium:
        return 0.4;
      case PasswordStrength.strong:
        return 0.75;
      case PasswordStrength.secure:
        return 1.0;
    }
  }

  @override
  Widget? get statusWidget {
    switch (this) {
      case PasswordStrength.weak:
        return const Text('Weak');
      case PasswordStrength.medium:
        return const Text('Medium');
      case PasswordStrength.strong:
        return const Text('Strong');
      case PasswordStrength.secure:
        return Row(
          children: [
            const Text('Secure'),
            const SizedBox(width: 5),
            Icon(Icons.check_circle, color: statusColor)
          ],
        );
      default:
        return null;
    }
  }

  /// Returns the [PasswordStrength] from the [text] value.
  static PasswordStrength? calculate({required String text}) {
    if (text.isEmpty) {
      return null;
    }

    if (text.length < 8) {
      return PasswordStrength.weak;
    }

    final hasLowercase = text.contains(RegExp(r'[a-z]'));
    final hasUppercase = text.contains(RegExp(r'[A-Z]'));
    final hasDigits = text.contains(RegExp(r'[0-9]'));
    final hasSpecialChars = text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    var counter = 0;
    for (final element in [
      hasLowercase,
      hasUppercase,
      hasDigits,
      hasSpecialChars
    ]) {
      if (element) {
        counter++;
      }
    }

    switch (counter) {
      case 1:
        return PasswordStrength.weak;
      case 2:
        return PasswordStrength.medium;
      case 3:
        return PasswordStrength.strong;
      case 4:
        return PasswordStrength.secure;
      default:
        return PasswordStrength.weak;
    }
  }
}

class PasswordStrengthChecker<T extends PasswordStrengthItem>
    extends StatelessWidget {
  const PasswordStrengthChecker({
    Key? key,
    required this.strength,
    this.width = double.maxFinite,
    this.height = 20,
    this.leftToRight = true,
    this.showStatusWidget = true,
    this.statusWidgetAlignment = MainAxisAlignment.start,
    this.statusMargin = const EdgeInsets.only(top: 10, left: 10),
    this.hasBorder = true,
    this.borderWidth = 2,
    this.borderColor,
    this.inactiveBorderColor = Colors.black,
    this.animationDuration = const Duration(milliseconds: 600),
    this.animationCurve = Curves.easeInOut,
    this.externalBorderRadius = const BorderRadius.all(Radius.circular(10)),
    this.internalBorderRadius = const BorderRadius.all(Radius.circular(10)),
  }) : super(key: key);

  final ValueNotifier<T?> strength;
  final double width;
  final double height;
  final bool leftToRight;

  final bool showStatusWidget;
  final MainAxisAlignment statusWidgetAlignment;
  final EdgeInsetsGeometry statusMargin;

  final Duration animationDuration;
  final Curve animationCurve;

  final bool hasBorder;
  final double borderWidth;
  final Color? borderColor;
  final Color inactiveBorderColor;
  final BorderRadiusGeometry? externalBorderRadius;
  final BorderRadiusGeometry? internalBorderRadius;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: strength,
      builder: (_, currentStrength, __) {
        final statusWidget = currentStrength?.statusWidget;
        return Column(
          children: [
            AnimatedContainer(
              duration: animationDuration,
              curve: animationCurve,
              height: height,
              width: width,
              alignment:
                  leftToRight ? Alignment.centerLeft : Alignment.centerRight,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: externalBorderRadius,
                border: hasBorder
                    ? Border.all(
                        color: borderColor ??
                            currentStrength?.statusColor ??
                            inactiveBorderColor,
                        width: borderWidth,
                      )
                    : null,
              ),
              child: LayoutBuilder(
                builder: (_, constraints) {
                  return Padding(
                    padding: const EdgeInsets.all(2),
                    child: AnimatedContainer(
                      duration: animationDuration,
                      curve: animationCurve,
                      width: constraints.maxWidth *
                          (currentStrength?.widthPerc ?? 0),
                      decoration: BoxDecoration(
                        color: currentStrength?.statusColor,
                        borderRadius: internalBorderRadius,
                      ),
                    ),
                  );
                },
              ),
            ),
            if (showStatusWidget && statusWidget != null) ...[
              Container(
                margin: statusMargin,
                child: Row(
                  mainAxisAlignment: statusWidgetAlignment,
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
