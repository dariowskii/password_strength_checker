import '../password_generator/constants.dart';

/// A configuration for a [PasswordGenerator].
final class PasswordGeneratorConfiguration {
  /// The length of the password to generate.
  final int length;

  /// The minimum number of lowercase characters to include in the password.
  final int minLowercase;

  /// The minimum number of uppercase characters to include in the password.
  final int minUppercase;

  /// The minimum number of digits to include in the password.
  final int minDigits;

  /// The minimum number of special characters to include in the password.
  final int minSpecial;

  /// The special characters to include in the password.
  final List<String> specialChars;

  /// Whether to include special characters in the password.
  final bool useSpecialChars;

  /// Whether to include digits in the password.
  final bool useDigits;

  /// Whether to include lowercase characters in the password.
  final bool useLowercase;

  /// Whether to include uppercase characters in the password.
  final bool useUppercase;

  /// The number of times to shuffle the password.
  final int numberOfShuffles;

  /// Creates a [PasswordGeneratorConfiguration] with the specified parameters.
  const PasswordGeneratorConfiguration({
    this.length = defaultLength,
    this.minLowercase = defaultMinLowercase,
    this.minUppercase = defaultMinUppercase,
    this.minDigits = defaultMinDigits,
    this.minSpecial = defaultMinSpecial,
    this.specialChars = defaultSpecialChars,
    this.useSpecialChars = true,
    this.useDigits = true,
    this.useLowercase = true,
    this.useUppercase = true,
    this.numberOfShuffles = 1,
  }) : assert(
         length >= minLowercase + minUppercase + minDigits + minSpecial,
         'The length of the password must be greater than or equal to the sum of the minimum number of lowercase, uppercase, digits and special characters',
       ),
       assert(
         numberOfShuffles >= 1,
         'The number of shuffles must be greater than or equal to 1',
       ),
       assert(
         minLowercase >= 0,
         'The minimum number of lowercase characters must be greater than or equal to 0',
       ),
       assert(
         minUppercase >= 0,
         'The minimum number of uppercase characters must be greater than or equal to 0',
       ),
       assert(
         minDigits >= 0,
         'The minimum number of digits must be greater than or equal to 0',
       ),
       assert(
         minSpecial >= 0,
         'The minimum number of special characters must be greater than or equal to 0',
       ),
       assert(
         useSpecialChars || useDigits || useLowercase || useUppercase,
         'At least one of the useSpecialChars, useDigits, useLowercase or useUppercase must be true',
       );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PasswordGeneratorConfiguration &&
        length == other.length &&
        minLowercase == other.minLowercase &&
        minUppercase == other.minUppercase &&
        minDigits == other.minDigits &&
        minSpecial == other.minSpecial &&
        specialChars.length == other.specialChars.length &&
        specialChars.every((c) => other.specialChars.contains(c)) &&
        useSpecialChars == other.useSpecialChars &&
        useDigits == other.useDigits &&
        useLowercase == other.useLowercase &&
        useUppercase == other.useUppercase &&
        numberOfShuffles == other.numberOfShuffles;
  }

  @override
  int get hashCode =>
      length.hashCode ^
      minLowercase.hashCode ^
      minUppercase.hashCode ^
      minDigits.hashCode ^
      minSpecial.hashCode ^
      specialChars.fold(0, (prev, c) => prev ^ c.hashCode) ^
      useSpecialChars.hashCode ^
      useDigits.hashCode ^
      useLowercase.hashCode ^
      useUppercase.hashCode ^
      numberOfShuffles.hashCode;
}
