import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient/http/entity/medic/medic_plan_model.dart';
import 'package:patient/model/medic/time_range_plan_group.dart';
import 'package:patient/components/business/medic_business.dart';
import 'package:patient/utils/date_util.dart';
import 'package:patient/config/APPConstant.dart';

class TimePlanCard extends StatelessWidget {

  TimePlanGroup groupPlans;
  TimePlanCard(this.groupPlans);

  //



  @override
  Widget build(BuildContext context) {

    DateTime planDate = DateUtil.getDateTime(groupPlans.time);

    String day = "";
    if(DateUtil.isToday(planDate.millisecondsSinceEpoch)) {

      day = "今天";
    } else if(DateUtil.isYesterday(planDate, DateTime.now())) {

      day = "昨天";
    }

    String hmStr = DateUtil.formatDate(planDate, format: "HH:mm");

    String title = "";
    Color backColor = Color(0x210061B0);
    Color textColor = Color(0xFF0061B0);
    Color medicColor =Color(0xFF2C2F32);
    if(planDate.compareTo(DateTime.now()) == 1) {

      title = "下次服药";
    } else {

      var availDate = planDate.add(new Duration(minutes: 30));
      if(availDate.compareTo(DateTime.now()) == 1) {

        title = "等待服药";
      } else {

        title = "错过服药";
        backColor = Color(0xFFE7E8EB);
        textColor = Color(0xFF666666);
        medicColor = Color(0xFF858E99);
      }
    }
    // TODO: implement build
    return Container(
      margin: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.white),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
          ),
        ],
        borderRadius: BorderRadius.circular(5.w),
      ),
      child: Column(
        children: <Widget>[

          Container(
            width: 355.w,
            color: backColor,
            padding: EdgeInsets.only(left: 15.w,top: 12.w,bottom: 12.w),
            child: Text(
              '${title}·${day} ${hmStr}',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: textColor,
              ),
            ),
          ),
          Container(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: groupPlans.plans.length,
              itemBuilder: (context, index) {
                return Column(

                  children: <Widget>[
                    _timePlanItem(context, groupPlans.plans[index],medicColor),
                    Divider(
                      color: Color(0xFFE8E8E8),
                      height: 0.5.w,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _timePlanItem(BuildContext context, Plans plan, Color color) {


    String planDosage = MedicBusiness().getPlanDosage(plan);
    return InkWell(
      onTap: () {

      },
      child: Container(
        padding: EdgeInsets.only(left: 15.w,top: 12.w,bottom: 12.w, right: 15.w),
        child: Row(
          children: <Widget>[
            Expanded(
            child: Row(
               children: _planNameWidgets(plan),
            ),
        ),

            Text(
              '${planDosage}',
              style: TextStyle(
                fontSize: 15.sp,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _planNameWidgets(Plans plan) {

    String posNo = (plan.positionNo==null||plan.positionNo==0)?"仓外":'${plan.positionNo}号仓';

    String medicineName = plan.medicineName;
    RegExp exp = RegExp(
        r'^(未知药品)[0-9]$$');
    bool matched = exp.hasMatch(plan.medicineName);
    if(matched) {
      medicineName = "未知药品";
    }

    List<Widget> widgetList = [];

    widgetList.add(Text(
      '${posNo}   ${medicineName}',
      style: TextStyle(
        fontSize: 15.sp,
        color: Color(0xFF2C2F32),
      ),
    ));

    if(plan.isUnknown=="UNKNOWN"){
      widgetList.add(_planUnknow(plan));
    }

    return widgetList;
  }

  Widget _planWidgets(Plans plan) {

    if(plan.isUnknown=="UNKNOWN"){
       return _planUnknow(plan);
    }
    return null;
  }

  Widget _planUnknow(Plans plan) {

    return Container(
      width: 20.w,
      height: 20.w,
      child: Image(
        image: AssetImage(APPConstant.Medic_IMG + 'medic_unknow.png'),
        width: 20.w,
        height: 20.w,
      ),
    );
  }
}



//return Container(
//color: Colors.red,
//width: 375.w,
//height: 138.h,
//padding: EdgeInsets.only(top: 5, bottom: 5),
//decoration: BoxDecoration(
//color: Colors.white,
//border: Border(bottom: BorderSide(width: 1.0, color: Colors.black))),
////垂直方向
//child: Column(
//children: <Widget>[
//
//
//],
//),
//);

//Text('123')



