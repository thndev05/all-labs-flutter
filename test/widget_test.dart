import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:i_am_rich_lab/main.dart';

void main() {
  testWidgets('displays the I Am Rich screen', (tester) async {
    await tester.pumpWidget(const IAmRichApp());

    expect(find.text('I Am Rich'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(
        find.bySemanticsLabel('A diamond representing wealth'), findsOneWidget);
  });
}
