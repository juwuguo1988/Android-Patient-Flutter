
import 'dart:convert' show json;
import 'package:flutter/foundation.dart';
import 'package:patient/utils/entity_factory.dart';


class PillBoxInfo {

  List<Boxes> boxes;

  PillBoxInfo({
    this.boxes,
  });

  static PillBoxInfo fromJson(jsonRes){ if(jsonRes == null) return null;


  List<Boxes> boxes = jsonRes['boxes'] is List ? []: null;
  if(boxes!=null) {
    for (var item in jsonRes['boxes']) { if (item != null) { tryCatch(() { boxes.add(Boxes.fromJson(item));  });  }
    }
  }
  return PillBoxInfo(
    boxes:boxes,);}

  Map<String, dynamic> toJson() => {
    'boxes': boxes,
  };
  @override
  String  toString() {
    return json.encode(this);
  }
}

class Boxes {

  String id;
  String boxType;
  String simNo;
  String iccid;
  String imei;
  String mac;
  String gsmVer;
  String boxVer;
  String userId;
  String imei4;
  String mcuVer;
  String bondStatus;
  int batteryRemain;
  bool inShock;
  int volume;
  String systemVer;

  Boxes({
    this.id,
    this.boxType,
    this.simNo,
    this.iccid,
    this.imei,
    this.mac,
    this.gsmVer,
    this.boxVer,
    this.userId,
    this.imei4,
    this.mcuVer,
    this.bondStatus,
    this.batteryRemain,
    this.inShock,
    this.volume,
    this.systemVer,
  });

  static Boxes fromJson(jsonRes)=>jsonRes == null? null:Boxes(
    id : convertValueByType(jsonRes['id'],String,stack:"Boxes-id"),
    boxType : convertValueByType(jsonRes['boxType'],String,stack:"Boxes-boxType"),
    simNo : convertValueByType(jsonRes['simNo'],Null,stack:"Boxes-simNo"),
    iccid : convertValueByType(jsonRes['iccid'],String,stack:"Boxes-iccid"),
    imei : convertValueByType(jsonRes['imei'],String,stack:"Boxes-imei"),
    mac : convertValueByType(jsonRes['mac'],String,stack:"Boxes-mac"),
    gsmVer : convertValueByType(jsonRes['gsmVer'],Null,stack:"Boxes-gsmVer"),
    boxVer : convertValueByType(jsonRes['boxVer'],String,stack:"Boxes-boxVer"),
    userId : convertValueByType(jsonRes['userId'],String,stack:"Boxes-userId"),
    imei4 : convertValueByType(jsonRes['imei4'],String,stack:"Boxes-imei4"),
    mcuVer : convertValueByType(jsonRes['mcuVer'],Null,stack:"Boxes-mcuVer"),
    bondStatus : convertValueByType(jsonRes['bondStatus'],String,stack:"Boxes-bondStatus"),
    batteryRemain : convertValueByType(jsonRes['batteryRemain'],int,stack:"Boxes-batteryRemain"),
    inShock : convertValueByType(jsonRes['inShock'],bool,stack:"Boxes-inShock"),
    volume : convertValueByType(jsonRes['volume'],int,stack:"Boxes-volume"),
    systemVer : convertValueByType(jsonRes['systemVer'],Null,stack:"Boxes-systemVer"),);

  Map<String, dynamic> toJson() => {
    'id': id,
    'boxType': boxType,
    'simNo': simNo,
    'iccid': iccid,
    'imei': imei,
    'mac': mac,
    'gsmVer': gsmVer,
    'boxVer': boxVer,
    'userId': userId,
    'imei4': imei4,
    'mcuVer': mcuVer,
    'bondStatus': bondStatus,
    'batteryRemain': batteryRemain,
    'inShock': inShock,
    'volume': volume,
    'systemVer': systemVer,
  };
  @override
  String  toString() {
    return json.encode(this);
  }
}