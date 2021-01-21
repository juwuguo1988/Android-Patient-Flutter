import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flui/flui.dart' show FLEmptyContainer;

import 'package:patient/provider/medic/PlanProvider.dart';
import 'package:provider/provider.dart';
import 'package:patient/model/medic/time_range_plan_group.dart';
import 'package:patient/ui/medic/medic_page/medic_state_card.dart';
import 'package:patient/components/business/medic_output.dart';
import 'package:patient/http/entity/medic/medic_plan_model.dart';

class MedicStateUI extends StatefulWidget {
  _MedicStateUIState createState() => _MedicStateUIState();
}

class _MedicStateUIState extends State<MedicStateUI> with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;

  List<Plans> planList = [];

  loadData() async {

    XZLTakeMedicinePlanOutput output = XZLTakeMedicinePlanOutput();
    output.asyncOutputFutureAllDayMeicineList((List<Plans> resultArr){

      setState(() {
        planList = resultArr;
      });
    });



  }

  initState() {

    super.initState();
    loadData();
  }


  Widget build(BuildContext context) {


    Future _getPlan(context) async {

      try {
        await Provider.of<MedicPlanProvider>(context, listen: false).getMedicRecords();
        return 'success';
      } catch (e, stack) {
        return 'fail';
      }
    }

    return Scaffold(
      body: FutureBuilder(
          future: _getPlan(context),
          builder: (context, snapshot) {
            if (snapshot.data == 'success') {
              MedicPlanProvider provider = Provider.of<MedicPlanProvider>(
                  context);
              List<TimePlanGroup> timePlans = provider.timePlans;
              return ListView.builder(
                  itemCount: timePlans.length,
                  itemBuilder: (context, index){
                    return TimePlanCard(timePlans[index]);
                  }
              );
            } else if (snapshot.data == 'fail') {
              return InkWell(
                onTap: (){
                  setState(() {
                    // 为了重新触发调用build
                  });
                },
                child: Center(
                  child: Text(
                    '重新加载',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            else {
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

