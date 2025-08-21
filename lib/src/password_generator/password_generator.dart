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

  /// Creates a [PasswordGenerator] with the specified parameters.
  const PasswordGenerator({
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
  }) : assert(length > 0, 'The length of the password must be greater than 0'),
       assert(
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

  /// Return a [PasswordGenerator] based on the configuration.
  factory PasswordGenerator.fromConfig({
    required PasswordGeneratorConfiguration configuration,
  }) {
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
  String generate({bool printDebugInfo = false}) {
    late final Stopwatch stopwatch;
    late final String debugSeparator;
    if (printDebugInfo) {
      stopwatch = Stopwatch()..start();
      debugSeparator = '-' * 50;
      debugPrint(
        '$debugSeparator\n$runtimeType: START GENERATING PASSWORD\n$debugSeparator',
      );
    }

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

    if (printDebugInfo && minLowercase > 0) {
      debugPrint(
        '$runtimeType: adding $minLowercase minimum lowercase characters...',
      );
    }

    for (var i = 0; i < minLowercase; i++) {
      buffer.write(
        defaultLowercaseChars[random.nextInt(defaultLowercaseLength)],
      );
    }

    if (printDebugInfo && minUppercase > 0) {
      debugPrint(
        '$runtimeType: adding $minUppercase minimum uppercase characters...',
      );
    }

    for (var i = 0; i < minUppercase; i++) {
      buffer.write(
        defaultUppercaseChars[random.nextInt(defaultUppercaseLength)],
      );
    }

    if (printDebugInfo && minDigits > 0) {
      debugPrint('$runtimeType: adding $minDigits minimum digits...');
    }

    for (var i = 0; i < minDigits; i++) {
      buffer.write(defaultDigits[random.nextInt(defaultDigitsLength)]);
    }

    if (printDebugInfo && minSpecial > 0) {
      debugPrint(
        '$runtimeType: adding $minSpecial minimum special characters...',
      );
    }

    for (var i = 0; i < minSpecial; i++) {
      buffer.write(specialChars[random.nextInt(defaultSpecialCharsLength)]);
    }

    if (printDebugInfo && remaining > 0) {
      debugPrint('$runtimeType: filling $remaining remaining characters...');
    }

    for (var i = 0; i < remaining; i++) {
      buffer.write(allChars[random.nextInt(allCharsLength)]);
    }

    final passwordCodeUnits = List<int>.from(buffer.toString().codeUnits);

    if (printDebugInfo) {
      debugPrint('$runtimeType: shuffling password...');
    }

    for (var i = 0; i < numberOfShuffles; i++) {
      passwordCodeUnits.shuffle(random);
    }

    final shuffeledPassword = String.fromCharCodes(passwordCodeUnits);

    if (printDebugInfo) {
      stopwatch.stop();
      debugPrint(
        '$debugSeparator\nPassword $shuffeledPassword generated in ${stopwatch.elapsedMilliseconds}ms\n$debugSeparator',
      );
    }

    return shuffeledPassword;
  }
}
