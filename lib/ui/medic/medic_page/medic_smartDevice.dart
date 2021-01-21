import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient/config/APPConstant.dart';
import 'package:patient/http/entity/medic/medic_plan_model.dart';
import 'package:provider/provider.dart';
import 'package:patient/provider/medic/PlanProvider.dart';


class MedicSmartDevice extends StatelessWidget {


  Map<String, List<List<Plans>>> pillBoxMedicPlans;
  MedicSmartDevice(this.pillBoxMedicPlans);

  @override
  Widget build(BuildContext context) {

    return Consumer<MedicPlanProvider>(
        builder: (BuildContext context, MedicPlanProvider detailInfo, Widget child) {

          return  Container(

            margin: EdgeInsets.only(top: 10.w,left: 10.w,right: 10.w),
//      height: 200.w,
            width: 355.w,
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
              children: getChildWidget(context, detailInfo.isOpen),
            ),
          );
    });
  }

  List<Widget> getChildWidget(BuildContext context,bool isOpen){

    List<Widget> childWidget = [_smartDeviceTop(context)];

    if(isOpen) {
      childWidget.add(_smartVoiceShakeBtn(context));
      childWidget.add(_samrtMedicBox());
    } else {

    }
    return  childWidget;
  }

  Widget _samrtMedicBox(){

    return Container(
      width: 335.w,
      height: 116.w,
      margin: EdgeInsets.only(top: 10.w),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(15.w),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              _medicItem("1"),
              _YAxis(),
              _medicItem("2"),
              _YAxis(),
              _medicItem("3"),
            ],
          ),
          _XAxis(),
          Row(
            children: <Widget>[
              _medicItem("4"),
              _YAxis(),
              _medicItem("5"),
              _YAxis(),
              _medicItem("6"),
            ],
          )
        ],
      ),
    );
  }

  Widget _XAxis(){

    return Container(
      width: 335.w,
      height: 1.w,
      color: Color(0xFFE0E0E0),
    );
  }

  Widget _YAxis(){

    return Container(
      width: 1.w,
      height: 56.w,
      color: Color(0xFFE0E0E0),
    );
  }


  Widget _medicItem(String postionNo){

    List<List<Plans>> plan = pillBoxMedicPlans[postionNo];

    bool hasPlans = false;
    String medicineName = "无";
    if(plan != null && plan.length > 0) {

      hasPlans = true;
      RegExp exp = RegExp(
          r'^(未知药品)[0-9]$$');
      bool matched = exp.hasMatch(plan.first.first.medicineName);
      if(matched) {
        medicineName = "未知药品";
      } else {
        medicineName = plan.first.first.medicineName;
      }
    }

    return Container(
      height: 56.w,
      width: 110.w,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 15.w),
            width: 70.w,
            child: Text(
              medicineName,
              style: TextStyle(
                fontSize: 13.sp,
                color: hasPlans?Color(0xFF3195FA):Color(0xFFC5C5C5),

              ),
            ),
          ),
          Container(
            width: 25.w,
            margin: EdgeInsets.only(top: 30.w),
            child: Text(
              postionNo,
              style: TextStyle(
                fontSize: 22.sp,
                color: hasPlans?Color(0xFF3195FA):Color(0xFFC5C5C5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _smartVoiceShakeBtn(BuildContext context){

    return Container(

      height: 30.w,
      width: 335.w,
        child: Row(
            children: <Widget>[
              _shakeBtn(context),
              _voiceSlider(context),
            ]
        ),
    );
  }

  Widget _shakeBtn(BuildContext context) {

    return Consumer<MedicPlanProvider>(
        builder: (BuildContext context, MedicPlanProvider detailInfo, Widget child) {

          return Container(

              width: 56.w,
              height: 24.w,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: detailInfo.boxInfo.boxes.first.inShock?Color(0xFF3195FA):Color(0xFF999999),),
                borderRadius: BorderRadius.circular(24.w),
              ),
              child: InkWell(
                onTap: (){

                },
                child: Row(
                  children: <Widget>[

                    Container(
                      margin: EdgeInsets.only(left: 2.w),
                      child: Image(
                        image:detailInfo.boxInfo.boxes.first.inShock?AssetImage(APPConstant.Medic_IMG + 'medic_shake_open.png'):AssetImage(APPConstant.Medic_IMG + 'medic_shake_close.png'),
                        width: 14.w,
                        height: 14.w,
                      ),//  APPConstant.Medic_IMG + 'medic_shake_close.png' ,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 2.w),
                      width: 35.w,
                      child: Text(
                        detailInfo.boxInfo.boxes.first.inShock?"震动开":"震动关",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: detailInfo.boxInfo.boxes.first.inShock?Color(0xFF3195FA):Color(0xFF999999),
                        ),
                      ),
                    )
                  ],
                ),
              )
          );
        });
  }

  Widget _voiceSlider(BuildContext context) {

    return Consumer<MedicPlanProvider>(
        builder: (BuildContext context, MedicPlanProvider detailInfo, Widget child) {

          return Container(
            width: 250.w,
            margin: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Color(0xFF3195FA),//实际进度的颜色
                thumbColor: Color(0xFF3195FA),//滑块中心的颜色
                inactiveTrackColor:Color(0xFF999999),//默认进度条的颜色
                valueIndicatorColor: Colors.blue,//提示进度的气派的背景色
                valueIndicatorTextStyle: new TextStyle(//提示气泡里面文字的样式
                  color: Colors.white,
                ),
                overlayShape: RoundSliderThumbShape(
                  enabledThumbRadius: 5,
                  disabledThumbRadius: 5,
                ),
                inactiveTickMarkColor:Colors.blue,//divisions对进度线分割后 断续线中间间隔的颜色
              ),
              child: new Container(
                width: 250.w,
                child: new Row(
                  children: <Widget>[
                    Container(
                      width:26.w,
                      child: Text(
                        '音量',
                        style: TextStyle(
                          color: Color(0xFF3195FA),
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    Container(
                      width: 198.w,
                      margin: EdgeInsets.only(left: 6.w),
                      child: new Slider(
                        value: detailInfo.boxInfo.boxes.first.volume.toDouble(),
                        divisions: 100,
                        onChanged: (double){

                        },
                        min: 0,
                        max: 100,
                      ),
                    ),
                    Container(
                      width: 20.w,
                      height: 20.w,
                      child: Image(
                        image: detailInfo.boxInfo.boxes.first.volume > 0?AssetImage(APPConstant.Medic_IMG + 'medic_voice_open.png'):AssetImage(APPConstant.Medic_IMG + 'medic_voice_close.png'),
                        width: 20.w,
                        height: 20.w,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
          });
  }

  Widget _smartDeviceTop(BuildContext context){

    return Consumer<MedicPlanProvider>(
        builder: (BuildContext context, MedicPlanProvider detailInfo, Widget child) {

          return Container(

            height: 30.w,
            width: 335.w,
            margin: EdgeInsets.only(top: 5.w),
            child: Row(
              children: <Widget>[

                Container(
                  width: 305.w,
                  height: 20.w,
                  child: Text(
                    '${detailInfo.boxInfo.boxes.first.imei4} 剩余电量 :${detailInfo.boxInfo.boxes.first.batteryRemain}%',
                    style: TextStyle(
                      color: Color(0xFF3195FA),
                      fontSize:14.sp,
                    ),
                  ),
                ),

                Container(

                  width: 30.w,
                  height: 30.w,
//            color: Colors.red,
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      icon: Image(
                        image: detailInfo.isOpen?AssetImage(APPConstant.ASSETS_IMG + 'medic_close.png'):AssetImage(APPConstant.ASSETS_IMG + 'medic_open.png'),
                        width: 20.w,
                        height: 20.w,
                      ),
                      onPressed: (){
                        Provider.of<MedicPlanProvider>(context,listen: false).changeOpen();
                      }
                  ),
                ),

              ],
            ),
          );
        });
  }
}