import 'package:flutter/material.dart';
import 'package:patient/model/init_info_bean.dart';
import 'package:patient/services/api/init_api.dart';

class InitInfoProvider with ChangeNotifier {
  DoctorBean doctor;
  List<RecordOperationsBean> recordOperations;
  List<PlanBean> plans;
  AdviceBean advice;
  Object assistant;
  UserBean user;

  void setInitInfo(data) {
    user = data.user;
    doctor = data.doctor;
    recordOperations = data.recordOperations;
    plans = data.plans;
    assistant = data.assistant;
    advice = data.advice;
    notifyListeners();
  }

  Future getInitInfo() async {
    var res = await InitApi().getInitInfo();
    print("===== ${res.plans.length}");
    setInitInfo(res);
  }
}
