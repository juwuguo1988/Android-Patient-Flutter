import 'package:flutter/material.dart';
import 'package:patient/common/global.dart';
import 'package:patient/provider/auth.dart';
import 'package:patient/provider/health_message.dart';
import 'package:patient/provider/init.dart';
import 'package:patient/routes/Application.dart';
import 'package:patient/ui/launch/main_view.dart';
import 'package:provider/provider.dart';
import 'package:patient/provider/provider_index.dart';
import 'package:patient/provider/medic/PlanProvider.dart';
import 'package:flui/flui.dart';
import 'package:patient/services/api/health.dart';
import 'package:patient/common/database/database_helper.dart';

void main() => Global.init(() {
      runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
          ChangeNotifierProvider<InitInfoProvider>(
              create: (_) => InitInfoProvider()),
          ChangeNotifierProvider<HealthProvider>(
              create: (_) => HealthProvider(api: HealthApi())),
          ChangeNotifierProvider<MedicPlanProvider>(
              create: (_) => MedicPlanProvider()),
          ChangeNotifierProvider<HealthMessageProvider>(
              create: (_) => HealthMessageProvider()),
          ChangeNotifierProvider<DatetimeProvider>(
              create: (_) => DatetimeProvider()),
        ],
        child: MyApp(),
      ));
    });

class MyApp extends StatefulWidget {
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}


class MyAppState extends State<MyApp> {
  @override

  Widget build(BuildContext context) {
    
    DataBaseHelper().initUserDBTableWithUserId("18310099276");

    FLToastDefaults _toastDefaults = FLToastDefaults();

    return FLToastProvider(
        defaults: _toastDefaults,
        child: MaterialApp(
          //去除右上角的Debug标签
          debugShowCheckedModeBanner: false,
          home: new MainViewPage(), //启动页
          theme: ThemeData(
            primaryColor: Colors.white,
          ),
          onGenerateRoute: Application.router.generator,
        ));
  }
}




