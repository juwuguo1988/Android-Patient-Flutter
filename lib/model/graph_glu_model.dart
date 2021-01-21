import 'dart:convert' show json;
import 'package:patient/utils/entity_factory.dart';

class GraphGluRootModel {

  String status;
  GraphGluModel data;

  GraphGluRootModel({
    this.status,
    this.data,
  });

  static GraphGluRootModel fromJson(jsonRes)=>jsonRes == null? null:GraphGluRootModel(
    status : convertValueByType(jsonRes['status'],String,stack:"GraphGluRootModel-status"),
    data : GraphGluModel.fromJson(jsonRes['data']),);

  Map<String, dynamic> toJson() => {
    'status': status,
    'data': data,
  };
  @override
  String  toString() {
    return json.encode(this);
  }
}

class GraphGluModel {

  LatestGlu latestGlu;
  List<RecentlyGlu> recentlyGlu;

  GraphGluModel({
    this.latestGlu,
    this.recentlyGlu,
  });

  static GraphGluModel fromJson(jsonRes){ if(jsonRes == null) return null;


  List<RecentlyGlu> recentlyGlu = jsonRes['recentlyGlu'] is List ? []: null;
  if(recentlyGlu!=null) {
    for (var item in jsonRes['recentlyGlu']) { if (item != null) { tryCatch(() { recentlyGlu.add(RecentlyGlu.fromJson(item));  });  }
    }
  }
  return GraphGluModel(
    latestGlu : LatestGlu.fromJson(jsonRes['latestGlu']),
    recentlyGlu:recentlyGlu,);}

  Map<String, dynamic> toJson() => {
    'latestGlu': latestGlu,
    'recentlyGlu': recentlyGlu,
  };
  @override
  String  toString() {
    return json.encode(this);
  }
}

class LatestGlu {

  String typeName;
  String unit;
  double value;
  double max;
  double min;
  int measuredAt;
  String status;
  String type;

  LatestGlu({
    this.typeName,
    this.unit,
    this.value,
    this.max,
    this.min,
    this.measuredAt,
    this.status,
    this.type,
  });

  static LatestGlu fromJson(jsonRes)=>jsonRes == null? null:LatestGlu(
    typeName : convertValueByType(jsonRes['typeName'],String,stack:"LatestGlu-typeName"),
    unit : convertValueByType(jsonRes['unit'],String,stack:"LatestGlu-unit"),
    value : convertValueByType(jsonRes['value'],double,stack:"LatestGlu-value"),
    max : convertValueByType(jsonRes['max'],double,stack:"LatestGlu-max"),
    min : convertValueByType(jsonRes['min'],double,stack:"LatestGlu-min"),
    measuredAt : convertValueByType(jsonRes['measuredAt'],int,stack:"LatestGlu-measuredAt"),
    status : convertValueByType(jsonRes['status'],String,stack:"LatestGlu-status"),
    type : convertValueByType(jsonRes['type'],String,stack:"LatestGlu-type"),);

  Map<String, dynamic> toJson() => {
    'typeName': typeName,
    'unit': unit,
    'value': value,
    'max': max,
    'min': min,
    'measuredAt': measuredAt,
    'status': status,
    'type': type,
  };
  @override
  String  toString() {
    return json.encode(this);
  }
}

class RecentlyGlu {

  String type;
  String typeName;
  double max;
  double min;
  List<double> value;
  List<String> status;
  List<Time> time;

  RecentlyGlu({
    this.type,
    this.typeName,
    this.max,
    this.min,
    this.value,
    this.status,
    this.time,
  });

  static RecentlyGlu fromJson(jsonRes){ if(jsonRes == null) return null;


  List<double> value = jsonRes['value'] is List ? []: null;
  if(value!=null) {
    for (var item in jsonRes['value']) { if (item != null) { tryCatch(() { value.add(item);  });  }
    }
  }


  List<String> status = jsonRes['status'] is List ? []: null;
  if(status!=null) {
    for (var item in jsonRes['status']) { if (item != null) { tryCatch(() { status.add(item);  });  }
    }
  }


  List<Time> time = jsonRes['time'] is List ? []: null;
  if(time!=null) {
    for (var item in jsonRes['time']) { if (item != null) { tryCatch(() { time.add(Time.fromJson(item));  });  }
    }
  }
  return RecentlyGlu(
    type : convertValueByType(jsonRes['type'],String,stack:"RecentlyGlu-type"),
    typeName : convertValueByType(jsonRes['typeName'],String,stack:"RecentlyGlu-typeName"),
    max : convertValueByType(jsonRes['max'],double,stack:"RecentlyGlu-max"),
    min : convertValueByType(jsonRes['min'],double,stack:"RecentlyGlu-min"),
    value:value,
    status:status,
    time:time,);}

  Map<String, dynamic> toJson() => {
    'type': type,
    'typeName': typeName,
    'max': max,
    'min': min,
    'value': value,
    'status': status,
    'time': time,
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