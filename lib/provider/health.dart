import 'package:flutter/material.dart';
import 'package:patient/http/entity/health_entity.dart';
import 'package:patient/http/entity/graph_bp_model.dart';
import 'package:patient/http/entity/bp_latest_model.dart';
import 'package:patient/model/graph_glu_model.dart';

class HealthProvider with ChangeNotifier {
  var api;
  HealthProvider({@required this.api});

  bool loaded = false;
  List<RiskAssessment> riskAssessment;
  List<MedicineInspection> medicineInspection;
  List<LifeStandard> lifeStandard;

  bool recentBpLoaded = false;
  bool graphBpLoaded = false;

  BpLatest bpLatest;
  GraphBp graphBp;
  GraphHeartRate graphHeartRate;

  // 血糖
  bool graphGluLoaded = false;
  LatestGlu latestGlu;
  List<RecentlyGlu> recentlyGlu;
  String curGlu;

  setHealthInfo(HealthModel res) {
    riskAssessment = res.riskAssessment;
    medicineInspection = res.medicineInspection;
    lifeStandard = res.lifeStandard;
    loaded = true;
    notifyListeners();
  }

//  setRecentBpInfo(RecentBpModel res) {
//    recentBpLoaded = true;
//    notifyListeners();
//  }

  setGraphBpInfo(GraphBpModel res) {
    print("res, $res");
    bpLatest = res.bpLatest;
    graphBp = res.graphBp;
    graphHeartRate = res.graphHeartRate;
    graphBpLoaded = true;
    notifyListeners();
  }

  setGraphGluInfo(GraphGluModel res) {
    latestGlu = res.latestGlu;
    recentlyGlu = res.recentlyGlu;
    graphGluLoaded = true;
    curGlu = latestGlu.type;
    notifyListeners();
  }

  setCurGlu(String type) {
    curGlu = type;
    notifyListeners();
  }


  getHealthInfo() async {
    HealthModel res = await api.getHealthness();
    setHealthInfo(res);
  }

//  getRecentBPInfo(data) async {
//    RecentBpModel res = await HealthApi().getBloodPressure(data);
//    setRecentBpInfo(res);
//  }

  getGraphBPInfo(data) async {
    GraphBpModel res = await api.getBloodPressureByGraph(data);
    setGraphBpInfo(res);
  }

  getGraphGluInfo(data) async {
    GraphGluModel res = await api.getBloodGluByGraph(data);
    setGraphGluInfo(res);
  }

  getLipid(data) async {
    var res = await api.getLipid(data);
//    setGraphGluInfo(res);
  }

  getUa(data) async {
    var res = await api.getUa(data);
//    setGraphGluInfo(res);
  }

  uploadBp(data) async {
    await api.uploadBp(data);
    await getGraphBPInfo({
      "category": "TIMES",
      "times": 7,
    });
  }
}
