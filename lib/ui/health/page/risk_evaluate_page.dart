import 'package:patient/ui/page_index.dart';
import 'package:patient/components/divider_line.dart';
import 'package:patient/http/entity/health_entity.dart';
import 'package:patient/common/constant.dart' show AppColors;

class RiskEvaluatePage extends StatefulWidget {
  RiskEvaluatePage();

  _RiskEvaluatePageState createState() => _RiskEvaluatePageState();
}

class _RiskEvaluatePageState extends State<RiskEvaluatePage> {
  static Color leftTitleColor = Color(0xff2c2f32);
  static Color leftMidColor = Color(0xff858e99);
//  static Color withoutReason = leftTitleColor;

  Widget _itemWidget(RiskAssessment item) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_leftArea(item), _middleSplit(), _rightArea(item)],
      ),
    );
  }

  Widget _leftArea(RiskAssessment item) {
//    print(statusList[item.status]);
    return Container(
        width: 133.w,
        padding: EdgeInsets.fromLTRB(15.w, 16.h, 0, 0),
        child: Column(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    border: Border(
                        left:
                            BorderSide(width: 3.w, color: AppColors.linkText))),
                height: 18.h,
                padding: EdgeInsets.only(left: 9.w),
                child: Text(
                  item.name,
                  style: TextStyle(
                      fontSize: 18.sp, height: 1, color: leftTitleColor),
                )),
            Container(
                height: 13.h,
                padding: EdgeInsets.only(left: 12.w),
                margin: EdgeInsets.fromLTRB(0, 20.h, 0, 19.h),
                child: Text(
                  item.valueTitle,
                  style: TextStyle(
                      fontSize: 13.sp, height: 1, color: leftMidColor),
                )),
            Container(
                height: 32.h,
                padding: EdgeInsets.only(left: 12.w),
                child: Text(
                  item.value,
                  style: TextStyle(
                      fontSize: 32.sp,
                      height: 1,
                      color: AppColors.riskStatusList[item.status]),
                )),
          ],
        ));
  }

  Widget _middleSplit() {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 54.h, 0, 0),
        width: 1.w,
        height: 91.h,
        color: Color(0xffe8e8e8));
  }

  Widget _rightArea(RiskAssessment item) {
    return Container(
      padding: EdgeInsets.only(left: 20.w, top: 54.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "风险因素",
            style: TextStyle(fontSize: 13.sp, height: 1, color: leftMidColor),
          ),
          Container(
            width: 200.w,
            margin: EdgeInsets.only(top: 10.h, bottom: 18.h),
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 6.w,
              runAlignment: WrapAlignment.start,
              runSpacing: 5.h,
              children: _rightItems(item),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _rightItems(RiskAssessment item) {
    List<Widget> risks = [];
    var padding = EdgeInsets.fromLTRB(7.w, 6.h, 7.w, 6.h);
    if (item.reason != null) {
      item.reason.forEach((reason) {
        risks.add(Container(
            padding: padding,
            decoration: BoxDecoration(
              border: Border.all(width: 0.75.w, color: AppColors.riskStatusList[item.status]),
              borderRadius: BorderRadius.all(Radius.circular(12.w)),
            ),
            child: Text(reason,
                style: TextStyle(
                    fontSize: 13.sp,
                    height: 1,
                    color: AppColors.riskStatusList[item.status]))));
      });
    }

    if (item.withoutReason.length > 0) {
      item.withoutReason.forEach((reason) {
        risks.add(ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
                padding: padding,
                decoration:
                    BoxDecoration(color: Color.fromARGB(30, 44, 47, 50)),
                child: Text(reason,
                    style: TextStyle(
                        fontSize: 13.sp,
                        height: 1,
                        color: Color.fromARGB(100, 44, 47, 50))))));
      });
    }
    // print(risks);
    return risks;
  }

  Widget _warningWidget() {
    return Container(
        height: 42.h,
        width: 375.w,
        color: Color(0xfff6f6f6),
        child: Center(
          child: Text("以上信息仅供参考",
              style: TextStyle(color: leftMidColor, fontSize: 12.sp)),
        ));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('风险评估'),
      ),
      body: SingleChildScrollView(
        child: Consumer<HealthProvider>(builder: (context, healthProvider, _) {
          print('_:  => $_');
          RiskAssessment guanXinBing =
              Utils.getListObjByKey<RiskAssessment>(healthProvider.riskAssessment, "name", "冠心病");
          RiskAssessment naoZuZhong =
            Utils.getListObjByKey<RiskAssessment>(healthProvider.riskAssessment, "name", '脑卒中');
          RiskAssessment chuXie =
            Utils.getListObjByKey<RiskAssessment>(healthProvider.riskAssessment, "name", '出血');
          RiskAssessment tongFeng =
            Utils.getListObjByKey<RiskAssessment>(healthProvider.riskAssessment, "name", '痛风');
          return Container(
            color: Colors.white,
            width: 375.w,
            child: Column(
              children: <Widget>[
                DividerLine(height: 10),
                _itemWidget(guanXinBing),
                DividerLine(height: 10),
                _itemWidget(naoZuZhong),
                DividerLine(height: 10),
                _itemWidget(chuXie),
                DividerLine(height: 10),
                _itemWidget(tongFeng),
                _warningWidget(),
              ],
            ),
          );
        }),
      ),
    );
  }
}
