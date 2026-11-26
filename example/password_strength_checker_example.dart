import 'package:flutter/material.dart';
import 'package:password_strength_checker/password_strength_checker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _strength = ValueNotifier<PasswordStrength?>(null);

  @override
  void dispose() {
    _strength.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              onChanged: (value) =>
                  _strength.value = PasswordStrength.calculate(text: value),
            ),
            const SizedBox(height: 20),
            PasswordStrengthChecker(strength: _strength),
          ],
        ),
      ),
    );
  }
}
