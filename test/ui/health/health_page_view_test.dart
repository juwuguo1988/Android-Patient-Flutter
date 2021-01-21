import 'package:flutter/material.dart';
import "package:patient/ui/page_index.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:patient/ui/health/health_page_view.dart';

void main() {
  group("达标页面", () {
    testWidgets("标题", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: HealthViewUI(),
      ));
//      debugDumpApp();
      final titleFinder = find.text("健康");
      expect(titleFinder, findsOneWidget);
    });
  });
}