import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import "route_handler.dart";

/*
 * 描述:路由定义
 * 创建者: wuxiaobo
 * 邮箱: wuxiaobo@xinzhili.cn
 * 日期: 2020/3/20 16:36
 */
class Routes {
  static String index = "/";
  static String login = "/login";
  static String home = "/home";
  static String web_view = "/web_view";
  // 达标
  static String risk_evaluate = "/risk_evaluate";
  static String medicine_standard = "/medicine_standard";
  static String left_standard = "/left_standard";
  static String self_upload_bp = "/self_upload_bp";
  static String self_upload_sugar = "/self_upload_sugar";
  static String blood_pressure_history = "/blood_pressure_history";
  static String blood_sugar_history = "/blood_sugar_history";
  static String blood_fat_history = "/blood_fat_history";
  static String uric_history = "/uric_history";

  // 服药相关
  static String medic_add_plan = "/medic_add_plan";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("route is not find ~~");
    });
    router.define(home, handler: homeViewHandler);
    router.define(login, handler: loginHandler);
    router.define(web_view, handler: webViewHandler);

    // 达标
    router.define(risk_evaluate, handler: riskEvaluateHandler);
    router.define(medicine_standard, handler: medicineStandardHandler);
    router.define(left_standard, handler: riskEvaluateHandler);
    router.define(self_upload_bp, handler: selfUploadPressureHandler);
    router.define(self_upload_sugar, handler: selfUploadSugarHandler);

    router.define(blood_pressure_history, handler: bloodPressureHistoryHandler);
    router.define(blood_sugar_history, handler: bloodSugarHistoryHandler);
    router.define(blood_fat_history, handler: bloodFatHistoryHandler);
    router.define(uric_history, handler: uricHistoryHandler);

    // 服药相关
    router.define(medic_add_plan, handler: addPlanViewHandler);
  }
}
