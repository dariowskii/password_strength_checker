import 'package:flutter/material.dart';

import '../dict/common_passwords.dart';
import '../rules/character_classes.dart';
import '../rules/weak_patterns.dart';

/// The minimum length a password needs to be rated above
/// [PasswordStrength.weak].
const int kDefaultStrengthLength = 12;

/// The contract for a password strength level.
///
/// Implement it with an `enum` to create your own levels. The enum order
/// defines the strength order: the later a value is declared, the stronger it
/// is considered.
abstract interface class PasswordStrengthItem implements Enum {
  /// The color of the bar for this level.
  Color get statusColor;

  /// The filled fraction of the bar for this level, between `0` and `1`.
  double get widthPerc;

  /// The widget shown under the bar for this level, or `null` for none.
  Widget? get statusWidget;
}

/// The default password strength levels.
enum PasswordStrength implements PasswordStrengthItem {
  /// The password is in the [commonPasswords] list.
  alreadyExposed,

  /// Shorter than [kDefaultStrengthLength] (see [effectivePasswordLength])
  /// or with a single character class.
  weak,

  /// Contains two character classes.
  medium,

  /// Contains three character classes.
  strong,

  /// Contains lowercase, uppercase, digits and special characters.
  secure;

  @override
  Color get statusColor => switch (this) {
    alreadyExposed => const Color(0xFF9E0F05),
    weak => Colors.red,
    medium => Colors.orange,
    strong => Colors.green,
    secure => const Color(0xFF0B6C0E),
  };

  @override
  double get widthPerc => switch (this) {
    alreadyExposed => 0.075,
    weak => 0.15,
    medium => 0.4,
    strong => 0.75,
    secure => 1.0,
  };

  @override
  Widget get statusWidget => switch (this) {
    alreadyExposed => _label('Already exposed', Icons.error),
    weak => const Text('Weak'),
    medium => const Text('Medium'),
    strong => const Text('Strong'),
    secure => _label('Secure', Icons.check_circle),
  };

  Widget _label(String text, IconData icon) => Row(
    mainAxisSize: MainAxisSize.min,
    spacing: 5,
    children: [
      Text(text),
      Icon(icon, color: statusColor),
    ],
  );

  /// Returns the [PasswordStrength] of [text], or `null` if it is empty.
  ///
  /// Weak patterns such as `aaaa`, `1234` or `qwer` count as two characters
  /// toward the length, see [findWeakPatterns].
  static PasswordStrength? calculate({required String text}) {
    if (text.isEmpty) return null;
    if (isCommonPassword(text)) return alreadyExposed;
    if (effectivePasswordLength(text) < kDefaultStrengthLength) return weak;

    final classes = [
      lowercaseRegExp,
      uppercaseRegExp,
      digitRegExp,
      specialRegExp,
    ].where(text.contains).length;

    return switch (classes) {
      4 => secure,
      3 => strong,
      2 => medium,
      _ => weak,
    };
  }

  /// Human readable rules for reaching [secure].
  static String get instructions =>
      'Enter a password that contains:\n\n'
      '• At least $kDefaultStrengthLength characters\n'
      '• At least 1 lowercase letter\n'
      '• At least 1 uppercase letter\n'
      '• At least 1 digit\n'
      '• At least 1 special character (e.g. !@#\$%&*?)';
}
