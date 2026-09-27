import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calculator/main.dart';

void main() {
  testWidgets('calculates BMI and shows the result screen', (tester) async {
    await tester.pumpWidget(const BmiApp());
    expect(find.text('TÍNH BMI'), findsOneWidget);
    await tester.tap(find.text('TÍNH BMI'));
    await tester.pumpAndSettle();
    expect(find.text('KẾT QUẢ CỦA BẠN'), findsOneWidget);
    expect(find.text('TÍNH LẠI'), findsOneWidget);
  });
}
