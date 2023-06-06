import 'package:flutter/material.dart';
import 'package:password_strength_checker/password_strength_checker.dart';

class PasswordStrenghtFormCheckerExamplePage extends StatelessWidget {
  PasswordStrenghtFormCheckerExamplePage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PasswordStrengthFormChecker(
                minimumStrengthRequired: PasswordStrength.secure,
                onChanged: (password, notifier) {
                  notifier.value = PasswordStrength.calculate(text: password);
                },
                textFormFieldConfiguration: TextFormFieldConfiguration(
                  controller: TextEditingController(),
                  decoration: const InputDecoration(
                    errorStyle: TextStyle(height: 0), // remove error text space
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
                topInstructions: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        PasswordStrength.instructions,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.maxFinite,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
