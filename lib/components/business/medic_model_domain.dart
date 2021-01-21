
import 'package:patient/http/entity/medic/medic_plan_model.dart';
import 'package:patient/http/entity/medic/medic_record_operation.dart';

class XZLTimeDomainMetaDataModel {

  /// 服药的绝对开始时间（毫秒值)
  int absoluteTakeStartMsec;

  /// 服药的绝对结束时间（毫秒值）
  int absoluteTakeEndMsec;

  String takeAtTime;
  int takeAtMinIndex;
  /// 参与项目
  String clinicalProjectId;
  /// 对于临床项目，他的药下的下一个服药点
  int nextTime;
  /// 所属计划下是否有参与项目的计划
  bool hasClinicalProject;
  List<Plans> matchedMedicinePlans;



  void addOriginalDataModel(Plans originalData) {

    if(matchedMedicinePlans == null) {
      matchedMedicinePlans = List();
    }
    matchedMedicinePlans.add(originalData);
  }
}