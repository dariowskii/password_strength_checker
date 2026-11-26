/// The minimum length of a run to be reported as a weak pattern.
const int kWeakPatternMinLength = 4;

const _keyboardRows = [
  'qwertyuiop',
  'asdfghjkl',
  'zxcvbnm',
  'qwertzuiop',
  'yxcvbnm',
  'azertyuiop',
  'qsdfghjklm',
  'wxcvbn',
];

final _rowIndexes = [
  for (final row in _keyboardRows)
    {for (var i = 0; i < row.length; i++) row.codeUnitAt(i): i},
];

/// Returns the predictable runs found in [password], in order.
///
/// A run is reported when it is at least [kWeakPatternMinLength] characters
/// long and is one of:
/// - the same character repeated, like `aaaa` or `!!!!`;
/// - an alphabetical or numerical sequence, like `abcd`, `4321`;
/// - adjacent keys on a keyboard row (QWERTY, QWERTZ or AZERTY),
///   like `qwer` or `lkjh`.
///
/// The check is case-insensitive. Overlapping runs are merged.
///
/// ```dart
/// findWeakPatterns('xAAAA1234!'); // ['AAAA', '1234']
/// ```
List<String> findWeakPatterns(String password) => [
  for (final (start, end) in _weakRuns(password))
    String.fromCharCodes(password.runes.toList().sublist(start, end)),
];

/// The length of [password] where every weak run counts as two characters.
///
/// `Aaaaaaaaaaa1!` has 13 characters but an effective length of 4.
int effectivePasswordLength(String password) {
  var length = password.runes.length;
  for (final (start, end) in _weakRuns(password)) {
    length -= end - start - 2;
  }
  return length;
}

List<(int, int)> _weakRuns(String password) {
  final chars = [
    for (final rune in password.runes)
      if (String.fromCharCode(rune).toLowerCase().runes.toList() case [
        final lower,
      ])
        lower
      else
        rune,
  ];
  if (chars.length < kWeakPatternMinLength) return const [];

  final runs = <(int, int)>[];

  void scan(bool Function(int previous, int current) linked) {
    var start = 0;
    for (var i = 1; i <= chars.length; i++) {
      if (i < chars.length && linked(chars[i - 1], chars[i])) continue;
      if (i - start >= kWeakPatternMinLength) runs.add((start, i));
      start = i;
    }
  }

  scan((a, b) => a == b);
  scan((a, b) => b - a == 1 && _sameClass(a, b));
  scan((a, b) => a - b == 1 && _sameClass(a, b));
  for (final index in _rowIndexes) {
    scan((a, b) => index[a] != null && index[b] == index[a]! + 1);
    scan((a, b) => index[a] != null && index[b] == index[a]! - 1);
  }

  if (runs.isEmpty) return runs;
  runs.sort((a, b) => a.$1.compareTo(b.$1));
  final merged = <(int, int)>[runs.first];
  for (final run in runs.skip(1)) {
    final last = merged.last;
    if (run.$1 < last.$2) {
      merged.last = (last.$1, run.$2 > last.$2 ? run.$2 : last.$2);
    } else {
      merged.add(run);
    }
  }
  return merged;
}

bool _sameClass(int a, int b) =>
    (_isDigit(a) && _isDigit(b)) || (_isLetter(a) && _isLetter(b));

bool _isDigit(int c) => c >= 0x30 && c <= 0x39;

bool _isLetter(int c) => c >= 0x61 && c <= 0x7A;
