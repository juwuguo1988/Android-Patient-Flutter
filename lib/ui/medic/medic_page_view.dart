import 'dart:convert' as Convert;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient/config/string.dart';
import 'package:patient/utils/LogUtils.dart';
import 'package:patient/components/my_app_bar.dart';
import 'package:patient/utils/Utils.dart';

import 'package:patient/ui/health/health_page_view.dart';
import 'package:patient/ui/setting/user_setting_view.dart';
import 'package:patient/components/ui/IconTextButton.dart';

import 'package:patient/ui/medic/medic_plan.dart';
import 'package:patient/ui/medic/medic_state.dart';
import 'package:flui/flui.dart';

import 'package:patient/chanel/chanel_battery.dart';

class _Page {
  final String labelId;
  _Page(this.labelId);
}

final List<_Page> _allPages = <_Page>[
  new _Page(Ids.titleMedicPlan),
  new _Page(Ids.titleMedicState),
];

class MedicPlanViewUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new DefaultTabController(
        length: _allPages.length,
        child: new Scaffold(
          appBar: new MyAppBar(
            leading: new FlatButton(
                child: Container(
                  child: RichText(
                      text: TextSpan(
                        text: "      9%",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 10,
                        ),
                        children: [
                          TextSpan(
                            text: "\n服药完成率",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 10
                            )
                          )
                        ]
                      )
                  ),
                  alignment: Alignment.center,
                ),
                color: Colors.blue,
                textColor: Color(0xFF3195FA),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return UserSettingView();
                  }));
                }),
            centerTitle: true,
            title: new TabLayout(),
            backgroundColor: Colors.white,
            actions: <Widget>[
              new IconTextButton.icon(
                  icon: new Icon(Icons.add),
                  label: Text(
                    "添加药品",
                  ),
                  color: Colors.white,
                  textColor: Color(0xFF3195FA),
                  iconTextAlignment: IconTextAlignment.iconLeftTextRight,
                  clipBehavior: Clip.none,
                  paddingIconText: 0,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return UserSettingView();
                    }));
                  })
            ],
          ),
          body: new TabBarViewLayout(),
          drawer: new Drawer(
            child: new HealthViewUI(),
          ),
        ));
  }
}

class TabLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new TabBar(
      isScrollable: true,
      labelPadding: EdgeInsets.all(12.0),
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: Color(0xFF3195FA),
      unselectedLabelColor: Colors.black,
      indicatorColor: Color(0xFF3195FA),
      tabs: [

        new FLBadge(
            child: Text(Ids.titleMedicPlan),
          position: FLBadgePosition.topRight,
          shape: FLBadgeShape.circle,
          hidden: true,
        ),
        new FLBadge(
          child: Text(Ids.titleMedicState),
          position: FLBadgePosition.topRight,
          shape: FLBadgeShape.circle,
          hidden: false,
        ),
      ]
    );
  }

//  _allPages
//      .map((_Page page) {
//
//  new FLBadge(
//////                 child: Text(page.labelId),
//////                 position: FLBadgePosition.topRight,
//////                 shape: FLBadgeShape.circle,
////                 child: Icon(Icons.home),
//  hidden: false,
//  shape: FLBadgeShape.circle,
//  );
//  }).toList(),
}

class TabBarViewLayout extends StatelessWidget {
  Widget buildTabView(BuildContext context, _Page page) {
    String labelId = page.labelId;
    switch (labelId) {
      case Ids.titleMedicPlan:
//        return MedicPlanUI();
        return PlatformChannel();
        break;
      case Ids.titleMedicState:
//        return MedicStateUI();
        return PlatformChannel();

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new TabBarView(
        children: _allPages.map((_Page page) {
      return buildTabView(context, page);
    }).toList());
  }
}
