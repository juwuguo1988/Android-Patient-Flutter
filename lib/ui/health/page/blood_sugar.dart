import 'package:patient/model/graph_glu_model.dart';
import 'package:patient/ui/page_index.dart';
import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:patient/components/divider_line.dart';
import 'package:patient/components/loading.dart';
import 'package:patient/ui/health/components/record_title.dart';
import 'package:patient/ui/health/components/action_btn.dart';
import 'package:patient/ui/health/components/medicine_line_chart.dart';

class BloodSugar extends StatefulWidget {
  BloodSugar();

  _BloodSugarState createState() => _BloodSugarState();
}

class _BloodSugarState extends State<BloodSugar> {

  Map<String, String> titleList = {"LOW": "偏低", "HIGH": "偏高", "NORMAL": "正常"};
  initState() {
    super.initState();
  }
  _getGluInfo(context) async {
    try {
      if (!Provider.of<HealthProvider>(context).graphGluLoaded) {
        await Provider.of<HealthProvider>(context, listen: false).getGraphGluInfo({
          "category": "TIMES",
          "times": 7,
          "gluType": "GLU_BEFORE_BREAKFAST" // pageAt: ? // pageSize: ?
        });
      }
      return "success";
    } on DioError catch (e) {
      print(e);
      return "fail";
    }
  }

  Widget _lastRecord(LatestGlu latestGlu) {
    return Container(
      width: 345.w,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
          color: Color(0xfffefefe),
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
              subTitle: "${DateUtil.formatDateMs(latestGlu?.measuredAt,
                  format: DataFormats.zh_mo_d)}  •  ${latestGlu.typeName}",
          ),
          DividerLine(height: 15, color: Colors.white),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _recordLeft(latestGlu),
              _recordRight(latestGlu)
            ],
          )
        ],
      ),
    );
  }

  Widget _recordLeft(LatestGlu latestGlu) {
    return Container(
      // height: 66.h,
      margin: EdgeInsets.only(left: 60.w),
      width: 50.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(bottom: 8.h),
              width: 145.w,
              child: Text(
                latestGlu.value.toString(),
                style: TextStyle(
                  fontSize: 24.sp,
                  color: AppColors.medicineStatusList[latestGlu.status],
                  height: 1
                ),
              )
            ),
          Text(latestGlu.unit, style: TextStyle(color: AppColors.helpText, fontSize: 13.sp),)
        ],
      ),
    );
  }

  Widget _recordRight(LatestGlu latestGlu) {
    return Container(
//      width: .w,
      margin: EdgeInsets.only(left: 58.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 84.w,
              margin: EdgeInsets.only(bottom: 8.h),
              child: Text("• 血压${titleList[latestGlu.status]} •",
                style: TextStyle(
                  color: AppColors.medicineStatusList[latestGlu.status],
                  fontSize: 13.sp,
                ),)),
          Text("达标值：${latestGlu.min}-${latestGlu.max}",
            style: TextStyle(color: AppColors.helpText, fontSize: 14.sp),)
        ],
      ),
    );
  }

  Widget _conditionList(BuildContext context, String curGlu, List<RecentlyGlu> recentlyGlu) {
    return Container(
      child: Wrap(
        direction: Axis.horizontal,
        spacing: 10.w,
        runSpacing: 10.h,
        children: recentlyGlu.asMap().keys.map((index) {
          RecentlyGlu glu = recentlyGlu[index];
          var width = index <= 3 ? 153.w : 100.w;
          return InkWell(
            onTap: () {
              _handleClickGlu(context, glu.type);
            },
            child: Container(
              alignment: Alignment.center,
              width: width,
              height: 32.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16.w)),
                color: glu.type == curGlu ? AppColors.themeColor : Color(0xffeeeeee),
              ),
              child: Text(
                glu.typeName,
                style: TextStyle(
                    color: glu.type == curGlu ? Colors.white : AppColors.mainText, fontSize: 18.sp
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  _handleClickGlu(BuildContext context, String curGlu) {
    Provider.of<HealthProvider>(context, listen: false).setCurGlu(curGlu);
  }

  Widget _lineChart(List<RecentlyGlu> recentlyGlu, String curGlu) {
    RecentlyGlu chartData = Utils.getListObjByKey(recentlyGlu, "type", curGlu);
    print(chartData.toString());

    var statusArray = chartData.status;
    var valueArray = chartData.value;
//    var timeArray = graphBp.time.map((yearTime) {return yearTime.time;}).toList();
    var timeArray = chartData.time.map((yearTime) {
      return (
          DateUtil.formatDateMs(yearTime.time, format: DataFormats.mo_d));
    }).toList();
    var length = timeArray.length;
    List<FlSpot> spots = [];
    for (var i = length - 1; i >= 0; i--) {
      spots.add(FlSpot((i + 1).toDouble(), valueArray[i].toDouble()));
    }
    return Container(
      margin: EdgeInsets.only(top: 15.h),
      height: 160.h,
      child: MedicineLineChart(
        spotsArray: [spots],
        xAxis: timeArray,
        status: statusArray,
        extraLines: [chartData.min.toInt(), chartData.max.toInt()],
      ),
    );
  }

  Widget build(BuildContext context) {
    var divider = DividerLine(
      height: 10,
      color: Colors.white,
    );
    return FutureBuilder(
      key:Key("血糖FutureBuilder"),
      future: _getGluInfo(context),
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          return Consumer<HealthProvider>(
              builder: (context, healthProvider, _) {
                LatestGlu latestGlu = healthProvider.latestGlu;
                List<RecentlyGlu> recentlyGlu = healthProvider.recentlyGlu;
                String curGlu = healthProvider.curGlu;
                return Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 15.w, right: 15.w),
                      color: Colors.white,
                      child: ListView(children: <Widget>[
                        _lastRecord(latestGlu),
                        divider,
                        RecordTitle(title: "最近七次记录", subTitle: "坚持记录哦"),
                        divider,
                        _conditionList(context, curGlu, recentlyGlu),
                        divider,
                        _lineChart(recentlyGlu, curGlu),
                      ]),
                    ),
                    Positioned(
                      left: 15.w,
                      bottom: 10.h,
                      width: 345.w,
                      child: ActionBtn(
                          cb: () {
                            Application.router.navigateTo(context, "/self_upload_sugar");
                          },
                          text: "手动上传"
                      ),
                    ),
                  ],
                );
              });
        } else {
//          return Text("记载中");
          return Loading();
        }
      },
    );
  }
}
