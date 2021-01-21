import 'package:dio/dio.dart';
import 'package:patient/http/entity/response_model.dart';
import 'package:patient/http/entity/recent_bp_model.dart';
import 'package:patient/http/entity/graph_bp_model.dart';
import 'package:patient/http/entity/health_entity.dart';
import 'package:patient/model/graph_glu_model.dart';

import 'dart:convert';
import 'package:patient/services/httpUtil.dart';


class HealthApi {
  // healthiness 健康首页接口
  static String healthiness = 'patient/healthiness';
  // 查询血压接口
  static String bp = 'patient/bp';
  // 查询血压折线图
  static String graphBp = 'patient/graph/bp';
  // 查询血糖折线图
  static String graphGlu = 'patient/graph/glu';
  // 血脂记录
  static String lipid = 'patient/lipid';
  // 尿酸记录
  static String ua = 'patient/ua';
  // 上传血压
  static String upload_bp = "patient/bp";

  static HttpUtil _http;
//  static HealthApi _instance;
  HealthApi() {
    _http = HttpUtil();
  }
//  factory HealthApi() {
//    if (_instance == null) {
//      _instance = HealthApi._private();
//    }
//    return _instance;
//  }

  Future getHealthness() async {
    Response response = await _http.get(healthiness);
    ResponseEntity res =
        ResponseEntity.fromJson(json.decode(response.toString()));
    HealthModel health = HealthModel.fromJson(res.data);
    return health;
  }

  Future getBloodPressure(data) async {
    Response response = await _http.get(bp, data: data);
    ResponseEntity res =
      ResponseEntity.fromJson(json.decode(response.toString()));
    RecentBpModel recentBp = RecentBpModel.fromJson(res.data);
    return recentBp;
  }

  getBloodPressureByGraph(data) async {
    Response response = await _http.get(graphBp, data: data);
    ResponseEntity res =
      ResponseEntity.fromJson(json.decode(response.toString()));
    GraphBpModel graphBpInfo = GraphBpModel.fromJson(res.data);
    return graphBpInfo;
  }

  Future getBloodGluByGraph(data) async {
    Response response = await _http.get(graphGlu, data: data);
    ResponseEntity res =
    ResponseEntity.fromJson(json.decode(response.toString()));
    GraphGluModel graphGluInfo = GraphGluModel.fromJson(res.data);
    return graphGluInfo;
  }

  Future getLipid(data) async {
    Response response = await _http.get(lipid, data: data);
    ResponseListEntity res =
      ResponseListEntity.fromJson(json.decode(response.toString()));
//    GraphGluModel graphGluInfo = GraphGluModel.fromJson(res.data);
    return res;
  }

  Future getUa(data) async {
    Response response = await _http.get(ua, data: data);
    ResponseListEntity res =
      ResponseListEntity.fromJson(json.decode(response.toString()));
//    GraphGluModel graphGluInfo = GraphGluModel.fromJson(res.data);
    return res;
  }

  Future uploadBp(params) async {
    print('uploadBp params');
    await _http.post(upload_bp, data: params);
  }
}
