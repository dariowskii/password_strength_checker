## 1.3.0
**Important**: Updated Dart SDK constraint to `>=3.0.0 <4.0.0`.
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
