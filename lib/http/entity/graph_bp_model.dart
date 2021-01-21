import 'dart:convert' show json;
import 'bp_latest_model.dart';
import 'package:patient/utils/entity_factory.dart';

class GraphBpRootModel {

  String status;
  GraphBpModel data;

  GraphBpRootModel({
    this.status,
    this.data,
  });

  static GraphBpRootModel fromJson(jsonRes)=>jsonRes == null? null:GraphBpRootModel(
    status : convertValueByType(jsonRes['status'],String,stack:"GraphBpRootModel-status"),
    data : GraphBpModel.fromJson(jsonRes['data']),);

  Map<String, dynamic> toJson() => {
    'status': status,
    'data': data,
  };
  @override
  String  toString() {
    return json.encode(this);
  }
}

class GraphBpModel {

  GraphBp graphBp;
  GraphHeartRate graphHeartRate;
  BpLatest bpLatest;

  GraphBpModel({
    this.graphBp,
    this.graphHeartRate,
    this.bpLatest,
  });

  static GraphBpModel fromJson(jsonRes) {
    print("jsonRes $jsonRes ${jsonRes.runtimeType}");
    if(jsonRes == null) return null;
    return GraphBpModel(
      graphBp : GraphBp.fromJson(jsonRes['graphBp']),
      graphHeartRate : GraphHeartRate.fromJson(jsonRes['graphHeartRate']),
      bpLatest : BpLatest.fromJson(jsonRes['bpLatest']),);
  }

  Map<String, dynamic> toJson() => {
    'graphBp': graphBp,
    'graphHeartRate': graphHeartRate,
    'bpLatest': bpLatest,
  };
  @override
  String  toString() {
    return json.encode(this);
  }
}

class GraphBp {

  List<Time> time;
  List<int> high;
  List<int> low;
  List<String> status;

  GraphBp({
    this.time,
    this.high,
    this.low,
    this.status,
  });

  static GraphBp fromJson(jsonRes){ if(jsonRes == null) return null;


  List<Time> time = jsonRes['time'] is List ? []: null;
  if(time!=null) {
    for (var item in jsonRes['time']) { if (item != null) { tryCatch(() { time.add(Time.fromJson(item));  });  }
    }
  }


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
  return GraphBp(
    time:time,
    high:high,
    low:low,
    status:status,);}

  Map<String, dynamic> toJson() => {
    'time': time,
    'high': high,
    'low': low,
    'status': status,
  };
  @override
  String  toString() {
    return json.encode(this);
  }
}

class Time {

  int year;
  int time;

  Time({
    this.year,
    this.time,
  });

  static Time fromJson(jsonRes)=>jsonRes == null? null:Time(
    year : convertValueByType(jsonRes['year'],int,stack:"Time-year"),
    time : convertValueByType(jsonRes['time'],int,stack:"Time-time"),);

  Map<String, dynamic> toJson() => {
    'year': year,
    'time': time,
  };
  @override
  String  toString() {
    return json.encode(this);
  }
}

class GraphHeartRate {

  List<Time> time;
  List<int> heartRate;
  List<String> status;

  GraphHeartRate({
    this.time,
    this.heartRate,
    this.status,
  });

  static GraphHeartRate fromJson(jsonRes){ if(jsonRes == null) return null;


  List<Time> time = jsonRes['time'] is List ? []: null;
  if(time!=null) {
    for (var item in jsonRes['time']) { if (item != null) { tryCatch(() { time.add(Time.fromJson(item));  });  }
    }
  }


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
  return GraphHeartRate(
    time:time,
    heartRate:heartRate,
    status:status,);}

  Map<String, dynamic> toJson() => {
    'time': time,
    'heartRate': heartRate,
    'status': status,
  };
  @override
  String  toString() {
    return json.encode(this);
  }
}

//class Time {
//
//  int year;
//  int time;
//
//  Time({
//    this.year,
//    this.time,
//  });
//
//  static Time fromJson(jsonRes)=>jsonRes == null? null:Time(
//    year : convertValueByType(jsonRes['year'],int,stack:"Time-year"),
//    time : convertValueByType(jsonRes['time'],int,stack:"Time-time"),);
//
//  Map<String, dynamic> toJson() => {
//    'year': year,
//    'time': time,
//  };
//  @override
//  String  toString() {
//    return json.encode(this);
//  }
//}

