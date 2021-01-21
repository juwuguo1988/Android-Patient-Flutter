import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient/config/app.dart';
import 'package:flui/flui.dart';
import 'package:patient/common/database/database_helper.dart';
import 'package:patient/ui/page_index.dart';
import './services/mock_health.dart';

class TestWidgetEssential extends StatefulWidget {
  @required final Widget child;
  TestWidgetEssential({ this.child });
  State<StatefulWidget> createState() {
    return MaterialEssentialState();
  }
}

class MaterialEssentialState extends State<TestWidgetEssential> {

  Widget build(BuildContext context) {

    DataBaseHelper().initUserDBTableWithUserId("18310099276");

    FLToastDefaults _toastDefaults = FLToastDefaults();

    ScreenUtil.init(
      context,
      width: App.DESIGN_WIDTH,
      height: App.DESIGN_HEIGHT,
      allowFontScaling: App.ALLOW_FONT_SCALING_SELF,
    );
    print(healthApi);
    return FLToastProvider(
      defaults: _toastDefaults,
      child: Builder(builder: (BuildContext context) {
        return MultiProvider(
            providers: [
//              ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
//              ChangeNotifierProvider<InitInfoProvider>(
//                  create: (_) => InitInfoProvider()),
//              ChangeNotifierProvider<MedicPlanProvider>(
//                  create: (_) => MedicPlanProvider()),
//              ChangeNotifierProvider<HealthMessageProvider>(
//                  create: (_) => HealthMessageProvider()),
              ChangeNotifierProvider<DatetimeProvider>(
                  create: (_) => DatetimeProvider()),
              ChangeNotifierProvider<HealthProvider>(
                  create: (_) => HealthProvider(api: healthApi)),
            ],
            child: widget.child
        );
      }),
    );
  }
}




