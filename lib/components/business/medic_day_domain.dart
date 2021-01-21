import 'package:patient/utils/date_util.dart';
import 'package:patient/http/entity/medic/medic_plan_model.dart';
import 'package:patient/components/business/medic_model_domain.dart';
import 'package:sprintf/sprintf.dart';

class XZLTimeDomainDayNodeRange {


  // 是否按照严格模式进行筛选（严格模式则只输出未来一天内的数据，
  //  非严格模式输出未来的数据不区分日域进行匹配）
  //  注：非严格模式则需要把重复性的的统一看成每天重复
  var isStrictStyle;

  // 日时域节点区间所在年月日时间表示 yyyy-MM-dd
  String nodeYMD;

  // 服药计划的时间间隔（单位：分钟）默认15分钟
  var spaceMin;

  // 节点始端时间 对应当天分钟计时的 索引值 如：960 表示当天 16:00
  int nodeStartMinValue;

  // 同nodeStartMinValue 表示节点末端时间 以分钟计时的 索引值
  int nodeEndMinValue;

  // 日时域节点开始时间（毫秒值）
  var _nodeStartValue;

  // 日时域节点结束时间（毫秒值）
  var _nodeEndValue;

  // 日时域区间内 接受到原始数据后 生成的【元时间域】数据模型数组
  List domainMetaDataArr;


  XZLTimeDomainDayNodeRange(int spaceMin){
    this.spaceMin = spaceMin;
    domainMetaDataArr = List();
  }

  //region 属性的set、get方法
  int get nodeStartValue{
    return _nodeStartValue;
  }

  set nodeStartValue(num value){
    _nodeStartValue = value;
    String hmValue = DateUtil.formatDateMs(nodeStartValue , format: "H:m"); // yyyy-MM-dd
    List<String> hmList = hmValue.split(":");
    nodeStartMinValue = int.parse(hmList.first)*60+int.parse(hmList.last);

    if(nodeStartValue > 0 && nodeYMD == null) {

      nodeYMD = DateUtil.formatDateMs(nodeStartValue , format: "yyyy-MM-dd"); // yyyy-MM-dd
    }
  }

  int get nodeEndValue{
    return _nodeEndValue;
  }

  set nodeEndValue(num value){
    _nodeEndValue = value;
    String hmValue = DateUtil.formatDateMs(nodeEndValue , format: "H:m"); // yyyy-MM-dd
    List<String> hmList = hmValue.split(":");
    nodeEndMinValue = int.parse(hmList.first)*60+int.parse(hmList.last);
  }

  //endregion

  /** 接收原始数据模型 */
  void receiveOriginalData(Plans originalData) {

    if(originalData.ended > 0) {
      if(originalData.ended < nodeStartValue) {
        return;
      }
    }

    int remindFirstAt = originalData.remindFirstAt;
    if(remindFirstAt <= nodeEndValue) {

      int planTakeAtMinIndex = originalData.takeAt;
      if(isInThisDayNodeDomain(planTakeAtMinIndex)) {

        bool isJoinThisPlanModelToDayNodeDamin = canJoinThisPlanModelToDayNodeDamin(originalData, remindFirstAt);
        if(isJoinThisPlanModelToDayNodeDamin) {

          XZLTimeDomainMetaDataModel domainMetaData = getAvailableDomainMetaDataModelMatchMinIndex(planTakeAtMinIndex, originalData.clinicalProjectId);
          if(originalData.ended == 0) {
            domainMetaData.addOriginalDataModel(originalData);
          } else {
            if(originalData.ended >= domainMetaData.absoluteTakeStartMsec) {
              domainMetaData.addOriginalDataModel(originalData);
            }
          }
        }
      }
    }
  }

  bool isInThisDayNodeDomain(int receiveMinIndex) {

    return receiveMinIndex >= nodeStartMinValue && receiveMinIndex <= nodeEndMinValue;
  }

  bool canJoinThisPlanModelToDayNodeDamin(Plans originalData,int remindFirstAt) {

    bool isJoinThisPlanModelToDayNodeDamin = false;
    if(originalData.cycleDays == 0) { // 每天的服药计划

      isJoinThisPlanModelToDayNodeDamin = true;
    } else if(originalData.cycleDays == 1) { // 隔天的服药计划

      String commonYMDStampStr = DateUtil.formatDateMs(nodeEndValue , format: "yyyy-MM-dd");
      int commonYMDStamp = (int.parse(commonYMDStampStr) * 0.001 / (24 * 60 * 60)).floor();

      String remindFirstAtYMD = DateUtil.formatDateMs(originalData.remindFirstAt , format: "yyyy-MM-dd");
      int remindFirstAtYMDStamp = (int.parse(commonYMDStampStr) * 0.001 / (24 * 60 * 60)).floor();

      if(isStrictStyle) {

        if((commonYMDStamp - remindFirstAtYMDStamp) %2 == 0) {

          isJoinThisPlanModelToDayNodeDamin = true;
        }
      } else {

        isJoinThisPlanModelToDayNodeDamin = true;
      }
    } else { // 临时，单次的服药计划

      if(remindFirstAt >= nodeStartValue) {
        isJoinThisPlanModelToDayNodeDamin = true;
      }
    }
    return isJoinThisPlanModelToDayNodeDamin;
  }

  XZLTimeDomainMetaDataModel getAvailableDomainMetaDataModelMatchMinIndex(int minIndex, String participateInProject) {

    XZLTimeDomainMetaDataModel targetMetaDomainData;

    for (XZLTimeDomainMetaDataModel metaDomainData in domainMetaDataArr) {

      // 同一个metaDataDomain下的计划要根据是否参与临床区分，不参与临床的在一个卡片，参与临床的每个计划单独一个卡片
      if (metaDomainData.takeAtMinIndex == minIndex) {

        if ((participateInProject == null || participateInProject.isEmpty)  && (metaDomainData.clinicalProjectId == null || metaDomainData.clinicalProjectId.isEmpty)) {
          targetMetaDomainData = metaDomainData;
          break;
        }
      }
    }

    if(targetMetaDomainData == null) {

      targetMetaDomainData = XZLTimeDomainMetaDataModel();
      targetMetaDomainData.takeAtMinIndex = minIndex;
      targetMetaDomainData.clinicalProjectId = participateInProject;
 
      String takeAtTime = sprintf('%.2d:%.2d', [(minIndex/60).floor(),(minIndex%60).floor()]);
      targetMetaDomainData.takeAtTime = takeAtTime;

      String absoluteTakeTimeStr = sprintf("%s %s:00",[nodeYMD,takeAtTime]);
      DateUtil.getDateStrByTimeStr(absoluteTakeTimeStr,format: DateFormat.YEAR_MONTH_DAY_HOUR_MINUTE);
      DateTime planDate = DateUtil.getDateTime(absoluteTakeTimeStr);

      targetMetaDomainData.absoluteTakeStartMsec = planDate.millisecondsSinceEpoch;

      targetMetaDomainData.absoluteTakeEndMsec =
          targetMetaDomainData.absoluteTakeStartMsec + spaceMin*60*1000 - 1000;
      [domainMetaDataArr.add(targetMetaDomainData)];
    }

    return targetMetaDomainData;
  }

}
