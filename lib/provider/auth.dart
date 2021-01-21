import 'package:flutter/material.dart';
import 'package:patient/services/api/auth.dart';
import 'package:patient/services/httpUtil.dart';
import 'package:patient/utils/sp_util.dart';

String access_token = SpUtil.getString('access_token');

class AuthProvider with ChangeNotifier {
  String uid = SpUtil.getString('uid');
  bool hasLogin =
      (access_token.isNotEmpty && SpUtil.getString('uid').isNotEmpty);

  // 从后台获取token
  getToken(params) async {
    var res = await AuthApi().getToken(params);
    // print(res['uid']);
    hasLogin = true;
    uid = res['uid'];
    access_token = res['access_token'];
    SpUtil.putString('access_token', access_token);
    SpUtil.putString('uid', uid);
    HttpUtil().setHeader(access_token);
    notifyListeners();
  }
}
