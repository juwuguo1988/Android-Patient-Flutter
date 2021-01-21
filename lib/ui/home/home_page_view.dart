import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient/components/ui/status_bar_widget.dart';
import 'package:patient/config/APPConstant.dart';
import 'package:patient/components/divider_line.dart';
import 'package:patient/ui/home/home_chat_page.dart';
import 'package:patient/ui/home/message/health_message.dart';

class HomePageViewUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageView();
  }
}

class _HomePageView extends State<HomePageViewUI>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  var mTabs = ["医患对话", "健康资讯"];

  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    this._tabController = new TabController(vsync: this, length: mTabs.length);
  }

  @override
  Widget build(BuildContext context) {
    var url =
        "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1880423609,3790861390&fm=26&gp=0.jpg";
    return StatusBarWidget(
        child: Container(
          color: Colors.white,
          width: 375.w,
          height: 360.h,
          child: Column(
            children: <Widget>[
              Container(
                  color: Colors.white,
                  width: 375.w,
                  padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      child: Stack(
                        children: <Widget>[
                          Container(
                              child: Image.network(
                            url,
                            height: 110.h,
                            width: 355.w,
                            fit: BoxFit.fitWidth,
                          )),
                          Positioned(
                            right: 0,
                            child: Container(
                                height: 40.h,
                                width: 40.w,
                                alignment: Alignment.center,
                                //边框设置
                                decoration: new BoxDecoration(
                                  //背景
                                  color: Colors.white,
                                  //设置四周圆角 角度
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5.w),
                                      bottomLeft: Radius.circular(5.w)),
                                  //设置四周边框
                                  border: new Border.all(
                                      width: 1, color: Colors.white),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Image(
                                    image: AssetImage(APPConstant.ASSETS_IMG +
                                        'ic_home_remind.png'),
                                    width: 24,
                                    height: 24,
                                  ),
                                )),
                          )
                        ],
                      ))),
              Container(
                color: Colors.white,
                width: 375.w,
                height: 462.h,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: TabBar(
                          controller: this._tabController,
                          labelColor: Colors.blue,
                          unselectedLabelColor: Colors.black,
                          isScrollable: true,
                          // labelPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          labelStyle: TextStyle(fontSize: 17),
                          tabs: mTabs.map((tab) {
                            return Tab(
                              text: tab,
                            );
                          }).toList()),
                    ),
                    DividerLine(
                      height: 10,
                    ),
                    Expanded(flex: 1, child: _tabBarView())
                  ],
                ),
              ),
            ],
          ),
        ),
        color: Colors.white);
  }

  Widget _tabBarView() {
    return TabBarView(
        controller: _tabController,
        // ignore: missing_return
        children: mTabs.map((tab) {
          switch (tab) {
            case "医患对话":
              return HomeChatPageView();
            case "健康资讯":
              return HealthMessageUI();
          }
        }).toList());
  }
}
