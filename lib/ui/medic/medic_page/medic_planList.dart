
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient/config/APPConstant.dart';
import 'package:patient/http/entity/medic/medic_plan_model.dart';
import 'package:patient/components/business/medic_business.dart';
import 'package:patient/utils/sheet_util.dart';
import 'package:patient/ui/page_index.dart';

import 'dart:convert';



class MedicPlanList extends StatelessWidget {

  List<List<List<Plans>>> plans;
  MedicPlanList(this.plans);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child:  Expanded(

          child: ListView.builder(
            itemCount: plans.length,
            itemBuilder: (context, index){
              return _planItem(context,plans[index]);
            },
          ),
      ),
    );
  }

  Widget _planItem(BuildContext context,List<List<Plans>> plan){

    return InkWell(
      onTap: (){

        bool isPillBoxPlan = MedicBusiness().isPillBoxPlan(plan.first.first);
        List<String> listStr;
        List<Color> colorList = List<Color>();
        if(isPillBoxPlan) {
          listStr = ['修改服药计划','向药仓填药','药品说明书'];
          colorList.add(Color(0xFF2C2F32));
          colorList.add(Color(0xFF2C2F32));
        } else {
          listStr = ['修改服药计划','药品说明书'];
          colorList.add(Color(0xFF2C2F32));
        }

        if(plan.first.first.isUnknown=='UNKNOWN'){

          colorList.add(Color(0xFFDDE0E4));
        } else {

          colorList.add(Color(0xFF2C2F32));
        }

        SheetUtil(
          itemHeight: 40.w,
          colorList: colorList,
          itemChanged: (index){

              String planStr = json.encode(plan);
              planStr = Uri.encodeComponent(planStr);



//            if(index ==  1) {
              Application.router.navigateTo(context, "medic_add_plan?plan=${planStr}"); //
//            }
          },
          listStr: listStr,
        ).showmodalBottomSheet(context);
      },
      child: Container(

        width: 355.w,
        margin: EdgeInsets.only(left: 10.w,top: 10.w,right: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.w),
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[

            _planInfo(plan.first.first),
            _planUnitTime(plan),
          ],
        ),
      ),
    );


  }




  Widget _planInfo(Plans plan) {

    return Container(

      height: 30.w,
      child: Row(
        children: <Widget>[
          _planPos(plan),
          _planName(plan),
          _planDesc(plan),
        ],
      ),
    );
  }

  Widget _planPos(Plans plan){

    var posNo = (plan.positionNo==null||plan.positionNo==0)?"仓外":'${plan.positionNo}号仓';
    return Container(

      width: 38.w,
      height: 18.w,
      margin: EdgeInsets.only(top: 6.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(18.w), bottomRight: Radius.circular(18.w)),
        color: Color(0xFFF0F0F0),
      ),
      child: Text(
        posNo,
        style: TextStyle(
          fontSize:12.sp,
          color: Color(0xFF08365A),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _planName(Plans plan){

    return Container(

      width: 139.w,
      margin: EdgeInsets.only(left: 10.w),
      child: InkWell(
          onTap: (){

          },
          child: Row(
            children: _planNameWidgets(plan),
          ),
        ),
    );
  }

  Widget _planNa(Plans plan) {

    double width = 139.w;
    if(plan.isUnknown=="UNKNOWN"){
      width -= 20.w;
    } else if(plan.clinicalProjectId==''){
      width -= 30.w;
    }

    String medicineName = plan.medicineName;
    RegExp exp = RegExp(
        r'^(未知药品)[0-9]$$');
    bool matched = exp.hasMatch(plan.medicineName);
    if(matched) {
      medicineName = "未知药品";
    }

    return Container(

       constraints: BoxConstraints(

          maxWidth: width
       ),
      child: Text(
          '${medicineName}',
          style: TextStyle(
            fontSize:15.sp,
            color: Color(0xFF3A3A3A),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
    );
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

  Widget _planClinical(Plans plan) {

    return Container(

      width: 30.w,
      color: Color(0xFFEFF5FC),
      child: Text(
        '试验',
        style: TextStyle(
          fontSize:12.sp,
          color: Color(0xFF5DA3E8),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  List<Widget> _planNameWidgets(Plans plan) {

    List<Widget> widgetList = [];
    widgetList.add(_planNa(plan));
    if(plan.isUnknown=="UNKNOWN"){
      widgetList.add(_planUnknow(plan));
    } else if(plan.clinicalProjectId==''){
      widgetList.add(_planClinical(plan));
    }
    return widgetList;
  }

  Widget _planDesc(Plans plan){

    String footerContent = plan.commodityName!= null?plan.commodityName:plan.medicineName;

    String title = plan.ingredient!=null?"${footerContent}|${plan.ingredient}":"${footerContent}";
    if(plan.isUnknown=="UNKNOWN") {
      title = '';
    }

    return Container(

      width: 168.w,
      child:Text(
        title,
        style: TextStyle(
          fontSize:12.sp,
          color: Color(0xFF999999),
        ),
      ),
    );
  }


  Widget _planUnitTime(List<List<Plans>> plan){

    return Container(
      child: Column(

         children: plan.map((item){
           return Row(
              children: <Widget>[
                _planUnit(item),
                _planTime(item),
              ],
           );
         }).toList(),
      ),
    );
  }

  Widget _planUnit(List<Plans> plan){

    String planDosage = MedicBusiness().getPlanDosage(plan.first);
    return Container(

      width: 139.w,
      height: 30.w,
      margin: EdgeInsets.only(left: 48.w),
      child:Text(
        '${planDosage}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize:15.sp,
          color: Color(0xFF3A3A3A),
        ),

      ),
    );
  }

  Widget _planTime(List<Plans> plan){

    String timeStr = MedicBusiness().getTimeString(plan);
    return Container(

      width: 168.w,
      height: 30.w,
      child:Text(
        timeStr,
        style: TextStyle(
          fontSize:15.sp,
          color: Color(0xFF3A3A3A),
        ),
      ),
    );
  }
}