import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zemnanit/presentation/screens/home.dart';

void main() {
  testWidgets('Home widget test', (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(MaterialApp(home: Home()));

    // Assert
    // Check if the Scaffold is present
    expect(find.byType(Scaffold), findsOneWidget);

    // Check if the AppBar is present
    expect(find.byType(AppBar), findsOneWidget);

    // Check if the background image is present
    expect(find.byType(Image), findsOneWidget);

    // Check if the welcome text is present

    // Check if the description text is present
  });
}
