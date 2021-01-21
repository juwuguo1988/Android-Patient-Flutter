import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flui/flui.dart' show FLEmptyContainer;

import 'package:patient/ui/medic/medic_page/medic_smartDevice.dart';
import 'package:patient/ui/medic/medic_page/medic_planList.dart';
import 'package:patient/provider/medic/PlanProvider.dart';
import 'package:provider/provider.dart';
import 'package:patient/http/entity/medic/medic_plan_model.dart';

import 'package:patient/components/business/medic_output.dart';
import 'package:patient/http/entity/medic/medic_plan_model.dart';

class MedicPlanUI extends StatefulWidget {
  MedicPlanUI();
  _MedicPlanUIState createState() => _MedicPlanUIState();
}

class _MedicPlanUIState extends State<MedicPlanUI> with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;

  List<Plans> planList = [];

  loadData(BuildContext context) async {

    print("zhousuhua 生命周期------ loadData");
    XZLTakeMedicinePlanOutput output = XZLTakeMedicinePlanOutput();
    output.asyncOutputFutureAllDayMeicineList((List<Plans> resultArr){

      setState(() {
        planList = resultArr;
        print("zhousuhua 生命周期------ setState");
      });
    });

    // 网络请求刷新
    _getPlan(context);
  }

  Future _getPlan(BuildContext context) async {

    print("zhousuhua 生命周期------ _getPlan");
    try {
      await Provider.of<MedicPlanProvider>(context, listen: false).getPlan();
      await Provider.of<MedicPlanProvider>(context, listen: false).getSmartInfo();
      await Provider.of<MedicPlanProvider>(context, listen: false).getMedicRecords();
      return 'success';
    } catch (e, stack) {
      return 'fail';
    }
  }

//  initState() {
//
//    super.initState();
//    print("zhousuhua 生命周期------ initState");
//    loadData();
//  }


  Widget build(BuildContext context) {

    print("zhousuhua 生命周期------ build");

    return Consumer<MedicPlanProvider>(
        builder: (BuildContext con, MedicPlanProvider provider, Widget child){

          return Scaffold(
            body: FutureBuilder(
                future: loadData(context),
                builder: (context, snapshot) {

                  if (snapshot.hasData) {
                    MedicPlanProvider provider = Provider.of<MedicPlanProvider>(
                        context);
                    List<List<List<Plans>>> plans = provider.medicPlans;
                    Map<String, List<List<Plans>>> pillBoxMedicPlans = provider
                        .pillBoxMedicPlans;
                    if(pillBoxMedicPlans.length > 0) {
                      return Column(
                        children: <Widget>[
                          MedicSmartDevice(pillBoxMedicPlans),
                          MedicPlanList(plans),
                        ],
                      );
                    } else {
                      return Column(
                        children: <Widget>[
                          MedicPlanList(plans),
                        ],
                      );
                    }
                  } else {
                    return FLEmptyContainer(
                      showLoading: true,
                      title: '加载中...',
                    );
                  }
                }
            ),
          );
        });


  }
}
