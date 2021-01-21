import 'package:flutter/material.dart';

class Constant {
  static const String keyLanguage = 'key_language';

  static const int status_success = 0;

  static const int type_sys_update = 1;
  static const int type_refresh_all = 5;

  static const String key_theme_color = 'key_theme_color';
  static const String key_guided = 'key_guided';
  static const String key_splash_model = 'key_splash_models';
}

class AppColors {
  static const Color themeColor = Color(0xff3592de);

  static const Color pageBg = Color(0xfff6f6f6);
  static const Color mainText = Color(0xff181818);
  static const Color helpText = Color(0xff999999);
  static const Color linkText = Color(0xff4C73CF);
  static const Color primaryBtn = Color(0xff4C73CF);

  // 健康达标页面
  static const Color riskTitleText = themeColor;
  static const Color riskSubTitleText = Color(0xff858e99);
  static const Color riskItemText = Color(0xff2c2f32);

  static const Color lowRisk = Color(0xff32cc98);
  static const Color middleRisk = Color(0xffff9932);
  static const Color highRisk = Color(0xfff5384b);

  static const Color lowMed = themeColor;
  static const Color normalMed = Color(0xff32cc98);
  static const Color highMed = Color(0xffff9932);

  static Color lowStatus = lowRisk;
  static Color midStatus = middleRisk;
  static Color highStatus = Color(0xfff65a66);

  static Map<String, Color> riskStatusList = {
    "LOW": AppColors.lowStatus,
    "MIDDLE": AppColors.midStatus,
    "HIGH": AppColors.highStatus
  };

  static Map<String, Color> medicineStatusList = {
    "LOW": AppColors.middleRisk,
    "NORMAL": AppColors.lowRisk,
    "HIGH": AppColors.highStatus
  };


// 用药达标页面

}
