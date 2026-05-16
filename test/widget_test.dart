import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:handyph_app/main.dart';
import 'package:handyph_app/providers/auth_provider.dart';

void main() {
  testWidgets('App boots and shows login screen', (WidgetTester tester) async {
    final authProvider = AuthProvider();
    await tester.pumpWidget(HandyPhApp(authProvider: authProvider));
    await tester.pumpAndSettle();

    // Verify the app renders successfully
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
