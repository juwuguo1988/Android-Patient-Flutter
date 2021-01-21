import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:fluro/fluro.dart';
import 'package:patient/routes/routes.dart';
import 'package:patient/routes/Application.dart';
import 'package:patient/utils/sp_util.dart';


class Global {
  static const bool isProd =
      bool.fromEnvironment('dart.vm.product', defaultValue: false);

  //初始化全局信息
  static Future init(VoidCallback callback) async {
    WidgetsFlutterBinding.ensureInitialized();
    ///
    /// 强制竖屏
    ///
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    // 初始化sp
    await SpUtil.getInstance();

    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;

    callback();
    if (Platform.isAndroid) {
      // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，
      // 是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
      SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}
