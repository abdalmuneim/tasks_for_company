// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:minisocialfeedapp/providers/theme_provider.dart';

import 'package:minisocialfeedapp/main.dart';

void main() {
  testWidgets('App starts and shows auth screen', (WidgetTester tester) async {
    // Create a ThemeProvider for the test.
    final themeProvider = ThemeProvider();
    await themeProvider.initializeTheme();

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(themeProvider: themeProvider));

    // Verify that the AuthScreen is shown initially.
    expect(find.text('Welcome Back!'), findsOneWidget);
  });
}
