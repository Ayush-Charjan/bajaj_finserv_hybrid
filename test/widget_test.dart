import 'package:flutter_test/flutter_test.dart';

import 'package:bajaj_finserv_demo/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BajajFinservApp());

    // Verify that login screen is shown
    expect(find.text('Fintech App'), findsOneWidget);
  });
}
