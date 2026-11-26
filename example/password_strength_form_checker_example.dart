import 'package:flutter/material.dart';
import 'package:password_strength_checker/password_strength_checker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PasswordStrengthFormChecker<PasswordStrength>(
                minimumStrengthRequired: PasswordStrength.secure,
                strengthCalculator: (text) =>
                    PasswordStrength.calculate(text: text),
                needConfirmation: true,
                requirements: PasswordRequirement.defaults,
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing data')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
