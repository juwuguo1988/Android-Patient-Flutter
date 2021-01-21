import 'dart:convert' show json;
import 'bp_latest_model.dart';
import 'package:patient/utils/entity_factory.dart';

class RecentBpRootModel {

  String status;
  RecentBpModel data;

  RecentBpRootModel({
    this.status,
    this.data,
  });

  static RecentBpRootModel fromJson(jsonRes)=>jsonRes == null? null:RecentBpRootModel(
    status : convertValueByType(jsonRes['status'],String,stack:"RecentBpRootModel-status"),
    data : RecentBpModel.fromJson(jsonRes['data']),);

  Map<String, dynamic> toJson() => {
    'status': status,
    'data': data,
  };
  @override
  String  toString() {
    return json.encode(this);
  }
}

class RecentBpModel {

  BpInSevenDay bpInSevenDay;
  HeartRateInSevenDay heartRateInSevenDay;
  BpLatest bpLatest;

  RecentBpModel({
    this.bpInSevenDay,
    this.heartRateInSevenDay,
    this.bpLatest,
  });

  static RecentBpModel fromJson(jsonRes)=>jsonRes == null? null:RecentBpModel(
    bpInSevenDay : BpInSevenDay.fromJson(jsonRes['bpInSevenDay']),
    heartRateInSevenDay : HeartRateInSevenDay.fromJson(jsonRes['heartRateInSevenDay']),
    bpLatest : BpLatest.fromJson(jsonRes['bpLatest']),);

  Map<String, dynamic> toJson() => {
    'bpInSevenDay': bpInSevenDay,
    'heartRateInSevenDay': heartRateInSevenDay,
    'bpLatest': bpLatest,
  };
  @override
  String  toString() {
    return json.encode(this);
  }
}

class BpInSevenDay {

  List<int> high;
  List<int> low;
  List<String> status;

  BpInSevenDay({
    this.high,
    this.low,
    this.status,
  });

  static BpInSevenDay fromJson(jsonRes){ if(jsonRes == null) return null;


  List<int> high = jsonRes['high'] is List ? []: null;
  if(high!=null) {
    for (var item in jsonRes['high']) { if (item != null) { tryCatch(() { high.add(item);  });  }
    }
  }


  List<int> low = jsonRes['low'] is List ? []: null;
  if(low!=null) {
    for (var item in jsonRes['low']) { if (item != null) { tryCatch(() { low.add(item);  });  }
    }
  }


  List<String> status = jsonRes['status'] is List ? []: null;
  if(status!=null) {
    for (var item in jsonRes['status']) { if (item != null) { tryCatch(() { status.add(item);  });  }
    }
  }
  return BpInSevenDay(
    high:high,
    low:low,
    status:status,);}

  Map<String, dynamic> toJson() => {
    'high': high,
    'low': low,
    'status': status,
  };
  @override
  String  toString() {
    return json.encode(this);
  }
}

class HeartRateInSevenDay {

  List<int> heartRate;
  List<String> status;

  HeartRateInSevenDay({
    this.heartRate,
    this.status,
  });

  static HeartRateInSevenDay fromJson(jsonRes){ if(jsonRes == null) return null;


  List<int> heartRate = jsonRes['heartRate'] is List ? []: null;
  if(heartRate!=null) {
    for (var item in jsonRes['heartRate']) { if (item != null) { tryCatch(() { heartRate.add(item);  });  }
    }
  }


  List<String> status = jsonRes['status'] is List ? []: null;
  if(status!=null) {
    for (var item in jsonRes['status']) { if (item != null) { tryCatch(() { status.add(item);  });  }
    }
  }
  return HeartRateInSevenDay(
    heartRate:heartRate,
    status:status,);}

  Map<String, dynamic> toJson() => {
    'heartRate': heartRate,
    'status': status,
  };
  @override
  String  toString() {
    return json.encode(this);
  }
}

