import 'package:flutter_test/flutter_test.dart';

import 'package:password_strength_checker/password_strength_checker.dart';

import 'src/custom_strength_enum.dart';

void main() {
  test('Calculate null password strength', () {
    final strength = PasswordStrength.calculate(text: '');
    expect(strength, null);
  });

  test('Calculate already exposed password', () {
    final strength = PasswordStrength.calculate(text: 'password');
    expect(strength, PasswordStrength.alreadyExposed);
  });

  test('Calculate weak password lower than 8 chars', () {
    final strength = PasswordStrength.calculate(text: 'weak');
    expect(strength, PasswordStrength.weak);
  });

  test('Calculate weak password', () {
    final strength = PasswordStrength.calculate(text: 'weakweak');
    expect(strength, PasswordStrength.weak);
  });

  test('Calculate medium password', () {
    final strength = PasswordStrength.calculate(text: 'aaaaaaaaM');
    expect(strength, PasswordStrength.medium);
  });

  test('Calculate strong password', () {
    final strength = PasswordStrength.calculate(text: 'aaaaaaaaM1');
    expect(strength, PasswordStrength.strong);
  });

  test('Calculate secure password', () {
    final strength = PasswordStrength.calculate(text: 'aaaaaaaaM1@');
    expect(strength, PasswordStrength.secure);
  });

  test('Calculate null custom password strength', () {
    final strength = CustomPassStrength.calculate(text: '');
    expect(strength, null);
  });

  test('Calculate weak password with custom enum', () {
    final strength = CustomPassStrength.calculate(text: 'a');
    expect(strength, CustomPassStrength.weak);
  });

  test('Calculate medium password with custom enum', () {
    final strength = CustomPassStrength.calculate(text: 'a' * 8);
    expect(strength, CustomPassStrength.medium);
  });

  test('Calculate strong password with custom enum', () {
    final strength = CustomPassStrength.calculate(text: 'a' * 12);
    expect(strength, CustomPassStrength.strong);
  });

  test('Calculate secure password with custom enum', () {
    final strength = CustomPassStrength.calculate(text: 'a' * 16);
    expect(strength, CustomPassStrength.secure);
  });
}
