/// Shared character class matchers. Not exported.
library;

/// Matches a lowercase letter, Unicode included.
final lowercaseRegExp = RegExp(r'\p{Ll}', unicode: true);

/// Matches an uppercase letter, Unicode included.
final uppercaseRegExp = RegExp(r'\p{Lu}', unicode: true);

/// Matches a digit, Unicode included.
final digitRegExp = RegExp(r'\p{N}', unicode: true);

/// Matches anything that is not a letter, a digit or whitespace.
final specialRegExp = RegExp(r'[^\p{L}\p{N}\s]', unicode: true);
