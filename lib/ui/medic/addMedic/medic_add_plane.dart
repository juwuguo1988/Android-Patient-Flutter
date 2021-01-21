import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flui/flui.dart' show FLEmptyContainer;
import 'package:patient/ui/medic/medic_page/medic_smartDevice.dart';
import 'package:patient/ui/medic/medic_page/medic_planList.dart';
import 'package:patient/provider/medic/PlanProvider.dart';
import 'package:provider/provider.dart';
import 'package:patient/http/entity/medic/medic_plan_model.dart';


class MedicAddPlanUI extends StatefulWidget {

  final List<Plans> plan;
  MedicAddPlanUI({this.plan});

  _MedicADDPlanUIState createState() => _MedicADDPlanUIState();
}

class _MedicADDPlanUIState extends State<MedicAddPlanUI> {

  Widget build(BuildContext context) {

    print("zhousuhua 添加服药计划  ---- ${widget.plan.toString()}");

    Future _getPlan(context) async {

      try {
        await Provider.of<MedicPlanProvider>(context, listen: false).getPlan();
        await Provider.of<MedicPlanProvider>(context, listen: false).getSmartInfo();
        await Provider.of<MedicPlanProvider>(context, listen: false).getMedicRecords();
        return 'success';
      } catch (e, stack) {
        return 'fail';
      }
    }

//    return Scaffold(
//        appBar: AppBar(
//          title: Text('风险评估'),
//        ),
//        body: SingleChildScrollView(
          

    return Scaffold(
      appBar: AppBar(
        title: Text('添加服药计划'),
      ),
      body: FutureBuilder(
          future: _getPlan(context),
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
  }
}
