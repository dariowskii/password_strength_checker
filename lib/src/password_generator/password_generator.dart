import 'dart:math';

import 'package:flutter/widgets.dart';

import '../../password_strength_checker.dart';
import 'constants.dart';

/// Use this class to generate a random password based on the configurations.
///
/// You can use the `PasswordGenerator.fromConfig(...)` to return a new instance
/// of the class with the configurations you want.
class PasswordGenerator {
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

  /// A list of all the characters that can be used to generate the password.
  List<String> get allChars => [
        if (useSpecialChars) ...specialChars,
        if (useDigits) ...defaultDigits,
        if (useLowercase) ...defaultLowercaseChars,
        if (useUppercase) ...defaultUppercaseChars,
      ];

  PasswordGenerator({
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
  });

  /// Return a [PasswordGenerator] based on the configuration.
  factory PasswordGenerator.fromConfig(
      {required PasswordGeneratorConfiguration configuration}) {
    return PasswordGenerator(
      length: configuration.length,
      minLowercase: configuration.minLowercase,
      minUppercase: configuration.minUppercase,
      minDigits: configuration.minDigits,
      minSpecial: configuration.minSpecial,
      specialChars: configuration.specialChars,
      useSpecialChars: configuration.useSpecialChars,
      useDigits: configuration.useDigits,
      useLowercase: configuration.useLowercase,
      useUppercase: configuration.useUppercase,
      numberOfShuffles: configuration.numberOfShuffles,
    );
  }

  /// Generates a password based on the configuration.
  String generate() {
    final stopwatch = Stopwatch()..start();
    
    final random = Random.secure();
    final minLowercase = useLowercase ? this.minLowercase : 0;
    final minUppercase = useUppercase ? this.minUppercase : 0;
    final minDigits = useDigits ? this.minDigits : 0;
    final minSpecial = useSpecialChars ? this.minSpecial : 0;

    final remaining =
        length - minLowercase - minUppercase - minDigits - minSpecial;

    final buffer = StringBuffer();

    final defaultLowercaseLength = defaultLowercaseChars.length;
    final defaultUppercaseLength = defaultUppercaseChars.length;
    final defaultDigitsLength = defaultDigits.length;
    final defaultSpecialCharsLength = specialChars.length;
    final allCharsLength = allChars.length;

    for (var i = 0; i < minLowercase; i++) {
      buffer
          .write(defaultLowercaseChars[random.nextInt(defaultLowercaseLength)]);
    }

    for (var i = 0; i < minUppercase; i++) {
      buffer
          .write(defaultUppercaseChars[random.nextInt(defaultUppercaseLength)]);
    }

    for (var i = 0; i < minDigits; i++) {
      buffer.write(defaultDigits[random.nextInt(defaultDigitsLength)]);
    }

    for (var i = 0; i < minSpecial; i++) {
      buffer.write(specialChars[random.nextInt(defaultSpecialCharsLength)]);
    }

    for (var i = 0; i < remaining; i++) {
      buffer.write(allChars[random.nextInt(allCharsLength)]);
    }

    final firstPassword = buffer.toString();

    final passwordCodeUnits = List<int>.from(firstPassword.codeUnits);

    for (var i = 0; i < numberOfShuffles; i++) {
      passwordCodeUnits.shuffle(random);
    }

    final shuffeledPassword = String.fromCharCodes(passwordCodeUnits);

    debugPrint('Password generated in ${stopwatch.elapsedMilliseconds}ms');

    return shuffeledPassword;
  }
}
