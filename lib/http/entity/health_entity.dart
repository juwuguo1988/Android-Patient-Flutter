import 'dart:convert' show json;
import 'package:patient/utils/entity_factory.dart';

class HealthModel {
  List<RiskAssessment> riskAssessment;
  List<MedicineInspection> medicineInspection;
  List<LifeStandard> lifeStandard;

  HealthModel({
    this.riskAssessment,
    this.medicineInspection,
    this.lifeStandard,
  });

  static HealthModel fromJson(jsonRes) {
    if (jsonRes == null) return null;

    List<RiskAssessment> riskAssessment =
        jsonRes['riskAssessment'] is List ? [] : null;
    if (riskAssessment != null) {
      for (var item in jsonRes['riskAssessment']) {
        if (item != null) {
          tryCatch(() {
            riskAssessment.add(RiskAssessment.fromJson(item));
          });
        }
      }
    }

    List<MedicineInspection> medicineInspection =
        jsonRes['medicineInspection'] is List ? [] : null;
    if (medicineInspection != null) {
      for (var item in jsonRes['medicineInspection']) {
        if (item != null) {
          tryCatch(() {
            medicineInspection.add(MedicineInspection.fromJson(item));
          });
        }
      }
    }

    List<LifeStandard> lifeStandard =
        jsonRes['lifeStandard'] is List ? [] : null;
    if (lifeStandard != null) {
      for (var item in jsonRes['lifeStandard']) {
        if (item != null) {
          tryCatch(() {
            lifeStandard.add(LifeStandard.fromJson(item));
          });
        }
      }
    }
    return HealthModel(
      riskAssessment: riskAssessment,
      medicineInspection: medicineInspection,
      lifeStandard: lifeStandard,
    );
  }

  Map<String, dynamic> toJson() => {
        'riskAssessment': riskAssessment,
        'medicineInspection': medicineInspection,
        'lifeStandard': lifeStandard,
      };
  @override
  String toString() {
    return json.encode(this);
  }
}

class RiskAssessment {
  String name;
  String valueTitle;
  String value;
  List<String> reason;
  List<String> withoutReason;
  String status;

  RiskAssessment({
    this.name,
    this.valueTitle,
    this.value,
    this.reason,
    this.withoutReason,
    this.status,
  });

  static RiskAssessment fromJson(jsonRes) {
    if (jsonRes == null) return null;

    List<String> withoutReason = jsonRes['withoutReason'] is List ? [] : null;
    if (withoutReason != null) {
      for (var item in jsonRes['withoutReason']) {
        if (item != null) {
          tryCatch(() {
            withoutReason.add(item);
          });
        }
      }
    }
    List<String> reason = jsonRes['reason'] is List ? [] : null;
    if (reason != null) {
      for (var item in jsonRes['reason']) {
        if (item != null) {
          tryCatch(() {
            reason.add(item);
          });
        }
      }
    }
    return RiskAssessment(
      name: convertValueByType(jsonRes['name'], String,
          stack: "RiskAssessment-name"),
      valueTitle: convertValueByType(jsonRes['valueTitle'], String,
          stack: "RiskAssessment-valueTitle"),
      value: convertValueByType(jsonRes['value'], String,
          stack: "RiskAssessment-value"),
      reason: reason,
      withoutReason: withoutReason,
      status: convertValueByType(jsonRes['status'], String,
          stack: "RiskAssessment-status"),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'valueTitle': valueTitle,
        'value': value,
        'reason': reason,
        'withoutReason': withoutReason,
        'status': status,
      };
  @override
  String toString() {
    return json.encode(this);
  }
}

class MedicineInspection {
  String name;
  String referenceValue;
  String realValue;
  String status;

  MedicineInspection({
    this.name,
    this.referenceValue,
    this.realValue,
    this.status,
  });

  static MedicineInspection fromJson(jsonRes) => jsonRes == null
      ? null
      : MedicineInspection(
          name: convertValueByType(jsonRes['name'], String,
              stack: "MedicineInspection-name"),
          referenceValue: convertValueByType(jsonRes['referenceValue'], String,
              stack: "MedicineInspection-referenceValue"),
          realValue: convertValueByType(jsonRes['realValue'], String,
              stack: "MedicineInspection-realValue"),
          status: convertValueByType(jsonRes['status'], String,
              stack: "MedicineInspection-status"),
        );

  Map<String, dynamic> toJson() => {
        'name': name,
        'referenceValue': referenceValue,
        'realValue': realValue,
        'status': status,
      };
  @override
  String toString() {
    return json.encode(this);
  }
}

class LifeStandard {
  String name;
  String referenceValue;
  Object realValue;
  String type;
  String unit;
  Object status;

  LifeStandard({
    this.name,
    this.referenceValue,
    this.realValue,
    this.type,
    this.unit,
    this.status,
  });

  static LifeStandard fromJson(jsonRes) => jsonRes == null
      ? null
      : LifeStandard(
          name: convertValueByType(jsonRes['name'], String,
              stack: "LifeStandard-name"),
          referenceValue: convertValueByType(jsonRes['referenceValue'], String,
              stack: "LifeStandard-referenceValue"),
          realValue: convertValueByType(jsonRes['realValue'], Null,
              stack: "LifeStandard-realValue"),
          type: convertValueByType(jsonRes['type'], String,
              stack: "LifeStandard-type"),
          unit: convertValueByType(jsonRes['unit'], String,
              stack: "LifeStandard-unit"),
          status: convertValueByType(jsonRes['status'], Null,
              stack: "LifeStandard-status"),
        );

  Map<String, dynamic> toJson() => {
        'name': name,
        'referenceValue': referenceValue,
        'realValue': realValue,
        'type': type,
        'unit': unit,
        'status': status,
      };
  @override
  String toString() {
    return json.encode(this);
  }
}
