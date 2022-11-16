<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

This is a Widget to check the strength of the password in a visual way, with an animation when the strength changes according to the settings given by the user.

## Features
![Demo Gif](./assets/demo.gif)

## Getting started

You can use the default `PasswordStrength` enum to set the strength of the password, or you can create your own enum that implements `PasswordStrengthItem` and use it.

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:password_strength_checker/password_strength_checker.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passNotifier = ValueNotifier<PasswordStrength?>(null);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              onChanged: (value) {
                passNotifier.value = PasswordStrength.calculate(text: value);
              },
            ),
            const SizedBox(height: 20),
            PasswordStrengthChecker(
              strength: passNotifier,
            ),
          ],
        ),
      ),
    );
  }
}
```
