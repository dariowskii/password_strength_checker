import 'package:flutter/material.dart';
import 'package:password_strength_checker/password_strength_checker.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            PasswordStrengthChecker(strength: passNotifier),
          ],
        ),
      ),
    );
  }
}
