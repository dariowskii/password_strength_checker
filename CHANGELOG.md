## 2.0.0

A leaner, modern rewrite. See **Migrating from 1.x** in the README.

### Breaking
- `PasswordStrengthFormChecker` now calculates the strength by itself through the new required `strengthCalculator`. `onChanged` is optional and receives `(password, strength)`.
- Removed `TextFormFieldConfiguration`. Use `controller`, `confirmationController`, `focusNode`, `decoration`, `confirmationDecoration`, `obscureText`, `autofillHints`, `autovalidateMode`, or `fieldBuilder` for full control.
- `onPasswordGenerated` now receives only the password. Removed `generateButtonSize`; the generate button is now a full-width `FilledButton.tonal`.
- `emptyTextErrorMessage` is a non-null `String`. The default confirmation decoration no longer hides the error text.
- `commonDictionary` (`Map<String, bool>`) is replaced by `commonPasswords` (`Set<String>`) and `isCommonPassword()`.
- `PasswordGenerator` wraps a `PasswordGeneratorConfiguration`: `PasswordGenerator(config)` replaces `PasswordGenerator.fromConfig(...)` and the duplicated fields.
- Removed `numberOfShuffles` and `generate(printDebugInfo:)`. The debug output printed the generated password to the logs.
- `specialChars` is now a `String`.
- `PasswordStrengthItem` is an `interface class`, and `statusWidget` must be implemented.
- `PasswordStrengthChecker.strength` accepts any `ValueListenable`. `statusWidgetAlignment` is an `AlignmentGeometry`, and `inactiveBorderColor` defaults to the theme's `outlineVariant`.
- Minimum Flutter version is 3.35.0.

### Behavior
- Any character that is not a letter, a digit or whitespace now counts as a special character, Unicode included.
- Accented and non-Latin letters count as lowercase/uppercase letters.
- The leaked-password check is now case-insensitive.

### Fixed
- `PasswordStrengthFormChecker` no longer crashes on `validate()` when the text was set without typing (`initialValue`, a programmatic `controller.text`, or the generator).
- The strength bar now updates after the generator fills the field.
- The confirmation field no longer requires an external controller.

### Improved
- `RegExp`s are compiled once, and the generator builds its character pool once.
- Strength bar uses `AnimatedFractionallySizedBox`, supports dark mode out of the box and exposes semantics.
- `PasswordGeneratorConfiguration` adds `copyWith`, and its `==`/`hashCode` are value based.
- Screenshots converted to animated WebP: the screenshot files shrink from 2.55 MB to about 1.2 MB, and every download includes them.
- New README with banner, quick start and migration guide.

## 1.3.2
Code formatting cleanup and a manual `workflow_dispatch` trigger for the publish workflow.

## 1.3.1
Updated docs.
## 1.3.0
**Important**: Updated Dart SDK constraint to `>=3.9.0 <4.0.0`.
- Updated with new Dart pattern matching syntax.
- Optimized widgets for better performance.
- Fix a `ValueNotifier` memory leak inside the `PasswordStrengthFormChecker` disposing it correctly.
## 1.2.4
Fix #8
## 1.2.3
Implemented a `kDefaultStrengthLength` constant with a default value of 12.
From now, a password with a `length < 12` will be considered weak.
## 1.2.2
Implemented `contextMenuBuilder` support and removed `toolbarOptions` from `TextFormFieldConfiguration` class.
## 1.2.1
Update `PasswordGenerator` class + tests.
## 1.2.0
- Implemented `PasswordGenerator` class.
- Added support for password generator to `PasswordStrengthFormChecker`.
## 1.1.2
Updated `PasswordStrength` calculation priority.
## 1.1.1
Setted `obscureText = true` by default on `TextFormField`.
## 1.1.0
- Implemented **PasswordStrengthFormChecker** and moved all **PasswordStrengthChecker** properties into **PasswordStrengthCheckerConfiguration** object.
- Implemented a *commonDictionary* to get the first 10,000 common passwords.
- Extended **PasswordStrength** with *alreadyExposed*.
## 1.0.1
Updated docs.
## 1.0.0
Check your password strength with **PasswordStrengthChecker**.
