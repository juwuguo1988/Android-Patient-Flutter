import 'package:flutter/material.dart';
import 'package:patient/http/entity/medic/medic_plan_model.dart';
import 'package:patient/http/entity/medic/medic_pillbox_model.dart';
import 'package:patient/services/api/medic/plan_api.dart';

import 'package:patient/components/business/medic_business.dart';
import 'package:patient/http/entity/medic/medic_record_operation.dart';
import 'package:patient/utils/date_util.dart';
import 'package:patient/model/medic/time_range_plan_group.dart';

import 'package:patient/common/database/database_helper.dart';

class MedicPlanProvider with ChangeNotifier {

  List<List<List<Plans>>> medicPlans = [];
  Map<String, List<List<Plans>>> pillBoxMedicPlans = Map<String, List<List<Plans>>>();
  bool isOpen = true;
  PillBoxInfo boxInfo;
  List<TimePlanGroup> timePlans;


  changeOpen() {

    isOpen = !isOpen;
    notifyListeners();
  }

  setPillBox(PillBoxInfo res) {

    boxInfo = res;
    notifyListeners();
  }


  setPlan(PlanModel res) {

    getMedicPlans(res);
    getPillBoxMedicPlans();
    notifyListeners();
  }

  setStatePlan(PlanModel res,MedicRecordOperation operationRes) {


    // 获取今天的时间，获取从现在开始往前24个消失的所有有效计划
    int nowTime = DateUtil.getNowDateMs();
    int yesTime = nowTime - 24*60*60*1000;
    TimeRangePlanGroup rangeGroup = MedicBusiness().getTimeRangePlanGroup(res.plans, yesTime, nowTime);
    List<TimePlanGroup> sameTimePlan=  MedicBusiness().getSameTimePlanGroup(yesTime, nowTime, rangeGroup.plans);

    timePlans =  MedicBusiness().getUnEatPlanGroup(sameTimePlan, operationRes);
    timePlans.sort((left,right) => right.time.compareTo(left.time));

    notifyListeners();
  }


  // 获取药盒计划
  void getPillBoxMedicPlans(){

    pillBoxMedicPlans = Map();
     medicPlans.forEach((item){

       if((item.first.first.boxUuid.length != 0)&&(item.first.first.positionNo!=0)) {

         pillBoxMedicPlans.putIfAbsent(item.first.first.positionNo.toString(), ()=> item);
       }
     });
  }

  // 获取所有服药计划
  void getMedicPlans(PlanModel res){

    medicPlans = [];
    Map<String, List<Plans>> medicMap = Map<String, List<Plans>>();
    List<Plans> plans = res.plans;
    // 生成服药计划，同一个medicineHash合并

    plans.forEach((val){

      List<Plans> hashPlan = medicMap[val.medicineHash];
      if(hashPlan == null) {
        hashPlan = List();
      }
      if(val.ended == 0) {

        hashPlan.add(val);
      }
      medicMap.putIfAbsent(val.medicineHash, ()=> hashPlan);
    });

    medicMap.values.forEach((val){

      List<List<Plans>> sameUnitPlans = _getSameUnit(val);
      if(sameUnitPlans.length > 0) {
        medicPlans.add(sameUnitPlans);
      }
    });
  }

  // 根据一个组同medicineHash的计划，生成多组同剂量的计划
  List<List<Plans>> _getSameUnit(List<Plans> plan){

    Map<String, List<Plans>> medicMap = Map<String, List<Plans>>();
    // 生成服药计划，同一个medicineHash合并
    plan.forEach((val){

      String planDosage = MedicBusiness().getPlanDosage(val);

      List<Plans> hashPlan = medicMap[planDosage];

      if(hashPlan == null) {
        hashPlan = List();
      }
      hashPlan.add(val);
      medicMap.putIfAbsent(planDosage, ()=> hashPlan);
    });
    return medicMap.values.toList();
  }

  getPlan() async {

    PlanModel res = await PlanApi().getPlan();

//    DataBaseHelper().clearAllTakeMedicinePlanModels();
//    res.plans.forEach((val) {
//      DataBaseHelper().insertOneTakeMedicinePlanModel(val);
//    });

    setPlan(res);
  }

  void testA () {

    print("zhousuhua ---- testA");
  }

  void testB() {


    print("zhousuhua ---- testB");
  }

  getSmartInfo() async {

    PillBoxInfo res = await PlanApi().getPillBoxInfo();
    setPillBox(res);
  }

  getMedicRecords() async {

    PlanModel res = await PlanApi().getPlan();
    setPlan(res);

    MedicRecordOperation operationRes = await PlanApi().getMedicRecords();
    // 生成服药状态数据
    setStatePlan(res,operationRes);
  }
}
