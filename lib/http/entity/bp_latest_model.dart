import 'package:patient/utils/entity_factory.dart';
import 'dart:convert' show json;

class BpLatest {

  int high;
  int low;
  String bpStatus;
  int heartRate;
  String heartRateStatus;
  int measuredAt;
  Object year;
  int referenceBpMax;
  int referenceBpMin;
  int referenceHeartRateMax;
  int referenceHeartRateMin;

  BpLatest({
    this.high,
    this.low,
    this.bpStatus,
    this.heartRate,
    this.heartRateStatus,
    this.measuredAt,
    this.year,
    this.referenceBpMax,
    this.referenceBpMin,
    this.referenceHeartRateMax,
    this.referenceHeartRateMin,
  });

  static BpLatest fromJson(jsonRes)=>jsonRes == null? null:BpLatest(
    high : convertValueByType(jsonRes['high'],int,stack:"BpLatest-high"),
    low : convertValueByType(jsonRes['low'],int,stack:"BpLatest-low"),
    bpStatus : convertValueByType(jsonRes['bpStatus'],String,stack:"BpLatest-bpStatus"),
    heartRate : convertValueByType(jsonRes['heartRate'],int,stack:"BpLatest-heartRate"),
    heartRateStatus : convertValueByType(jsonRes['heartRateStatus'],String,stack:"BpLatest-heartRateStatus"),
    measuredAt : convertValueByType(jsonRes['measuredAt'],int,stack:"BpLatest-measuredAt"),
    year : convertValueByType(jsonRes['year'],Null,stack:"BpLatest-year"),
    referenceBpMax : convertValueByType(jsonRes['referenceBpMax'],int,stack:"BpLatest-referenceBpMax"),
    referenceBpMin : convertValueByType(jsonRes['referenceBpMin'],int,stack:"BpLatest-referenceBpMin"),
    referenceHeartRateMax : convertValueByType(jsonRes['referenceHeartRateMax'],int,stack:"BpLatest-referenceHeartRateMax"),
    referenceHeartRateMin : convertValueByType(jsonRes['referenceHeartRateMin'],int,stack:"BpLatest-referenceHeartRateMin"),);

  Map<String, dynamic> toJson() => {
    'high': high,
    'low': low,
    'bpStatus': bpStatus,
    'heartRate': heartRate,
    'heartRateStatus': heartRateStatus,
    'measuredAt': measuredAt,
    'year': year,
    'referenceBpMax': referenceBpMax,
    'referenceBpMin': referenceBpMin,
    'referenceHeartRateMax': referenceHeartRateMax,
    'referenceHeartRateMin': referenceHeartRateMin,
  };
  @override
  String  toString() {
    return json.encode(this);
  }
}