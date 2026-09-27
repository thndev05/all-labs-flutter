import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_card/main.dart';

void main() {
  testWidgets('displays the MiCard personal information', (tester) async {
    await tester.pumpWidget(const MiCardApp());

    expect(find.text('Trần Hoàng Nhật'), findsOneWidget);
    expect(find.text('SOFTWARE ENGINEER'), findsOneWidget);
    expect(find.text('0987079483'), findsOneWidget);
    expect(find.text('thndev05@gmail.com'), findsOneWidget);
    expect(find.byIcon(Icons.phone), findsOneWidget);
    expect(find.byIcon(Icons.email), findsOneWidget);
  });
}
