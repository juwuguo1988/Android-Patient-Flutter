import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:patient/services/httpUtil.dart';

class AuthApi {
  // token
  static String token = 'oauth/token';

  static HttpUtil _http;
  static AuthApi _instance;
  static Options authOption = Options(
    headers: {
      "Authorization": "Basic cGF0aWVudF9hcHA6",
    },
    contentType: Headers.formUrlEncodedContentType,
  );
  AuthApi._private() {
    _http = HttpUtil();
  }
  factory AuthApi() {
    if (_instance == null) {
      _instance = AuthApi._private();
    }
    return _instance;
  }

  Future getToken(params) async {
    Response res = await _http.post(token, data: params, options: authOption);
    var data = json.decode(res.toString());
    return data;
  }
}
