import 'package:patient/config/APPConstant.dart';
import "package:patient/ui/page_index.dart";
import 'package:patient/components/divider_line.dart';
import "package:patient/components/scroll_choose.dart";
import 'package:patient/components/datetime_picker/datetime_picker.dart';
import 'package:patient/utils/utils_index.dart';
import 'package:patient/ui/health/components/action_btn.dart';

class SelfUploadBp extends StatefulWidget {
  SelfUploadBp();
  _SelfUploadBpState createState() => _SelfUploadBpState();
}

class _SelfUploadBpState extends State<SelfUploadBp> with ProviderHelper {
  TextEditingController highController = TextEditingController();
//  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int highBp = 110;
  int lowBp = 80;
  int hr = 60;
  DateTime dateTime = DateTime.now();
  Map params = {};
  @override
  void initState() {
    super.initState();
  }

  Widget _topWidget() {
    return Container(
        alignment: Alignment.center,
        height: 14.h,
        child: Text("请左右滑动调整您的数据",
            style: TextStyle(
                fontSize: 14.sp, height: 1, color: AppColors.helpText)));
  }

  Widget _highBpScrollWidget() {
    return Container(
        child: ScrollChoose(
      text: "收缩压",
      unit: "mmHg",
      initialValue: 110,
      minValue: 20,
      maxValue: 280,
      widgetHeight: 64.h,
      widgetWidth: 330.w,
      scaleTextColor: Color(0xffc1cbd7),
      scaleColor: Color(0xffc1cbd7),
      onSelectedChanged: (e) {
        setState(() {
          highBp = e;
        });
      },
    ));
  }

  Widget _lowBpScrollWidget() {
    return Container(
        child: ScrollChoose(
      text: "舒张压",
      unit: "mmHg",
      initialValue: 80,
      minValue: 20,
      maxValue: 220,
      widgetHeight: 64.h,
      widgetWidth: 330.w,
      scaleTextColor: Color(0xffc1cbd7),
      scaleColor: Color(0xffc1cbd7),
      onSelectedChanged: (e) {
        setState(() {
          lowBp = e;
        });
      },
    ));
  }

  Widget _hrScrollWidget() {
    return Container(
        child: ScrollChoose(
      text: "心率",
      unit: "次/分",
      initialValue: 60,
      minValue: 30,
      maxValue: 240,
      widgetHeight: 64.h,
      widgetWidth: 330.w,
      scaleTextColor: Color(0xffc1cbd7),
      scaleColor: Color(0xffc1cbd7),
      onSelectedChanged: (e) {
        setState(() {
          hr = e;
        });
      },
    ));
  }

  Widget _datetimePicker(DateTime datetime) {
//    print(APPConstant.HEALTH_IMG + "edit_date.png");
    String datetimeStr = DateUtil.formatDateStr(datetime.toString(),
        format: DataFormats.zh_y_mo_d_hm);
    return Container(
      height: 52.h,
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      alignment: Alignment.center,
//
      child: InkWell(
        onTap: () {
          _showPickerDateTime(context);
        },
        child: Row(
          children: <Widget>[
            Container(
              width: 110.w,
              child: Text(
                "请选择测量时间",
                style: TextStyle(
                  fontSize: 15.sp,
                  color: AppColors.helpText,
                ),
              ),
            ),
            Container(
              width: 165.w,
              margin: EdgeInsets.only(left: 35.w, right: 15.w),
              child: Text(
                datetimeStr,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: AppColors.mainText,
                ),
              ),
            ),
            Container(
                child: Image(
              width: 20.w,
              height: 20.w,
              image: AssetImage(APPConstant.HEALTH_IMG + "edit_date.png"),
            ))
          ],
        ),
      ),
    );
  }

  Widget _saveBtn(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.themeColor,
        borderRadius: BorderRadius.all(Radius.circular(5.w)),
      ),
      width: 345.w,
      child: ActionBtn(
        text: '保存',
        cb: uploadBpInfo,
      ),
    );
  }

  Future uploadBpInfo() async {
    print("$highBp, $lowBp, $hr");
    // DateTime dt = Provider.of<DatetimeProvider>(context,
    //     listen: false).datetime;
    DateTime dt = datetimeProviderHelper(context).datetime;
    int measuredAt = dt.millisecondsSinceEpoch;
    print("$measuredAt");
    if (highBp <= lowBp) {
      FLToast.error(text: '舒张压必须小于收缩压');
    } else {
      await healthProviderHelper(context).uploadBp({
        "high": highBp,
        "low": lowBp,
        "heartRate": hr,
        "measuredAt": measuredAt,
      });
//      print("done");
    }
  }

  void _showPickerDateTime(BuildContext context) {
    DatetimePicker dateimePicker = DatetimePicker(context);
    dateimePicker.showPickerDateTime();
  }

  Widget build(BuildContext context) {
    return Scaffold(
//      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('手动上传'),
      ),
      body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              DividerLine(height: 15, color: Colors.white),
              _topWidget(),
              DividerLine(height: 10, color: Colors.white),
              _highBpScrollWidget(),
              DividerLine(height: 14, color: Colors.white),
              _lowBpScrollWidget(),
              DividerLine(height: 14, color: Colors.white),
              _hrScrollWidget(),
              DividerLine(height: 20, color: Colors.white),
              DividerLine(height: 10, color: Color(0xfff9f9f9)),
              Consumer<DatetimeProvider>(
                  builder: (context, datetimeProvider, _) {
                DateTime datetime = datetimeProvider.datetime ?? DateTime.now();
                return _datetimePicker(datetime);
              }),
//              _datetimePicker(),
              DividerLine(height: 50, color: Color(0xfff9f9f9)),
              _saveBtn(context),
            ],
          )),
    );
  }
}
