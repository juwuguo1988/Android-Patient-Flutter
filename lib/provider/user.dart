import 'package:flutter/material.dart';
import 'package:patient/services/api/user.dart';
// import 'package:patient/model/user_model.dart';

class UserProvider with ChangeNotifier {
  // User user;
  // Institution institution;
  // Department department;
  // String reviewOrgId;
  // List<Relationship> relationship;
  // bool defaultDoctor;
  // List<ClinicalProjects> clinicalProjects;

  String accid = '';
  String token = '';
  String score = '';
  String sessionId = '';

  void setUserInfo(data) {
    // print('setUserInfo');
    // print(data);
    // print(data.user);
    // user = data.user;
    // institution = data.institution;
    // department = data.department;
    // reviewOrgId = data.reviewOrgId;
    // relationship = data.relationship;
    // defaultDoctor = data.defaultDoctor;
    // clinicalProjects = data.clinicalProjects;
    notifyListeners();
  }

  // 获取用户信息
  getUserInfo() async {
    var res = await UserApi().getInitInfo();
    // setUserInfo(res);
  }
}
