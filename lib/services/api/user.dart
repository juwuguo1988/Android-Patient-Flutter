import 'package:dio/dio.dart';
import 'package:patient/http/entity/response_model.dart';
import 'package:patient/http/entity/user_init_model.dart';
import 'dart:convert';

import 'package:patient/services/httpUtil.dart';

class UserApi {
  // init 接口
  static String init = 'patient/init';
  static HttpUtil _http;
  static UserApi _instance;
  UserApi._private() {
    _http = HttpUtil();
  }
  factory UserApi() {
    if (_instance == null) {
      _instance = UserApi._private();
    }
    return _instance;
  }

  Future getInitInfo() async {
    Response response = await _http.get(init);
    ResponseEntity res =
        ResponseEntity.fromJson(json.decode(response.toString()));
    UserInitModel userInit = UserInitModel.fromJson(res.data);
    // print('getInitInfo $userInit');
    return userInit;
  }
}
