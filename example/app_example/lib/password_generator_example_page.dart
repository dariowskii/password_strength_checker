import 'package:flutter/material.dart';
import 'package:password_strength_checker/password_strength_checker.dart';

class PasswordGeneratorExamplePage extends StatefulWidget {
  const PasswordGeneratorExamplePage({Key? key}) : super(key: key);

  @override
  State<PasswordGeneratorExamplePage> createState() =>
      _PasswordGeneratorExamplePageState();
}

class _PasswordGeneratorExamplePageState
    extends State<PasswordGeneratorExamplePage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  var _obscureText = true;

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
                  // Don't forget to update the notifier!
                  notifier.value = PasswordStrength.calculate(text: password);
                },
                textFormFieldConfiguration: TextFormFieldConfiguration(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                ),
                showGenerator: true,
                onPasswordGenerated: (password, notifier) {
                  debugPrint('$password - length: ${password.length}');
                  // Don't forget to update the notifier!
                  notifier.value = PasswordStrength.calculate(text: password);
                },
                generateButtonStyle: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
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
