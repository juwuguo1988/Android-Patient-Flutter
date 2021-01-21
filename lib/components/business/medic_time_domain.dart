
import 'package:patient/utils/date_util.dart';
import 'package:patient/common/database/database_helper.dart';

import 'package:patient/http/entity/medic/medic_plan_model.dart';
import 'package:patient/http/entity/medic/medic_record_operation.dart';
import 'package:patient/components/business/medic_day_domain.dart';
import 'package:patient/components/business/medic_model_domain.dart';


class XZLMedicinePlanTakeTimeDomain {

  /// 指定时域起始时间（毫秒值）
  int _domainStart;
  /// 指定时域终止时间（毫秒值
  int _domainEnd;
  /// 当前时间（毫秒值）
  int _nowTime;
  /// 一整天的毫秒值
  final allDayMsecs = 24*60*60*1000;
  /// 是否按照严格模式进行筛选（严格模式则只输出未来一天内的数据，非严格模式输出未来的数据不区分日域进行匹配）
  /// 默认为：YES
  /// 注：非严格模式则需要把重复性的的统一看成每天重复
  var _isStrictStyle = true;
  /// 服药计划的时间间隔（单位：分钟）
  var _spaceMin = 30;

  int get nowTime{
    return _nowTime;
  }

  set nowTime(num value){
    _nowTime = value;
    _domainStart = nowTime - allDayMsecs;
    if(_isStrictStyle) {

      _domainEnd = nowTime + allDayMsecs;
    } else {

      _domainEnd = nowTime + allDayMsecs *2;
    }
  }

  set isStrictStyle(bool isStrictStyle) {
    _isStrictStyle = isStrictStyle;
  }
  set spaceMin(int spaceMin) {
    _spaceMin = spaceMin;
  }


  /** 指定时间域 的开始和结束 一般化的扩展和匹配结果 */
  Future<List> expandAndMatchOriginalMedicinePlanDataToTimeDomain() async {

     //0、求解在开始-结束的时域内 所有的以天/日 为单位的节点集合
    String operationDay = DateUtil.formatDateMs(_domainStart , format: "yyyy-MM-dd"); // yyyy-MM-dd
    operationDay = operationDay + ' 00:00:00';
    var startDomainDayStart = DateUtil.getDateMsByTimeStr(operationDay);

    List subDomainDayNodes = List();
    var discoverdOneNode = startDomainDayStart;
    do {
      subDomainDayNodes.add(discoverdOneNode);
      discoverdOneNode+=allDayMsecs;

    } while (discoverdOneNode < _domainEnd);
    if(subDomainDayNodes.isNotEmpty) {

      subDomainDayNodes.removeAt(0);
      subDomainDayNodes.insert(0, _domainStart);
    }
    subDomainDayNodes.add(_domainEnd);

    //1、根据日时域节点 生成日时域节点的模型
    List dayNodeRanges = List();
    if(subDomainDayNodes.isNotEmpty) {

      var nodeRrangeStart, nodeRrangeEnd;
      for(var i = 0; i < subDomainDayNodes.length-1; i++) {

        nodeRrangeStart = subDomainDayNodes[i];
        nodeRrangeEnd = subDomainDayNodes[i+1]-1000;

        var dayNodeRange = XZLTimeDomainDayNodeRange(_spaceMin);
        dayNodeRange.isStrictStyle = _isStrictStyle;
        dayNodeRange.nodeStartValue = nodeRrangeStart;
        dayNodeRange.nodeEndValue = nodeRrangeEnd;

        dayNodeRanges.add(dayNodeRange);
      }
    }

    //2、查询出所有服药计划（不管是不是服过还是编辑还是删除过）
    //然后分别映射到求得的日时域节点区间 并扩展生成其元时间域模型 然后
    //存入到该模型里
    if(dayNodeRanges.isNotEmpty) {

      // 从数据库中拿计划
      List<Plans> allTakeMedicinePlans = await DataBaseHelper().queryAllTakeMedicinePlanModels();
      allTakeMedicinePlans.sort((left,right) => right.medicineName.compareTo(left.medicineName));

      // 过滤所有服药计划
      for(int i = 0; i<dayNodeRanges.length; i++) {

        XZLTimeDomainDayNodeRange dayNodeRange = dayNodeRanges[i];
        allTakeMedicinePlans.forEach((planModel) {
          dayNodeRange.receiveOriginalData(planModel);
        });

        // 删除 日时间域内 服药计划为空的元时间域
        List needDeleteMetaDomains = List();
        for(XZLTimeDomainMetaDataModel metaDataDomain in dayNodeRange.domainMetaDataArr) {
          if(metaDataDomain.matchedMedicinePlans.isEmpty) {
            needDeleteMetaDomains.add(metaDataDomain);
          }
        }
        for (XZLTimeDomainMetaDataModel metaDataDomain in needDeleteMetaDomains) {

          dayNodeRange.domainMetaDataArr.remove(metaDataDomain);
        }
        //对 日时间域内 所有的元时间域 进行从小到大排序
        dayNodeRange.domainMetaDataArr.sort((left,right) => right.takeAtMinIndex.compareTo(left.takeAtMinIndex));
      }
    }
    return dayNodeRanges;
  }

  Future<List> expandAndMatchOriginalMedicinePlanDataToTime48HDomain () {

    this.nowTime = DateUtil.getNowDateMs();

    Future<List> expandAndMatchedResult = expandAndMatchOriginalMedicinePlanDataToTimeDomain();

    return expandAndMatchedResult;
  }

}


