import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flui/flui.dart' show FLLoadingButton;
import 'package:patient/common/constant.dart';
import 'package:patient/config/APPConstant.dart';
import 'package:patient/provider/provider_index.dart';
import 'package:patient/routes/Application.dart';
import 'package:patient/utils/regex_util.dart';

/*
 * 描述:登录页
 * 创建者: wuxiaobo
 * 邮箱: wuxiaobo@xinzhili.cn
 * 日期: 2020/3/20 15:36
 */

class LoginPage extends StatefulWidget {
  LoginPage();

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _accountController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  ScrollController _singleChildSVController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _hidePwd = true;
  bool _loading = false;

  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(bottom: 35.h),
      child: Text(
        '欢迎登录',
        style: TextStyle(
          fontSize: 25.sp,
        ),
      ),
    );
  }

  Widget _cancelIcon(fn) {
    return IconButton(
      icon: Icon(Icons.cancel),
      color: Colors.grey,
      onPressed: () {
        fn();
      },
    );
  }

  Widget _eyeIcon() {
    return IconButton(
      icon: _hidePwd
          ? Image.asset(APPConstant.ASSETS_IMG + "cb_hide_password.png")
          : Image.asset(APPConstant.ASSETS_IMG + "cb_show_password.png"),
      onPressed: () {
        setState(() {
          _hidePwd = !_hidePwd;
        });
      },
    );
  }

  Widget _accountWidget() {
    return Container(
        margin: EdgeInsets.only(bottom: 15.h),
        child: TextFormField(
          controller: _accountController,
          maxLines: 1,
          keyboardType: TextInputType.number,
          style: TextStyle(fontSize: 16.sp, color: AppColors.mainText),
          validator: (value) {
            print(value);
            if (!RegexUtil.isMobileSimple(value)) {
              return '请输入11位手机号码';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: "请输入手机号",
            suffixIcon: _cancelIcon(() {
              _accountController.clear();
            }),
          ),
        ));
  }

  Widget _pwdWidget() {
    return Stack(
      children: <Widget>[
        TextFormField(
          controller: _pwdController,
          maxLines: 1,
          obscureText: _hidePwd,
          style: TextStyle(fontSize: 16.sp, color: AppColors.mainText),
          validator: (value) {
            if (value.length < 6) {
              return '密码长度错误';
            }
            return null;
          },
          decoration: InputDecoration(
              hintText: "请输入密码", contentPadding: EdgeInsets.only(right: 90.w)),
        ),
        Positioned(
          bottom: 0.h,
          right: 0,
          child: Container(
            width: 95.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _cancelIcon(() {
                  _pwdController.clear();
                }),
                _eyeIcon(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _forgetWidget() {
    return Container(
      margin: EdgeInsets.only(top: 15.h),
      alignment: Alignment.centerRight,
      child: Text(
        '忘记密码',
        style: TextStyle(fontSize: 12.sp, color: AppColors.linkText),
      ),
    );
  }

  Widget _loginWidget(context) {
    return Container(
      width: 325.w,
      height: 46.h,
      margin: EdgeInsets.only(top: 15.h),
      child: FLLoadingButton(
        child: Text('登录',
            style: TextStyle(
              fontSize: 18.sp,
            )),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        color: AppColors.primaryBtn,
        textColor: Colors.white,
        loading: _loading,
        onPressed: () {
          pressLoginBtn(context);
        },
      ),
    );
  }

  Widget _loginHelpText() {
    return Container(
        margin: EdgeInsets.only(top: 10.h),
        child: Row(
          children: <Widget>[
            Text(
              '登录即代表已阅读并同意',
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.helpText,
              ),
            ),
            InkWell(
                onTap: () {},
                child: Text(
                  '《用户协议及隐私条款》',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.linkText,
                  ),
                ))
          ],
        ));
  }

  void pressLoginBtn(context) async {
    // final authProvider = Provider.of<AuthProvider>(context);
    print(_formKey.currentState.validate());
    if (_formKey.currentState.validate()) {
      setState(() {
        _loading = true;
      });
      String account = _accountController.text;
      String pwd = _pwdController.text;
      print('$account,  $pwd');
      var params = {
        "grant_type": 'password',
        "username": account,
        "password": pwd,
        "device_type":
            Platform.isIOS ? 'ios' : Platform.isAndroid ? 'android' : 'web',
        "device_token": '9b4d6f4fabe53fde0caf685af3fc3ade'
      };
      try {
        await Provider.of<AuthProvider>(context, listen: false)
            .getToken(params);
        await Provider.of<InitInfoProvider>(context, listen: false)
            .getInitInfo();
        Application.router.navigateTo(context, '/home');
      } catch (e) {
        print("e $e");
      } finally {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        title: '心之力医生端',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SingleChildScrollView(
              controller: _singleChildSVController,
              child: Container(
                  padding: EdgeInsets.fromLTRB(20.w, 75.h, 20.w, 0),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      _titleWidget(),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              _accountWidget(),
                              _pwdWidget(),
                            ],
                          )),
                      _forgetWidget(),
                      _loginWidget(context),
                      _loginHelpText()
                    ],
                  ))),
        ));
  }
}
