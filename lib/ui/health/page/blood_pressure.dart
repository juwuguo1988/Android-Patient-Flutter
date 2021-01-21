import 'package:fl_chart/fl_chart.dart';
import 'package:patient/ui/page_index.dart';
import 'package:patient/components/divider_line.dart';
import "package:flui/flui.dart";
import 'package:dio/dio.dart';
import 'package:patient/http/entity/graph_bp_model.dart';
import 'package:patient/http/entity/bp_latest_model.dart';
import 'package:patient/ui/health/components/medicine_line_chart.dart';
import 'package:patient/ui/health/components/record_title.dart';
import 'package:patient/ui/health/components/action_btn.dart';
import 'package:patient/ui/health/components/left_border_title.dart';

class BloodPressure extends StatelessWidget {
  BloodPressure();

  var statusTextStyle =
      (color) => TextStyle(fontSize: 13.sp, height: 1, color: color);
  var unitTextStyle =
      TextStyle(fontSize: 13.sp, height: 1, color: AppColors.helpText);
  var unitValueStyle = (color) => TextStyle(
      fontSize: 24.sp, height: 1, fontWeight: FontWeight.bold, color: color);
  var standardValueStyle =
      TextStyle(fontSize: 14.sp, height: 1, color: AppColors.helpText);

  var chartTitleStyle = TextStyle(
    fontSize: 12.sp,
    color: AppColors.helpText,
    height: 1,
  );
  Map<String, String> titleList = {"LOW": "偏低", "HIGH": "偏高", "NORMAL": "正常"};
  Future _getBPInfo(BuildContext context) async {
    try {
      if (!Provider.of<HealthProvider>(context).graphBpLoaded) {
        await Provider.of<HealthProvider>(context, listen: false)
            .getGraphBPInfo({
          "category": "TIMES", "times": 7, // pageAt: ? // pageSize: ?
        });
      }
      return "success";
    } on DioError catch (e) {
      print(e);
      return "fail";
    }
  }

  Widget _lastRecord(BpLatest bpLatest) {
//    print("_lastRecord $bpLatest");
    return Container(
      width: 345.w,
      // height: 109.h,
      // margin: EdgeInsets.fromLTRB(15.w, 0, 15.w, 0),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.w)),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(10, 0, 0, 0),
                offset: Offset(0, 0),
                blurRadius: 7,
                spreadRadius: 2)
          ],
          border: Border.all(width: 0.5.w, color: Colors.black12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RecordTitle(
              title: "最后一次记录",
              subTitle: DateUtil.formatDateMs(bpLatest?.measuredAt,
                  format: DataFormats.zh_mo_d)),
          DividerLine(height: 5, color: Colors.white),
          Row(
            children: <Widget>[
              _recordLeft(bpLatest),
              _recordMiddle(),
              _recordRight(bpLatest)
            ],
          )
        ],
      ),
    );
  }

  Widget _recordLeft(BpLatest recentBpLatest) {
    String status = recentBpLatest?.bpStatus;
    Color curColor = AppColors.medicineStatusList[status];
    String realValue = "${recentBpLatest.high}/${recentBpLatest.low}";
    String referenceValue =
        "${recentBpLatest.referenceBpMax}/${recentBpLatest.referenceBpMin}";

    return Container(
      // height: 66.h,
      width: 189.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("• 血压${titleList[status]} •", style: statusTextStyle(curColor)),
          Container(
              margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
              width: 145.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(realValue, style: unitValueStyle(curColor)),
                  Text("mmHg", style: unitTextStyle),
                ],
              )),
          Text("达标值： $referenceValue", style: standardValueStyle)
        ],
      ),
    );
  }

  Widget _recordMiddle() {
    return Container(width: 1.w, height: 27.h, color: Color(0xffe5e5e5));
  }

  Widget _recordRight(BpLatest recentBpLatest) {
    String status = recentBpLatest.heartRateStatus;
    Color curColor = AppColors.medicineStatusList[status];
    String realValue = "${recentBpLatest.heartRate}";
    String referenceValue =
        "${recentBpLatest.referenceHeartRateMax}/${recentBpLatest.referenceHeartRateMin}";
    return Container(
      // height: 66.h,
      // width: 135.w,
      margin: EdgeInsets.only(left: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("• 心率${titleList[status]} •", style: statusTextStyle(curColor)),
          Container(
              width: 84.w,
              margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(realValue, style: unitValueStyle(curColor)),
                  Text("次/分", style: unitTextStyle),
                ],
              )),
          Text("达标值： $referenceValue", style: standardValueStyle)
        ],
      ),
    );
  }

  Widget lineChartCommon(String title, Widget chart) {
    return Container(
      decoration: BoxDecoration(
          // border: Border.all(color: Colors.red),
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          LeftBorderTitle(title),
          DividerLine(
            height: 10,
            color: Colors.white,
          ),
          Container(
              // margin: EdgeInsets.only(top: 7.h),
              padding: EdgeInsets.only(left: 5.w, right: 15.w, top: 7.h),
              decoration: BoxDecoration(
                  // border: Border.all(color: Colors.red),
                  ),
              width: 345.w,
              height: 120.h,
              child: chart)
        ],
      ),
    );
  }

  Widget _pressureChart(GraphBp graphBp, BpLatest bpLatest) {
    var statusArray = graphBp.status.reversed.toList();
    var highArray = graphBp.high.reversed.toList();
    var lowArray = graphBp.low.reversed.toList();
//    var timeArray = graphBp.time.map((yearTime) {return yearTime.time;}).toList();
    var timeArray = graphBp.time.reversed.map((yearTime) {
      return (DateUtil.formatDateMs(yearTime.time, format: DataFormats.mo_d));
    }).toList();
    var length = timeArray.length;
    List<FlSpot> spotsLow = [];
    List<FlSpot> spotsHigh = [];
    for (var i = length - 1; i >= 0; i--) {
      spotsHigh.add(FlSpot((i + 1).toDouble(), highArray[i].toDouble()));
      spotsLow.add(FlSpot((i + 1).toDouble(), lowArray[i].toDouble()));
    }

    Widget pressureChild = MedicineLineChart(
      spotsArray: [spotsLow, spotsHigh],
      xAxis: timeArray,
      status: statusArray,
      extraLines: [bpLatest.referenceBpMin, bpLatest.referenceBpMax],
    );

    return lineChartCommon("血压", pressureChild);
  }

  Widget _heartRateChart(GraphHeartRate graphHeartRate, BpLatest bpLatest) {
    List<String> statusArray = graphHeartRate.status.reversed.toList();
    var rateArray = graphHeartRate.heartRate.reversed.toList();
    var timeArray = graphHeartRate.time.reversed.map((yearTime) {
      return (DateUtil.formatDateMs(yearTime.time, format: DataFormats.mo_d));
    }).toList();

    var length = timeArray.length;
    List<FlSpot> spots = [];
    for (var i = length - 1; i >= 0; i--) {
      spots.add(FlSpot((i + 1).toDouble(), rateArray[i].toDouble()));
    }
    Widget rateChild = MedicineLineChart(
      spotsArray: [spots],
      xAxis: timeArray,
      status: statusArray,
      extraLines: [
        bpLatest.referenceHeartRateMin,
        bpLatest.referenceHeartRateMax
      ],
    );
    return lineChartCommon("心率", rateChild);
  }

  Widget build(BuildContext context) {
    var divider = DividerLine(
      height: 10,
      color: Colors.white,
    );
    return FutureBuilder(
      future: _getBPInfo(context),
      key: Key("血压FutureBuilder"),
      builder: (context, snapShot) {
        print("snapShot $snapShot , ${snapShot.hasData}, ${snapShot.data}");
        if (snapShot.hasData) {
          return Consumer<HealthProvider>(
              builder: (context, healthProvider, _) {
            print("blood_pressure change");
            BpLatest bpLatest = healthProvider.bpLatest;
            GraphBp graphBp = healthProvider.graphBp;
            print("blood_pressure graphBp $graphBp");
            GraphHeartRate graphHeartRate = healthProvider.graphHeartRate;
            return Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 15.w, right: 15.w),
                  color: Colors.white,
                  child: ListView(children: <Widget>[
                    _lastRecord(bpLatest),
                    divider,
                    RecordTitle(title: "最近七次记录", subTitle: "坚持记录哦"),
                    divider,
                    _pressureChart(graphBp, bpLatest),
                    DividerLine(
                      height: 5,
                      color: Colors.white,
                    ),
                    _heartRateChart(graphHeartRate, bpLatest),
                  ]),
                ),
                Positioned(
                  left: 15.w,
                  bottom: 10.h,
                  width: 345.w,
                  child: ActionBtn(
                      cb: () {
                        Application.router
                            .navigateTo(context, "/self_upload_bp");
                      },
                      text: "手动上传"),
                ),
              ],
            );
          });
        } else {
//          return Text("记载中");
          return FLEmptyContainer(
            showLoading: true,
            title: '加载中...',
          );
        }
      },
    );
  }
}
