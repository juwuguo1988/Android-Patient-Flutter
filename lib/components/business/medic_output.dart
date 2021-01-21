
import 'package:patient/http/entity/medic/medic_plan_model.dart';
import 'package:patient/components/business/medic_model_domain.dart';
import 'package:patient/components/business/medic_time_domain.dart';
import 'package:patient/components/business/medic_day_domain.dart';

import 'package:patient/utils/date_util.dart';

typedef OutputCallBack = void Function(List<Plans> resultArr);

typedef OutConditionBack = bool Function(XZLTimeDomainMetaDataModel metaDataModel);


class XZLTakeMedicinePlanOutput {

 XZLMedicinePlanTakeTimeDomain _medicinePlanTimeDomain;

 List _expandAndMatchedResults;

 OutputCallBack outputCallBack;

 var avalibleTotalWidth;

 XZLTakeMedicinePlanOutput(){

   _medicinePlanTimeDomain = XZLMedicinePlanTakeTimeDomain();
 }


  /** 异步取出 大于当前时段（即：将来的）的所有服药计划 */
  void asyncOutputFutureAllDayMeicineList(OutputCallBack callback) async {

    outputCallBack = callback;

    // 异步全局队列
    List localNoticeArr = List();

    List<Plans> queryResultArr = await syncOutput48HDomainMedicinePlansInMeetConditions((XZLTimeDomainMetaDataModel metaDomain){

      if(metaDomain.absoluteTakeStartMsec > _medicinePlanTimeDomain.nowTime) {

        localNoticeArr.add(metaDomain);
        return true;
      } else {
        return false;
      }
    });

    if(outputCallBack != null) {
      outputCallBack(queryResultArr);
    }
  }

  /** 按照指定的条件 同步遍历所有元时域模型 并返回满足条件的计划模型数组 */
 Future<List<Plans>> syncOutput48HDomainMedicinePlansInMeetConditions(OutConditionBack conditionCall) async {

    _medicinePlanTimeDomain.spaceMin = 30;
    _medicinePlanTimeDomain.isStrictStyle = false;

    _expandAndMatchedResults = await _medicinePlanTimeDomain.expandAndMatchOriginalMedicinePlanDataToTime48HDomain();

    List<Plans> queryFutureMedicineList = List();
    for (XZLTimeDomainDayNodeRange dayDomainRange in _expandAndMatchedResults ) {

      for (XZLTimeDomainMetaDataModel metaDomainRange in dayDomainRange.domainMetaDataArr) {
        if (metaDomainRange.matchedMedicinePlans.isNotEmpty) {

          if(conditionCall != null && conditionCall(metaDomainRange)) {

            for(Plans metaInfo in metaDomainRange.matchedMedicinePlans) {

              if(!queryFutureMedicineList.contains(metaInfo)) {
                queryFutureMedicineList.add(metaInfo);
              }
            }
          }
        }
      }
    }
    return queryFutureMedicineList;
  }

}