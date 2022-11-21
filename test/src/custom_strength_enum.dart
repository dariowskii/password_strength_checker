import 'package:flutter/material.dart';
import 'package:password_strength_checker/src/enum/password_strength_enum.dart';

enum CustomPassStrength implements PasswordStrengthItem {
  weak,
  medium,
  strong,
  secure;

  @override
  Color get statusColor {
    switch (this) {
      case CustomPassStrength.weak:
        return Colors.red;
      case CustomPassStrength.medium:
        return Colors.orange;
      case CustomPassStrength.strong:
        return Colors.green;
      case CustomPassStrength.secure:
        return const Color(0xFF0B6C0E);
    }
  }

  @override
  Widget? get statusWidget {
    switch (this) {
      case CustomPassStrength.weak:
        return const Text('Weak');
      case CustomPassStrength.medium:
        return const Text('Medium');
      case CustomPassStrength.strong:
        return const Text('Strong');
      case CustomPassStrength.secure:
        return const Text('Secure');
    }
  }

  @override
  double get widthPerc {
    switch (this) {
      case CustomPassStrength.weak:
        return 0.15;
      case CustomPassStrength.medium:
        return 0.4;
      case CustomPassStrength.strong:
        return 0.75;
      case CustomPassStrength.secure:
        return 1.0;
    }
  }

  static CustomPassStrength? calculate({required String text}) {
    if (text.isEmpty) {
      return null;
    }
    if (text.length < 8) {
      return CustomPassStrength.weak;
    }
    if (text.length < 12) {
      return CustomPassStrength.medium;
    }
    if (text.length < 16) {
      return CustomPassStrength.strong;
    }
    return CustomPassStrength.secure;
  }
}
