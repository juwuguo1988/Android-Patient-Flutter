import 'package:patient/services/httpUtil.dart';
import 'package:dio/dio.dart';
import 'package:patient/http/entity/response_model.dart';
import 'package:patient/http/entity/medic/medic_plan_model.dart';
import 'package:patient/http/entity/medic/medic_pillbox_model.dart';
import 'package:patient/http/entity/medic/medic_record_operation.dart';
import 'dart:convert';

class PlanApi {
  static String plan = 'patient/plan';
  static String box = 'patient/box';
  static String medicRecords = 'patient/record/operation?pageAt=0';

  static HttpUtil _http;
  static PlanApi _instance;
  PlanApi._private() {
    _http = HttpUtil();
  }

  factory PlanApi() {
    if (_instance == null) {
      _instance = PlanApi._private();
    }
    return _instance;
  }

  Future getPlan() async {
    Response response = await _http.get(plan);
    ResponseEntity res =
        ResponseEntity.fromJson(json.decode(response.toString()));
    PlanModel planModel = PlanModel.fromJson(res.data);
    return planModel;
  }

  Future getPillBoxInfo() async {

    Response response = await _http.get(box);
    ResponseEntity res =
    ResponseEntity.fromJson(json.decode(response.toString()));
    PillBoxInfo planModel = PillBoxInfo.fromJson(res.data);
    return planModel;
  }

  Future getMedicRecords() async {

    Response response = await _http.get(medicRecords);
    ResponseEntity res =
    ResponseEntity.fromJson(json.decode(response.toString()));
    MedicRecordOperation planModel = MedicRecordOperation.fromJson(res.data);
    return planModel;
  }

}
