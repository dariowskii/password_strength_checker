import 'dart:math';

import '../dict/eff_short_wordlist.dart';

/// The rules used by a [PassphraseGenerator].
final class PassphraseConfiguration {
  /// Creates a [PassphraseConfiguration].
  const PassphraseConfiguration({
    this.wordCount = 5,
    this.separator = '-',
    this.capitalize = false,
    this.includeNumber = false,
    this.words = effShortWordlist,
  }) : assert(wordCount > 0, 'wordCount must be greater than 0');

  /// How many words the passphrase has.
  final int wordCount;

  /// The text placed between words.
  final String separator;

  /// Whether every word starts with an uppercase letter.
  final bool capitalize;

  /// Whether a random digit is appended to one random word.
  final bool includeNumber;

  /// The pool of words. Defaults to the [effShortWordlist].
  ///
  /// Use a list without duplicates: entropy is computed from its length.
  final List<String> words;

  /// Returns a copy of this configuration with the given fields replaced.
  PassphraseConfiguration copyWith({
    int? wordCount,
    String? separator,
    bool? capitalize,
    bool? includeNumber,
    List<String>? words,
  }) => PassphraseConfiguration(
    wordCount: wordCount ?? this.wordCount,
    separator: separator ?? this.separator,
    capitalize: capitalize ?? this.capitalize,
    includeNumber: includeNumber ?? this.includeNumber,
    words: words ?? this.words,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PassphraseConfiguration &&
          wordCount == other.wordCount &&
          separator == other.separator &&
          capitalize == other.capitalize &&
          includeNumber == other.includeNumber &&
          identical(words, other.words);

  @override
  int get hashCode => Object.hash(
    wordCount,
    separator,
    capitalize,
    includeNumber,
    identityHashCode(words),
  );
}

/// Generates memorable passphrases like `acid-brook-flint-jolly-crate`.
///
/// Words are picked with [Random.secure]. With the default configuration a
/// passphrase carries about 51.7 bits of entropy, see [entropyBits].
///
/// ```dart
/// final passphrase = const PassphraseGenerator(
///   PassphraseConfiguration(wordCount: 6, capitalize: true),
/// ).generate(); // e.g. "Acid-Brook-Flint-Jolly-Crate-Oasis"
/// ```
class PassphraseGenerator {
  /// Creates a [PassphraseGenerator] that follows [configuration].
  const PassphraseGenerator([
    this.configuration = const PassphraseConfiguration(),
  ]);

  /// The rules used to build every passphrase.
  final PassphraseConfiguration configuration;

  /// The entropy of a generated passphrase, in bits.
  ///
  /// This is the guessing cost for an attacker who knows the word list and
  /// the configuration.
  double get entropyBits {
    final c = configuration;
    var bits = c.wordCount * _log2(c.words.length);
    if (c.includeNumber) bits += _log2(10.0 * c.wordCount);
    return bits;
  }

  /// Returns a new random passphrase.
  String generate() {
    final c = configuration;
    assert(c.words.length > 1, 'words must contain at least 2 entries');
    final random = Random.secure();
    final picked = [
      for (var i = 0; i < c.wordCount; i++)
        _format(c.words[random.nextInt(c.words.length)], c.capitalize),
    ];
    if (c.includeNumber) {
      final i = random.nextInt(picked.length);
      picked[i] = '${picked[i]}${random.nextInt(10)}';
    }
    return picked.join(c.separator);
  }

  static String _format(String word, bool capitalize) =>
      capitalize && word.isNotEmpty
      ? word[0].toUpperCase() + word.substring(1)
      : word;

  static double _log2(num x) => log(x) / ln2;
}
