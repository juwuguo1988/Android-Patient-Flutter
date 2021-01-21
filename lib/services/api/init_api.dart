import 'package:dio/dio.dart';
import 'package:patient/http/entity/response_model.dart';
import 'package:patient/model/init_info_bean.dart';
import 'dart:convert';
import 'package:patient/services/httpUtil.dart';
import 'package:patient/utils/sp_util.dart';

String access_token = SpUtil.getString('access_token');

class InitApi {
  // token
  static String init_url = 'patient/init';

  static HttpUtil _http;
  static InitApi _instance;
  static Options authOption = Options(
//    headers: {
//      "Authorization": "Bearer" + access_token,
//    },
    contentType: Headers.jsonContentType,
  );

  InitApi._private() {
    _http = HttpUtil();
  }

  factory InitApi() {
    if (_instance == null) {
      _instance = InitApi._private();
    }
    return _instance;
  }

  Future getInitInfo() async {
    Response response =
        await _http.get(init_url, data: null, options: authOption);
    ResponseEntity res =
        ResponseEntity.fromJson(json.decode(response.toString()));
    InitInfoBean infoBean = InitInfoBean.fromJson(res.data);
    return infoBean;
  }
}
