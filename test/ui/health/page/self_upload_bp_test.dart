import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:patient/http/entity/graph_bp_model.dart';
import "package:patient/ui/page_index.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:patient/ui/health/page/self_upload_bp.dart';
import 'package:patient/services/api/health.dart';
import '../../../test_widget_essential.dart';
import '../../../services/mock_health.dart';
import 'dart:convert';

void main() {
  testWidgets("手动上传页面", (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(
        MaterialApp(home: TestWidgetEssential(child: SelfUploadBp())));
    print("标题");
    final titleFinder = find.text("手动上传");
    expect(titleFinder, findsOneWidget);

    print("文案");
    final subTitleFinder = find.text("请左右滑动调整您的数据");
    final highBpTextFinder = find.text("收缩压");
    final highAndLowBpUnitFinder = find.text("mmHg");
    final lowBpTextFinder = find.text("舒张压");
    final HRTextFinder = find.text("心率");
    final HRUnitFinder = find.text("次/分");
    final datePickerTextFinder = find.text("请选择测量时间");
    expect(subTitleFinder, findsOneWidget);
    expect(highBpTextFinder, findsOneWidget);
    expect(highAndLowBpUnitFinder, findsNWidgets(2));
    expect(lowBpTextFinder, findsOneWidget);
    expect(HRTextFinder, findsOneWidget);
    expect(HRUnitFinder, findsOneWidget);
    expect(datePickerTextFinder, findsOneWidget);

    print("按钮");
    final BtnFinder = find.byType(RaisedButton);
    expect(BtnFinder, findsOneWidget);


//    flutter: jsonRes {graphBp: {time: [{year: 1592202572319, time: 1592202572319}, {year: null, time: 1591861014653}, {year: null, time: 1591177545312}], high: [110, 110, 121], low: [80, 80, 98], status: [NORMAL, NORMAL, NORMAL]}, graphHeartRate: {time: [{year: 1592202572319, time: 1592202572319}, {year: null, time: 1591861014653}, {year: null, time: 1591177545312}], heartRate: [60, 60, 72], status: [NORMAL, NORMAL, NORMAL]}, bpLatest: {high: 96, low: 68, bpStatus: NORMAL, heartRate: 41, heartRateStatus: LOW, measuredAt: 1591177056191590, year: null, referenceBpMax: 140, referenceBpMin: 90, referenceHeartRateMax: 100, referenceHeartRateMin: 47}} _InternalLinkedHashMap<String, dynamic>
//        {"graphBp":{"time":[{"year":1592202572319,"time":1592202572319},{"year":0,"time":1591861014653},{"year":0,"time":1591177545312}],"high":[110,110,121],"low":[80,80,98],"status":["NORMAL","NORMAL","NORMAL"]},"graphHeartRate":{"time":[{"year":1592202572319,"time":1592202572319},{"year":0,"time":1591861014653},{"year":0,"time":1591177545312}],"heartRate":[60,60,72],"status":["NORMAL","NORMAL","NORMAL"]},"bpLatest":{"high":96,"low":68,"bpStatus":"NORMAL","heartRate":41,"heartRateStatus":"LOW","measuredAt":1591177056191590,"year":null,"referenceBpMax":140,"referenceBpMin":90,"referenceHeartRateMax":100,"referenceHeartRateMin":47}}

//    when(healthApi.uploadBp({})).thenAnswer((realInvocation) => Future.value("success"));
    when(healthApi.getBloodPressureByGraph({"category": "TIMES", "times": 7,}))
      .thenReturn(GraphBpModel.fromJson(json.decode("""
        {"graphBp":{"time":[{"year":1592202572319,"time":1592202572319},{"year":0,"time":1591861014653},{"year":0,"time":1591177545312}],"high":[110,110,121],"low":[80,80,98],"status":["NORMAL","NORMAL","NORMAL"]},"graphHeartRate":{"time":[{"year":1592202572319,"time":1592202572319},{"year":0,"time":1591861014653},{"year":0,"time":1591177545312}],"heartRate":[60,60,72],"status":["NORMAL","NORMAL","NORMAL"]},"bpLatest":{"high":96,"low":68,"bpStatus":"NORMAL","heartRate":41,"heartRateStatus":"LOW","measuredAt":1591177056191590,"year":null,"referenceBpMax":140,"referenceBpMin":90,"referenceHeartRateMax":100,"referenceHeartRateMin":47}}
      """)));
    await tester.tap(BtnFinder);
//
    await tester.pump();
//  检查 是否调用过
//
    verify(healthApi.getBloodPressureByGraph({"category": "TIMES", "times": 7})).called(1);

  });
}
