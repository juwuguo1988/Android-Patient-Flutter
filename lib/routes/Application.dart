import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

/*
 * 描述:router 静态实例
 * 创建者: wuxiaobo
 * 邮箱: wuxiaobo@xinzhili.cn
 * 日期: 2020/3/20 16:36
 */
class Application {
  static FluroRouter router;

  static go(context, String route) {
    Application.router
        .navigateTo(context, route, transition: TransitionType.cupertino);
  }

  // 对参数进行encode，解决参数中有特殊字符，影响fluro路由匹配
  static Future navigateToWithParams(BuildContext context, String path,
      {Map<String, dynamic> params,
       TransitionType transition = TransitionType.native}) {
    String query = "";
    if (params != null) {
      int index = 0;
      for (var key in params.keys) {
        var value = Uri.encodeComponent(params[key]);
        if (index == 0) {
          query = "?";
        } else {
          query = query + "\&";
        }
        query += "$key=$value";
        index++;
      }
    }

    path = path + query;
    return Application.router.navigateTo(context, path, transition: transition);
  }
}
