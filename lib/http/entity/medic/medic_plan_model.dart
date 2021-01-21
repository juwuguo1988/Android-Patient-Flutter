import 'dart:convert' show json;
import 'package:patient/utils/entity_factory.dart';


class PlanModel {
  List<Plans> plans;

  PlanModel({
    this.plans,
  });

  static PlanModel fromJson(jsonRes) {
    if (jsonRes == null) return null;

    List<Plans> plans = jsonRes['plans'] is List ? [] : null;
    if (plans != null) {
      for (var item in jsonRes['plans']) {
        if (item != null) {
          tryCatch(() {
            plans.add(Plans.fromJson(item));
          });
        }
      }
    }
    return PlanModel(
      plans: plans,
    );
  }

  Map<String, dynamic> toJson() => {
        'plans': plans,
      };
  @override
  String toString() {
    return json.encode(this);
  }
}

class Plans {
  String id;
  int takeAt;
  String medicineId;
  String medicineName;
  String category;
  String medicineHash;
  int medicineVia;
  int count;
  int dosage;
  int cycleDays;
  int zone;
  int positionNo;
  String dosageUnit;
  int started;
  int ended;
  int remindFirstAt;
  String clinicalProjectId;
  String boxUuid;
  String planSeqWithBox;
  String dosageFormUnit;
  String commodityName;
  String ingredient;
  String isUnknown;
  List<String> imageId;

  Plans({
    this.id,
    this.takeAt,
    this.medicineId,
    this.medicineName,
    this.category,
    this.medicineHash,
    this.medicineVia,
    this.count,
    this.dosage,
    this.cycleDays,
    this.zone,
    this.positionNo,
    this.dosageUnit,
    this.started,
    this.ended,
    this.remindFirstAt,
    this.clinicalProjectId,
    this.boxUuid,
    this.planSeqWithBox,
    this.dosageFormUnit,
    this.commodityName,
    this.ingredient,
    this.isUnknown,
    this.imageId,
  });

  static Plans fromJson(jsonRes) {
    if (jsonRes == null) return null;

    List<String> imageId = jsonRes['imageId'] is List ? [] : null;
    if (imageId != null) {
      for (var item in jsonRes['imageId']) {
        if (item != null) {
          tryCatch(() {
            imageId.add(item);
          });
        }
      }
    }
    return Plans(
      id: convertValueByType(jsonRes['id'], String, stack: "Plans-id"),
      takeAt: convertValueByType(jsonRes['takeAt'], int, stack: "Plans-takeAt"),
      medicineId: convertValueByType(jsonRes['medicineId'], String,
          stack: "Plans-medicineId"),
      medicineName: convertValueByType(jsonRes['medicineName'], String,
          stack: "Plans-medicineName"),
      category: convertValueByType(jsonRes['category'], String,
          stack: "Plans-category"),
      medicineHash: convertValueByType(jsonRes['medicineHash'], String,
          stack: "Plans-medicineHash"),
      medicineVia: convertValueByType(jsonRes['medicineVia'], int,
          stack: "Plans-medicineVia"),
      count: convertValueByType(jsonRes['count'], int, stack: "Plans-count"),
      dosage: convertValueByType(jsonRes['dosage'], int, stack: "Plans-dosage"),
      cycleDays: convertValueByType(jsonRes['cycleDays'], int,
          stack: "Plans-cycleDays"),
      zone: convertValueByType(jsonRes['zone'], int, stack: "Plans-zone"),
      positionNo: convertValueByType(jsonRes['positionNo'], int,
          stack: "Plans-positionNo"),
      dosageUnit: convertValueByType(jsonRes['dosageUnit'], String,
          stack: "Plans-dosageUnit"),
      started:
          convertValueByType(jsonRes['started'], int, stack: "Plans-started"),
      ended: convertValueByType(jsonRes['ended'], int, stack: "Plans-ended"),
      remindFirstAt: convertValueByType(jsonRes['remindFirstAt'], int,
          stack: "Plans-remindFirstAt"),
      clinicalProjectId: convertValueByType(jsonRes['clinicalProjectId'], String,
          stack: "Plans-clinicalProjectId"),
      boxUuid:
          convertValueByType(jsonRes['boxUuid'], String, stack: "Plans-boxUuid"),
      planSeqWithBox: convertValueByType(jsonRes['planSeqWithBox'], String,
          stack: "Plans-planSeqWithBox"),
      dosageFormUnit: convertValueByType(jsonRes['dosageFormUnit'], String,
          stack: "Plans-dosageFormUnit"),
      commodityName: convertValueByType(jsonRes['commodityName'], String,
          stack: "Plans-commodityName"),
      ingredient: convertValueByType(jsonRes['ingredient'], String,
          stack: "Plans-ingredient"),
      isUnknown: convertValueByType(jsonRes['isUnknown'], String,
          stack: "Plans-isUnknown"),
      imageId: imageId,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'takeAt': takeAt,
        'medicineId': medicineId,
        'medicineName': medicineName,
        'category': category,
        'medicineHash': medicineHash,
        'medicineVia': medicineVia,
        'count': count,
        'dosage': dosage,
        'cycleDays': cycleDays,
        'zone': zone,
        'positionNo': positionNo,
        'dosageUnit': dosageUnit,
        'started': started,
        'ended': ended,
        'remindFirstAt': remindFirstAt,
        'clinicalProjectId': clinicalProjectId,
        'boxUuid': boxUuid,
        'planSeqWithBox': planSeqWithBox,
        'dosageFormUnit': dosageFormUnit,
        'commodityName': commodityName,
        'ingredient': ingredient,
        'isUnknown': isUnknown,
        'imageId': imageId,
      };
  @override
  String toString() {
    return json.encode(this);
  }

  bool isPillBoxTakeMedicinePlan() {

    if(positionNo == 0) {
      return false;
    }
    if(boxUuid.isEmpty) {
      return false;
    }
    return true;
  }

//region 辅助方法


//endregion

}
