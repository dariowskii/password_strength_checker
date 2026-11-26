import 'dart:math';

import '../config/password_generator_configuration.dart';
import 'constants.dart';

/// Generates cryptographically secure random passwords.
///
/// ```dart
/// final password = const PasswordGenerator(
///   PasswordGeneratorConfiguration(length: 24, minSpecial: 4),
/// ).generate();
/// ```
class PasswordGenerator {
  /// Creates a [PasswordGenerator] that follows [configuration].
  const PasswordGenerator([
    this.configuration = const PasswordGeneratorConfiguration(),
  ]);

  /// The rules used to build every password.
  final PasswordGeneratorConfiguration configuration;

  /// Returns a new random password built with [Random.secure].
  String generate() {
    final c = configuration;
    final random = Random.secure();
    final chars = <String>[];

    // Split by runes so multi-unit characters (e.g. emoji) stay intact.
    void pick(String pool, int count) {
      final runes = pool.runes.toList(growable: false);
      for (var i = 0; i < count; i++) {
        chars.add(String.fromCharCode(runes[random.nextInt(runes.length)]));
      }
    }

    if (c.useLowercase) pick(defaultLowercaseChars, c.minLowercase);
    if (c.useUppercase) pick(defaultUppercaseChars, c.minUppercase);
    if (c.useDigits) pick(defaultDigits, c.minDigits);
    if (c.useSpecialChars) pick(c.specialChars, c.minSpecial);

    final pool = [
      if (c.useSpecialChars) c.specialChars,
      if (c.useDigits) defaultDigits,
      if (c.useLowercase) defaultLowercaseChars,
      if (c.useUppercase) defaultUppercaseChars,
    ].join();
    pick(pool, c.length - chars.length);

    return (chars..shuffle(random)).join();
  }
}
