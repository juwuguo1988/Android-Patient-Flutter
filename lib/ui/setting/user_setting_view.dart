import 'package:patient/config/APPConstant.dart';
import 'package:flutter/material.dart';

class UserSettingView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserSettingViewUI();
  }
}

class UserSettingViewUI extends State<UserSettingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设备管理"),
      ),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: FractionalOffset(0.0, 0.0),
            child: Image.asset(
              APPConstant.ASSETS_IMG + "ic_book_hostial.png",
              width: 60,
              height: 60,
            ),
          ),
          Align(
            alignment: FractionalOffset.topRight,
            child: Image.asset(
              APPConstant.ASSETS_IMG + "ic_book_hostial.png",
              width: 60,
              height: 60,
            ),
          ),
          Align(
            alignment: FractionalOffset.center,
            child: Image.asset(
              APPConstant.ASSETS_IMG + "ic_book_hostial.png",
              width: 60,
              height: 60,
            ),
          ),
          Align(
            alignment: FractionalOffset.bottomLeft,
            child: Image.asset(
              APPConstant.ASSETS_IMG + "ic_book_hostial.png",
              width: 60,
              height: 60,
            ),
          ),
          Align(
            alignment: FractionalOffset.bottomRight,
            child: Image.asset(
              APPConstant.ASSETS_IMG + "ic_book_hostial.png",
              width: 60,
              height: 60,
            ),
          )
        ],
      ),
    );
  }
}
