
import 'package:patient/http/entity/medic/medic_plan_model.dart';
import 'package:patient/model/medic/time_range_plan_group.dart';
import 'package:patient/utils/date_util.dart';
import 'package:patient/http/entity/medic/medic_record_operation.dart';
import 'package:patient/http/entity/medic/medic_plan_model.dart';

import 'package:patient/model/medic/medic_list_group.dart';

class MedicBusiness {

  static MedicBusiness _instance;

  static String _test;

  MedicBusiness._private() {
    _test = "";
  }
  factory MedicBusiness() {
    if (_instance == null) {
      _instance = MedicBusiness._private();
    }
    return _instance;
  }

  // 根据计划生成剂量
  String getPlanDosage(Plans plan) {

    String unit = "";
    if(plan.dosageUnit != null && plan.dosageUnit!="other") {
      unit = plan.dosageUnit;
    }

    var formUnit = plan.dosageFormUnit!=null?plan.dosageFormUnit:"片";
    if(plan.medicineName.contains("胰岛素")) {

      formUnit = "UL";
    }

    double count = (plan.count/1000.0);
    String countStr = count.toString();

    double dosage = ((plan.dosage/1000.0)*count);
    String pillDosage = dosage.toString();
    if(dosage%1 == 0) {
      pillDosage = dosage.toInt().toString();
    }

    if(count%1 == 0) {
      countStr = count.toInt().toString();
    }

    pillDosage = "${pillDosage}${unit}";
    String pillCount = "${countStr}${formUnit}";
    String planDosage = "${pillCount}";
    if(plan.medicineName.contains("胰岛素")) {

      planDosage = pillCount;
    } else {
      if(pillDosage!='0'){
        planDosage = "${pillDosage}(${pillCount})";
      }
    }
    return planDosage;
  }

  // 根据计划生成时间
  String getTimeString(List<Plans> plan) {

    String time = "";
    String oneTime;
    plan.forEach((val){

      int hour = (val.takeAt/60).toInt();
      String hourStr = hour.toString();
      if(hour < 10) {
        hourStr = "0${hourStr}";
      }

      int min = (val.takeAt%60).toInt();
      String minStr = min.toString();
      if(min < 10) {
        minStr = "0${minStr}";
      }

      oneTime = "${hourStr}:${minStr}";
      if(time == null) {

        time = "${oneTime}";
      } else {
        time = "${time} ${oneTime}";
      }
    });
    return time;
  }

  // 判断是否是药盒计划
  bool isPillBoxPlan(Plans plan) {

    return ((plan.boxUuid.length != 0)&&(plan.positionNo!=0));
  }


   // 根据传入的计划，和时间域生成 这段时间里有效的计划
// 根据计划生成时间
  TimeRangePlanGroup getTimeRangePlanGroup(List<Plans> plan, int startTime, int endTime) {

    List<Plans> availPlan = List<Plans>();
    plan.forEach((val) {

      if(val.ended == 0) {
        availPlan.add(val);
      } else if(val.ended < startTime || val.started > endTime) {

      } else {
        availPlan.add(val);
      }
    });

    TimeRangePlanGroup group = TimeRangePlanGroup(startTime, endTime, availPlan);

    return group;
  }

  // 一组吃药时间相同的计划过滤掉服药记录后的计划
  List<TimePlanGroup> getUnEatPlanGroup(List<TimePlanGroup> planGourp, MedicRecordOperation operationRes) {

    List<TimePlanGroup> resultPlan = List<TimePlanGroup>();
     planGourp.forEach((val) {

       List<Plans> deletePlans = List<Plans>();
       val.plans.forEach((plan) {

          operationRes.operations.forEach((operation) {

            String day =  val.time.substring(0,"yyyy-MM-dd".length);
            String operationDay = DateUtil.formatDateMs(operation.takeTime , format: "yyyy-MM-dd"); // yyyy-MM-dd
            // plan.takeAt
            if(plan.id == operation.planId && day == operationDay) {

              deletePlans.add(plan);
//              val.plans.remove(plan);
            }
          });
       });
       deletePlans.forEach((delPlan) {
          val.plans.remove(delPlan);
       });

       if(val.plans.length > 0) {
         resultPlan.add(val);
       }
     });

     return resultPlan;
  }

   // 根据传入的时间，返回一组按照吃药时间相同的计划
  List<TimePlanGroup> getSameTimePlanGroup(int startTime, int endTime,List<Plans> plan) {

    Map<String, List<Plans>> medicMap = Map<String, List<Plans>>();

    plan.forEach((val){

      Map<String, Plans> mapPlan = getSameTimePlan(startTime, endTime, val);

      if(mapPlan.length > 0) {

        mapPlan.forEach((String key, Plans plan){

          List<Plans> hashPlan = medicMap[key];
          if(hashPlan == null) {
            hashPlan = List();
          }
          hashPlan.add(val);
          medicMap.putIfAbsent(key, ()=> hashPlan);
        });
      }

    });


    List<TimePlanGroup> timeList = List<TimePlanGroup>();

    medicMap.forEach((String key, List<Plans>plan){

      TimePlanGroup timeGroup = TimePlanGroup(key, plan);
      timeList.add(timeGroup);
    });

    return timeList;
  }

  // 根据传入的时间，返回吃药时间相同的计划
  Map<String, Plans> getSameTimePlan(int startTime, int endTime,Plans plan) {

    Map<String, Plans> medicMap = Map<String, Plans>();

    DateTime planDate;
    DateTime endDate = DateUtil.getDateTimeByMs(endTime);
    DateTime startDate = DateUtil.getDateTimeByMs(startTime);

    for(int start = startTime; (planDate == null || (planDate.compareTo(endDate) != 1)); start += 24*60*60*1000) {

      String ymdStr = DateUtil.formatDateMs(start, format: "yyyy-MM-dd"); // yyyy-MM-dd
      String hmStr = getTimeString([plan]); // HH:mm
      String timeStr = ymdStr+hmStr+":00";

      planDate = DateUtil.getDateTime(timeStr);

      if(planDate.compareTo(startDate) == 1 && (planDate.compareTo(endDate) == -1)) { // 计划的时间在区间内

        medicMap.putIfAbsent(timeStr, ()=> plan);
      }
    }
    return medicMap;
  }


   //region 属性的set、get方法
   void sortOutInputedOriginalDataSrouce(List<Plans> originalPlans) {

    List dataSourceArr = List();
    if(originalPlans.isEmpty) {

       return ;
    }

    //1、所有服药计划按照时间排序
    originalPlans.sort((left,right) {
      return  right.takeAt.compareTo(left.takeAt);
    });

     //2、得到所有药名的集合
    List medicineNames = List();
    for (Plans planModel in originalPlans) {

       var name = planModel.medicineHash;
       if(!medicineNames.contains(name)) {
         medicineNames.add(name);
       }
    }

     //4、遍历药名，根据药名得到GroupModel（分组模型）
    List tempDataSrouce = List();
    for(var eachName in medicineNames) {

      XZLTakeMedicineListGroupModel groupModel = XZLTakeMedicineListGroupModel();
      groupModel.groupIndex = medicineNames.indexOf(eachName);

      groupModel.cellStyle = XZLTakeMedicineListCellStyle.XZLTakeMedicineListCellListStyle;

      tempDataSrouce.add(groupModel);
      for (Plans plan in originalPlans) {

        if(eachName == plan.medicineHash)
        groupModel.addAPlanDataItem(plan);
      }

      tempDataSrouce.sort((left,right) {

         return 1;
      });
    }
//     NSMutableArray *tempDataSrouce = [NSMutableArray array];
//     for (NSString *eachName in medicineNames) {
//
//     XZLTakeMedicineListGroupModel *groupModel = [[XZLTakeMedicineListGroupModel alloc] init];
//     groupModel.groupIndex = [medicineNames indexOfObject:eachName];
//     if ([NSStringFromClass([self class]) isEqualToString:@"XZLTakeMedicineListController"]) {
//
//     groupModel.cellStyle = XZLTakeMedicineListCellListStyle;
//     } else {
//
//     groupModel.cellStyle = XZLTakeMedicineListCellHistoryListStyle;
//     }
//     [tempDataSrouce addObject:groupModel];
//
//     for (NSInteger i = 0; i < originalDataSrouce.count; i++) {
//
//     XZLMedicinePlanMetaInfo *jplanModel = [originalDataSrouce objectAtIndex:i];
//     if ([NSStringFromClass([self class]) isEqualToString:@"XZLTakeMedicineHistoryViewController"]) {
//     if ([eachName isEqualToString:jplanModel.medicineName]) {
//
//     [groupModel addAPlanDataItem:jplanModel];
//     }
//     } else {
//     if ([eachName isEqualToString:jplanModel.medicineHash]) {
//
//     [groupModel addAPlanDataItem:jplanModel];
//     }
//     }
//     }
//     }
//
//     [tempDataSrouce sortUsingComparator:^NSComparisonResult(XZLTakeMedicineListGroupModel *obj1, XZLTakeMedicineListGroupModel *obj2) {
//
//     return obj1.pillBoxPostionIndex > obj2.pillBoxPostionIndex;
//     }];
//     self.dataSourceArr = tempDataSrouce;
//
//     dispatch_async(dispatch_get_main_queue(), ^{
//
//     [self.listTableView reloadData];
//     });
   }

   //endregion


}

