import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient/config/APPConstant.dart';
import 'package:patient/config/app.dart';
import 'package:patient/routes/Application.dart';

class MainViewPage extends StatefulWidget {
  MainViewPage();
  State<StatefulWidget> createState() {
    return _MainViewUI();
  }
}

class _MainViewUI extends State<MainViewPage> {
  @override
  void initState() {
    super.initState();
    startHome();
  }

  //显示2秒后跳转到HomeTabPage
  startHome() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {
      Application.router
          .navigateTo(context, "/home", replace: true); // 周素华改，需要改回来 /login
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      width: App.DESIGN_WIDTH,
      height: App.DESIGN_HEIGHT,
      allowFontScaling: App.ALLOW_FONT_SCALING_SELF,
    );
    return Scaffold(
      body: Image.asset(
        APPConstant.ASSETS_IMG + "ic_main_bg.png",
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }
}
