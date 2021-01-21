// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medic_record_operation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicRecordOperation _$MedicRecordOperationFromJson(Map<String, dynamic> json) {
  return MedicRecordOperation(
    (json['operations'] as List)
        ?.map((e) =>
            e == null ? null : Operations.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MedicRecordOperationToJson(
        MedicRecordOperation instance) =>
    <String, dynamic>{
      'operations': instance.operations,
    };

Operations _$OperationsFromJson(Map<String, dynamic> json) {
  return Operations(
    json['medicineId'] as String,
    json['medicineName'] as String,
    json['planId'] as String,
    json['takeTime'] as int,
    json['count'] as int,
    json['dosage'] as int,
    json['status'] as int,
    json['source'] as int,
    json['confirmedAt'] as int,
  );
}

Map<String, dynamic> _$OperationsToJson(Operations instance) =>
    <String, dynamic>{
      'medicineId': instance.medicineId,
      'medicineName': instance.medicineName,
      'planId': instance.planId,
      'takeTime': instance.takeTime,
      'count': instance.count,
      'dosage': instance.dosage,
      'status': instance.status,
      'source': instance.source,
      'confirmedAt': instance.confirmedAt,
    };
