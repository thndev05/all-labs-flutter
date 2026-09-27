import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clima/main.dart';

void main() {
  testWidgets('shows weather and searches another city', (tester) async {
    await tester.pumpWidget(const ClimaApp());
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('weather-city')), findsOneWidget);
    expect(tester.widget<Text>(find.byKey(const Key('weather-city'))).data,
        'Đà Nẵng');
    await tester.enterText(find.byKey(const Key('city-input')), 'Hà Nội');
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();
    expect(tester.widget<Text>(find.byKey(const Key('weather-city'))).data,
        'Hà Nội');
  });
}
