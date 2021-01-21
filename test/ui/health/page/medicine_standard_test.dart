import 'package:flutter/material.dart';
import 'package:patient/http/entity/graph_bp_model.dart';
import "package:patient/ui/page_index.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:patient/ui/health/page/medicine_standard.dart';
import 'package:patient/config/app.dart';
import 'package:patient/ui/health/page/blood_pressure.dart';
import '../../../test_widget_essential.dart';
import 'package:mockito/mockito.dart';
import 'package:patient/services/api/health.dart';

//class MockHealthApi extends Mock implements HealthApi {}


void main() {
  testWidgets("用药达标页面", (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(
        MaterialApp(home: TestWidgetEssential(child: MedicineStandard())));
    debugDumpApp();
//      // 往输入框中输入 hi
//      await tester.enterText(find.byType(TextField), 'hi');
//      // 点击 button 来触发事件
//      await tester.tap(find.byType(FloatingActionButton));
//      // 让 widget 重绘
//      await tester.pump();
//      // 检测 text 是否添加到 List 中
//      expect(find.text('hi'), findsOneWidget);
//
//      // 测试滑动
//      await tester.drag(find.byType(Dismissible), Offset(500.0, 0.0));
//
//      // 页面会一直刷新，直到最后一帧绘制完成
//      await tester.pumpAndSettle();
//
//      // 验证页面中是否还有 hi 这个 item
//      expect(find.text('hi'), findsNothing);

    final titleFinder = find.text("用药达标");
    expect(titleFinder, findsOneWidget);
    final bp_title = find.byKey(Key("血压"));
    final sugar_title = find.byKey(Key("血糖"));
    final bf_title = find.byKey(Key("血脂"));
    final uric_title = find.byKey(Key("尿酸"));

    // 默认：血压
    final bpFinder = find.byKey(Key("血压FutureBuilder"));
    expect(bpFinder, findsOneWidget);

    expect(sugar_title, findsOneWidget);
//    await tester.tap(sugar_title);
//    await tester.pumpAndSettle();
//    // 血糖
//    final sugarFinder = find.byKey(Key("血糖FutureBuilder"));
//    expect(sugarFinder, findsOneWidget);

  });
}
