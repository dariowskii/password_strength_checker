import 'package:flutter/material.dart';
import '../dict/common_passwords.dart';

/// The default password strength length.
const int kDefaultStrengthLength = 12;

/// The abstract class for the password strength enum.
abstract class PasswordStrengthItem extends Enum {
  /// The color for every status.
  Color get statusColor;

  /// The percentual width of every status.
  double get widthPerc;

  /// The widget to show for every status under the bar.
  Widget? get statusWidget => null;
}

/// The default enum for the password strength.
enum PasswordStrength implements PasswordStrengthItem {
  alreadyExposed,
  weak,
  medium,
  strong,
  secure;

  /// The color for every status.
  @override
  Color get statusColor {
    switch (this) {
      case PasswordStrength.alreadyExposed:
        return const Color.fromARGB(255, 158, 15, 5);
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

  /// The percentual width of every status.
  @override
  double get widthPerc {
    switch (this) {
      case PasswordStrength.alreadyExposed:
        return 0.075;
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

  /// The widget to show for every status under the bar.
  @override
  Widget? get statusWidget {
    switch (this) {
      case PasswordStrength.alreadyExposed:
        return Row(
          children: [const Text('Already exposed'), const SizedBox(width: 5), Icon(Icons.error, color: statusColor)],
        );
      case PasswordStrength.weak:
        return const Text('Weak');
      case PasswordStrength.medium:
        return const Text('Medium');
      case PasswordStrength.strong:
        return const Text('Strong');
      case PasswordStrength.secure:
        return Row(
          children: [const Text('Secure'), const SizedBox(width: 5), Icon(Icons.check_circle, color: statusColor)],
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

    if (commonDictionary[text] == true) {
      return PasswordStrength.alreadyExposed;
    }

    if (text.length < kDefaultStrengthLength) {
      return PasswordStrength.weak;
    }

    var counter = 0;
    if (text.contains(RegExp(r'[a-z]'))) counter++;
    if (text.contains(RegExp(r'[A-Z]'))) counter++;
    if (text.contains(RegExp(r'[0-9]'))) counter++;
    if (text.contains(RegExp(r'[!@#\$%&*()?£\-_=]'))) counter++;

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

  /// Instructions for the password strength.
  static String get instructions {
    return 'Enter a password that contains:\n\n'
        '• At least $kDefaultStrengthLength characters\n'
        '• At least 1 lowercase letter\n'
        '• At least 1 uppercase letter\n'
        '• At least 1 digit\n'
        '• At least 1 special character';
  }
}
