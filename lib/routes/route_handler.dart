import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:patient/ui/home/home_view.dart';
import 'package:patient/ui/home/webview/web_view_page.dart';
import 'package:patient/ui/launch/login_page.dart';
import 'package:patient/ui/health/page/risk_evaluate_page.dart';
import 'package:patient/ui/health/page/medicine_standard.dart';
import 'package:patient/ui/health/page/self_upload_bp.dart';
import 'package:patient/ui/health/page/self_upload_sugar.dart';
import 'package:patient/ui/health/page/blood_pressure_history.dart';
import 'package:patient/ui/health/page/blood_sugar_history.dart';
import 'package:patient/ui/health/page/blood_fat_history.dart';
import 'package:patient/ui/health/page/uric_history.dart';

import 'package:patient/ui/medic/addMedic/medic_add_plane.dart';

import 'dart:convert';
import 'package:patient/http/entity/medic/medic_plan_model.dart';
/*
 * 描述:router handler
 * 创建者: wuxiaobo
 * 邮箱: wuxiaobo@xinzhili.cn
 * 日期: 2020/3/20 16:36
 */
// 首页
Handler homeViewHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomeViewUI();
});

// 登录页
Handler loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LoginPage();
});

// 风险评估
Handler riskEvaluateHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RiskEvaluatePage();
});

// 用药达标
Handler medicineStandardHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MedicineStandard();
});

// 手动上传
Handler selfUploadPressureHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SelfUploadBp();
});
Handler selfUploadSugarHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SelfUploadSugar();
});
Handler bloodPressureHistoryHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return BloodPressureHistory();
});

Handler bloodSugarHistoryHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return BloodSugarHistory();
});
Handler bloodFatHistoryHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return BloodFatHistory();
});
Handler uricHistoryHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return UricHistory();
});

// 网页
Handler webViewHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String url = params['url']?.first;
  String title = params['title']?.first;
  return WebViewPage(url: url, title: title);
});

// 添加服药计划页面
Handler addPlanViewHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String planStr = params['plan']?.first;
  List<Plans> planList = List<Plans>();
  List list = json.decode(planStr);
  list.first.forEach((val) {
    Plans plan = Plans.fromJson(val);
    planList.add(plan);
  });
  return MedicAddPlanUI(plan: planList);
});
