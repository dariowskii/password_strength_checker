import 'package:flutter/material.dart';
import 'package:password_strength_checker/password_strength_checker.dart';

class PasswordStrenghtCheckerExamplePage extends StatelessWidget {
  const PasswordStrenghtCheckerExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passNotifier = ValueNotifier<PasswordStrength?>(null);

    return Scaffold(
      appBar: AppBar(),
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
                debugPrint("Strength: ${passNotifier.value}");
              },
            ),
            const SizedBox(height: 20),
            PasswordStrengthChecker(
              configuration: const PasswordStrengthCheckerConfiguration(
                  completeWithSecurePasswordOnly: false),
              strength: passNotifier,
            ),
          ],
        ),
      ),
    );
  }
}
