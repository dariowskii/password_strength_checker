import '../password_generator/constants.dart';

/// The rules used by a [PasswordGenerator] to build a password.
final class PasswordGeneratorConfiguration {
  /// Creates a [PasswordGeneratorConfiguration].
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
    this.excludeWeakPatterns = true,
  }) : assert(length > 0, 'length must be greater than 0'),
       assert(
         minLowercase >= 0 &&
             minUppercase >= 0 &&
             minDigits >= 0 &&
             minSpecial >= 0,
         'Minimum counts must be greater than or equal to 0',
       ),
       assert(
         length >= minLowercase + minUppercase + minDigits + minSpecial,
         'length must be at least the sum of the minimum counts',
       ),
       assert(
         useSpecialChars || useDigits || useLowercase || useUppercase,
         'At least one character class must be enabled',
       ),
       assert(
         !useSpecialChars || specialChars != '',
         'specialChars cannot be empty when useSpecialChars is true',
       );

  /// The length of the password.
  final int length;

  /// The minimum number of lowercase characters.
  final int minLowercase;

  /// The minimum number of uppercase characters.
  final int minUppercase;

  /// The minimum number of digits.
  final int minDigits;

  /// The minimum number of special characters.
  final int minSpecial;

  /// The pool of special characters, e.g. `'!@#\$%'`. Each Unicode code point is one character.
  final String specialChars;

  /// Whether special characters can be used.
  final bool useSpecialChars;

  /// Whether digits can be used.
  final bool useDigits;

  /// Whether lowercase characters can be used.
  final bool useLowercase;

  /// Whether uppercase characters can be used.
  final bool useUppercase;

  /// Whether to regenerate passwords that contain a weak pattern such as
  /// `aaaa`, `1234` or `qwer`. See `findWeakPatterns`.
  final bool excludeWeakPatterns;

  /// Returns a copy of this configuration with the given fields replaced.
  PasswordGeneratorConfiguration copyWith({
    int? length,
    int? minLowercase,
    int? minUppercase,
    int? minDigits,
    int? minSpecial,
    String? specialChars,
    bool? useSpecialChars,
    bool? useDigits,
    bool? useLowercase,
    bool? useUppercase,
    bool? excludeWeakPatterns,
  }) => PasswordGeneratorConfiguration(
    length: length ?? this.length,
    minLowercase: minLowercase ?? this.minLowercase,
    minUppercase: minUppercase ?? this.minUppercase,
    minDigits: minDigits ?? this.minDigits,
    minSpecial: minSpecial ?? this.minSpecial,
    specialChars: specialChars ?? this.specialChars,
    useSpecialChars: useSpecialChars ?? this.useSpecialChars,
    useDigits: useDigits ?? this.useDigits,
    useLowercase: useLowercase ?? this.useLowercase,
    useUppercase: useUppercase ?? this.useUppercase,
    excludeWeakPatterns: excludeWeakPatterns ?? this.excludeWeakPatterns,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PasswordGeneratorConfiguration &&
          length == other.length &&
          minLowercase == other.minLowercase &&
          minUppercase == other.minUppercase &&
          minDigits == other.minDigits &&
          minSpecial == other.minSpecial &&
          specialChars == other.specialChars &&
          useSpecialChars == other.useSpecialChars &&
          useDigits == other.useDigits &&
          useLowercase == other.useLowercase &&
          useUppercase == other.useUppercase &&
          excludeWeakPatterns == other.excludeWeakPatterns;

  @override
  int get hashCode => Object.hash(
    length,
    minLowercase,
    minUppercase,
    minDigits,
    minSpecial,
    specialChars,
    useSpecialChars,
    useDigits,
    useLowercase,
    useUppercase,
    excludeWeakPatterns,
  );
}
