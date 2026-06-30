import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stac/stac.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(Stac.initialize);

  for (final asset in [
    'assets/sdui/insta_emi_card.json',
    'assets/sdui/insta_emi_offer_details.json',
    'assets/sdui/insta_emi_application.json',
  ]) {
    testWidgets('$asset renders', (tester) async {
      final source = await rootBundle.loadString(asset);
      final json = jsonDecode(source) as Map<String, dynamic>;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Stac.fromJson(json, context)!,
          ),
        ),
      );
      await tester.pump();

      expect(tester.takeException(), isNull);
    });
  }
}
