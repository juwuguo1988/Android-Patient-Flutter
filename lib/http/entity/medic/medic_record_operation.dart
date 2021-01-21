import 'package:json_annotation/json_annotation.dart';

part 'medic_record_operation.g.dart';


@JsonSerializable()
class MedicRecordOperation extends Object {

  @JsonKey(name: 'operations')
  List<Operations> operations;

  MedicRecordOperation(this.operations,);

  factory MedicRecordOperation.fromJson(Map<String, dynamic> srcJson) => _$MedicRecordOperationFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MedicRecordOperationToJson(this);

}


@JsonSerializable()
class Operations extends Object {

  @JsonKey(name: 'medicineId')
  String medicineId;

  @JsonKey(name: 'medicineName')
  String medicineName;

  @JsonKey(name: 'planId')
  String planId;

  @JsonKey(name: 'takeTime')
  int takeTime;

  @JsonKey(name: 'count')
  int count;

  @JsonKey(name: 'dosage')
  int dosage;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'source')
  int source;

  @JsonKey(name: 'confirmedAt')
  int confirmedAt;

  Operations(this.medicineId,this.medicineName,this.planId,this.takeTime,this.count,this.dosage,this.status,this.source,this.confirmedAt,);

  factory Operations.fromJson(Map<String, dynamic> srcJson) => _$OperationsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OperationsToJson(this);

}


