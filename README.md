# password_strength_checker
This is a Widget to check the strength of the password in a visual way, with an animation when the strength changes according to the settings given by the user.

## Features
![Demo Form Gif](./assets/demo_form.gif)
![Demo Gif](./assets/demo.gif)

## Getting started

### PasswordStrengthChecker

You can use the `PasswordStrengthChecker` to only have a visual feedback, for example:

```dart
final passNotifier = ValueNotifier<PasswordStrength?>(null);
// ...
PasswordStrengthChecker(
  strength: passNotifier,
),
```

See the [full example here](./example/password_strength_checker_example.dart).

### PasswordStrengthFormChecker

You can use the `PasswordStrengthFormChecker` to have a built-in `TextFormField` inside the widget and get form validation using a `minimumStrengthRequired`. For example:

```dart
PasswordStrengthFormChecker(
  minimumStrengthRequired: PasswordStrength.secure,
  onChanged: (password, notifier) {
    notifier.value = PasswordStrength.calculate(text: password);
  },
),
```

See the [full example here](./example/password_strength_form_checker_example.dart).

### Custom Strength

You can use the default `PasswordStrength` enum to set the strength of the password, or you can create your own enum that implements `PasswordStrengthItem` and use it. For example:

```dart
enum CustomPassStrength implements PasswordStrengthItem {
  weak,
  medium,
  strong;

  @override
  Color get statusColor {
    switch (this) {
      case CustomPassStrength.weak:
        return Colors.red;
      case CustomPassStrength.medium:
        return Colors.orange;
      case CustomPassStrength.strong:
        return Colors.green;
    }
  }

  @override
  Widget? get statusWidget {
    switch (this) {
      case CustomPassStrength.weak:
        return const Text('Weak');
      case CustomPassStrength.medium:
        return const Text('Medium');
      case CustomPassStrength.strong:
        return const Text('Strong');
      default:
        return null;
    }
  }

  @override
  double get widthPerc {
    switch (this) {
      case CustomPassStrength.weak:
        return 0.15;
      case CustomPassStrength.medium:
        return 0.4;
      case CustomPassStrength.strong:
        return 0.75;
      default:
        return 0.0;
    }
  }

  static CustomPassStrength? calculate({required String text}) {
    // Implement your custom logic here
    if (text.isEmpty) {
      return null;
    }
    // Use the [commonDictionary] to see if a password
    // is in 10,000 common exposed password list.
    if (commonDictionary[text] == true) {
      return CustomPassStrength.weak;
    }
    if (text.length < 6) {
      return CustomPassStrength.weak;
    } else if (text.length < 10) {
      return CustomPassStrength.medium;
    } else {
      return CustomPassStrength.strong;
    }
  }
}
```
