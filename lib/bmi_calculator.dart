class BmiResult {
  const BmiResult(
      {required this.value,
      required this.category,
      required this.interpretation});

  final double value;
  final String category;
  final String interpretation;
}

BmiResult calculateBmi({required int heightCm, required int weightKg}) {
  final bmi = weightKg / ((heightCm / 100) * (heightCm / 100));
  if (bmi >= 25) {
    return BmiResult(
        value: bmi,
        category: 'THỪA CÂN',
        interpretation:
            'Bạn có cân nặng cao hơn mức bình thường. Hãy vận động nhiều hơn.');
  }
  if (bmi > 18.5) {
    return BmiResult(
        value: bmi,
        category: 'BÌNH THƯỜNG',
        interpretation: 'Bạn có cân nặng khỏe mạnh. Làm tốt lắm!');
  }
  return BmiResult(
      value: bmi,
      category: 'THIẾU CÂN',
      interpretation:
          'Bạn có cân nặng thấp hơn mức bình thường. Hãy ăn uống đầy đủ hơn.');
}
