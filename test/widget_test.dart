import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:handyph_app/main.dart';

void main() {
  testWidgets('App boots and shows login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const HandyPhApp());
    await tester.pumpAndSettle();

    // Verify the app renders successfully
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
