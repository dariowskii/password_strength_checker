import '../dict/common_passwords.dart';
import '../enum/password_strength_enum.dart';
import 'character_classes.dart';
import 'weak_patterns.dart';

/// A single rule a password must satisfy, shown by
/// [PasswordRequirementsChecklist].
///
/// ```dart
/// final rules = [
///   PasswordRequirement.minLength(16, label: 'Almeno 16 caratteri'),
///   PasswordRequirement.special(),
///   PasswordRequirement('No spaces', (p) => !p.contains(' ')),
/// ];
/// ```
final class PasswordRequirement {
  /// Creates a requirement named [label] that is met when [test] is `true`.
  const PasswordRequirement(this.label, this.test);

  /// At least [length] characters, counted as Unicode code points.
  factory PasswordRequirement.minLength(int length, {String? label}) =>
      PasswordRequirement(
        label ?? 'At least $length characters',
        (p) => p.runes.length >= length,
      );

  /// At least one lowercase letter.
  factory PasswordRequirement.lowercase({
    String label = 'One lowercase letter',
  }) => PasswordRequirement(label, lowercaseRegExp.hasMatch);

  /// At least one uppercase letter.
  factory PasswordRequirement.uppercase({
    String label = 'One uppercase letter',
  }) => PasswordRequirement(label, uppercaseRegExp.hasMatch);

  /// At least one digit.
  factory PasswordRequirement.digit({String label = 'One number'}) =>
      PasswordRequirement(label, digitRegExp.hasMatch);

  /// At least one character that is not a letter, a digit or whitespace.
  factory PasswordRequirement.special({String label = 'One symbol'}) =>
      PasswordRequirement(label, specialRegExp.hasMatch);

  /// Not one of the [commonPasswords].
  factory PasswordRequirement.notCommon({
    String label = 'Not a common password',
  }) => PasswordRequirement(label, (p) => p.isNotEmpty && !isCommonPassword(p));

  /// No repeated, sequential or keyboard runs, see [findWeakPatterns].
  factory PasswordRequirement.noWeakPatterns({
    String label = 'No repeated or sequential characters',
  }) => PasswordRequirement(
    label,
    (p) => p.isNotEmpty && findWeakPatterns(p).isEmpty,
  );

  /// The rules behind [PasswordStrength.secure]: [kDefaultStrengthLength]
  /// characters, lowercase, uppercase, a number and a symbol.
  static final List<PasswordRequirement> defaults = List.unmodifiable([
    PasswordRequirement.minLength(kDefaultStrengthLength),
    PasswordRequirement.lowercase(),
    PasswordRequirement.uppercase(),
    PasswordRequirement.digit(),
    PasswordRequirement.special(),
  ]);

  /// The text shown in the checklist.
  final String label;

  /// Returns `true` when the password satisfies this requirement.
  final bool Function(String password) test;

  /// Whether [password] satisfies this requirement.
  bool isMetBy(String password) => test(password);
}
