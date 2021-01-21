import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


typedef ItemChangedCallback = void Function(int index);

class SheetUtil {

  ItemChangedCallback itemChanged;
  List<String> listStr;
  List<Color> colorList;
  double itemHeight;


  SheetUtil({this.itemChanged, this.listStr,this.itemHeight, this.colorList});

  void showmodalBottomSheet(BuildContext context) {

    if(listStr == null || listStr.length == 0) return;
    if(colorList == null) {

       colorList = [];
    }
    if(colorList.length < listStr.length) {

      int index = colorList.length;
      int length = listStr.length;
      for(int i = index; index<length; i++) {
        colorList.add(Color(0xFF2C2F32));
      }
    }

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        child: Column(
          children: <Widget>[
            _titleWidget(),
            Container(
              height: (itemHeight*listStr.length),
              child:ListView(
                children: List.generate(
                  listStr.length,
                      (index) => InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        height: itemHeight+1.w,
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: itemHeight,
                              child:Center(
                                child: Text(
                                  listStr[index],
                                  style: TextStyle(
                                    color: colorList[index],
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: Color(0xFFDDE0E4),
                              height: 1.w,
                            ),
                          ],
                        ),
//                        child: Text(listStr[index]),
                      ),
                      onTap: () {
                        print('tapped item ${index + 1}');
                        Navigator.pop(context);
                        itemChanged(index);
                      }),
                )),
            ),
            Container(
              height: 10.w,
              color: Color(0xFFF6F6F6),
            ),
            _cancelWidget(),
          ],
        ),
        height: (10.w+30.w+40.w+((itemHeight+1.w)*listStr.length)), //
      ),
    );
  }

  Widget _titleWidget(){
    return Container(

      height: 30.w,
      color: Color(0xFFF6F6F6),
      child: Center(
        child: Text(
          '操作',
          style: TextStyle(
            fontSize: 13.sp,
            color: Color(0xFF666666),
          ),
        ),
      ),
    );
  }

  Widget _cancelWidget(){
    return Container(

      height: 40.w,
      color: Colors.white,
      child: Center(
        child: Text(
          '取消',
          style: TextStyle(
            fontSize: 15.sp,
            color: Color(0xFF2C2F32),
          ),
        ),
      ),
    );
  }
}


