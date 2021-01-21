import 'package:dio/dio.dart';
import 'package:patient/http/entity/response_model.dart';
import 'package:patient/model/health_message_new_bean.dart';
import 'dart:convert';
import 'package:patient/services/httpUtil.dart';
import 'package:patient/utils/sp_util.dart';

class HealthMessageApi {
  // token
  static String health_message_url = 'patient/wechat/news';

  static HttpUtil _http;
  static HealthMessageApi _instance;
  static Options authOption = Options(
//    headers: {
//      "Authorization": "Bearer" + access_token,
//    },
    contentType: Headers.jsonContentType,
  );

  HealthMessageApi._private() {
    _http = HttpUtil();
  }

  factory HealthMessageApi() {
    if (_instance == null) {
      _instance = HealthMessageApi._private();
    }
    return _instance;
  }

  Future getHealthMessageInfo() async {
    Response response =
    await _http.get(health_message_url, data: null, options: authOption);
    ResponseEntity res =
    ResponseEntity.fromJson(json.decode(response.toString()));
    HealthNewsBean infoBean = HealthNewsBean.fromJson(res.data);
    return infoBean;
  }
}
