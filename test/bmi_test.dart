import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calculator/bmi_calculator.dart';

void main() {
  test('calculates a normal BMI', () {
    final result = calculateBmi(heightCm: 170, weightKg: 65);
    expect(result.value, closeTo(22.5, 0.1));
    expect(result.category, 'BÌNH THƯỜNG');
  });
}
