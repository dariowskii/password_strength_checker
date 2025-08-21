import 'package:flutter/material.dart';
import '../dict/common_passwords.dart';

/// The default password strength length.
const int kDefaultStrengthLength = 12;

/// The abstract class for the password strength enum.
abstract class PasswordStrengthItem implements Enum {
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
  Color get statusColor => switch (this) {
    PasswordStrength.alreadyExposed => const Color.fromARGB(255, 158, 15, 5),
    PasswordStrength.weak => Colors.red,
    PasswordStrength.medium => Colors.orange,
    PasswordStrength.strong => Colors.green,
    PasswordStrength.secure => const Color(0xFF0B6C0E),
  };

  /// The percentual width of every status.
  @override
  double get widthPerc => switch (this) {
    PasswordStrength.alreadyExposed => 0.075,
    PasswordStrength.weak => 0.15,
    PasswordStrength.medium => 0.4,
    PasswordStrength.strong => 0.75,
    PasswordStrength.secure => 1.0,
  };

  /// The widget to show for every status under the bar.
  @override
  Widget get statusWidget => switch (this) {
    PasswordStrength.alreadyExposed => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Already exposed'),
        const SizedBox(width: 5),
        Icon(Icons.error, color: statusColor),
      ],
    ),
    PasswordStrength.weak => const Text('Weak'),
    PasswordStrength.medium => const Text('Medium'),
    PasswordStrength.strong => const Text('Strong'),
    PasswordStrength.secure => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Secure'),
        const SizedBox(width: 5),
        Icon(Icons.check_circle, color: statusColor),
      ],
    ),
  };

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

    return switch (counter) {
      1 => PasswordStrength.weak,
      2 => PasswordStrength.medium,
      3 => PasswordStrength.strong,
      4 => PasswordStrength.secure,
      _ => PasswordStrength.weak,
    };
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
