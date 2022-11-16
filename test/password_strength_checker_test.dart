import 'package:flutter_test/flutter_test.dart';

import 'package:password_strength_checker/password_strength_checker.dart';

void main() {
  test('Calculate null password', () {
    final strength = PasswordStrength.calculate(text: '');
    expect(strength, null);
  });

  test('Calculate weak password lower than 8 chars', () {
    final strength = PasswordStrength.calculate(text: '1234567');
    expect(strength, PasswordStrength.weak);
  });

  test('Calculate weak password', () {
    final strength = PasswordStrength.calculate(text: 'aaaaaaaa');
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
}
