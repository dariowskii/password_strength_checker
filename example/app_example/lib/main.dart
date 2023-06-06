import 'package:app_example/password_generator_example_page.dart';
import 'package:app_example/password_strength_checker_example_page.dart';
import 'package:app_example/password_strength_form_checker_example_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Password Checker App Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text("Password Generator"),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PasswordGeneratorExamplePage(),
                ),
              ),
            ),
            ElevatedButton(
              child: const Text("Password Strenght Checker"),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      const PasswordStrenghtCheckerExamplePage(),
                ),
              ),
            ),
            ElevatedButton(
              child: const Text("Password Strenght Form Checker"),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      PasswordStrenghtFormCheckerExamplePage(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
