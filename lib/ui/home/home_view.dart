import 'package:patient/ui/health/health_page_view.dart';
import 'package:patient/ui/home/home_page_view.dart';
import 'package:patient/ui/medic/medic_page_view.dart';
import 'package:patient/ui/user/user_page_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient/config/app.dart';
import 'package:patient/config/APPConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/**
 * TabBar + TabBarView
    相当于 Android 原生TabLayout + ViewPage
    有自带 Material Design 动画
    代码实现简单
    支持左右滑动
    BottomNavigationBar + BottomNavigationBarItem
    相当于Android 原生控件 BottomNavigationBar
    有自带 Material Design 动画
    代码实现简单
    不支持左右滑动
    BottomAppBar
    完全可以自定义
    代码量复杂
    没有自带动画
    CupertinoTabBar
    IOS 风格
 */

///
class HomeViewUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeViewUIState();
  }
}

class _HomeViewUIState extends State<HomeViewUI>
    with SingleTickerProviderStateMixin {
  int _selectIndex = 0;
  var _pageController = new PageController(initialPage: 0);
  var pages = <Widget>[
    new HomePageViewUI(),
    new MedicPlanViewUI(),
    new HealthViewUI(),
    new UserPageView()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  BottomNavigationBarItem _tabbarItem(int index) {
    List<String> tabbarIcons = [
      'tab_home',
      'tab_medicine',
      'tab_health',
      'tab_user'
    ];
    List<String> tabbarTexts = ['首页', '服药', '达标', '我的'];
    AssetImage imgIcon = AssetImage(APPConstant.ASSETS_IMG +
        tabbarIcons[index] +
        (_selectIndex == index ? '_selected' : '_normal') +
        '.png');
    return BottomNavigationBarItem(
        icon: Image(
          image: imgIcon,
          width: 20,
          height: 20,
        ),
        title: Text(
          tabbarTexts[index],
          style: TextStyle(
            color: _selectIndex == index ? Color(0xFF3195FA) : Color(0xFF181818),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
     ScreenUtil.init(
      context,
      width: App.DESIGN_WIDTH,
      height: App.DESIGN_HEIGHT,
      allowFontScaling: App.ALLOW_FONT_SCALING_SELF,
    );
    return Scaffold(
        // appBar: AppBar(title: Text('心之力患者端'), actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.share),
        //     onPressed: () {
        //       /**
        //           打开抽屉菜单
        //           代码中打开抽屉菜单的方法在ScaffoldState中，
        //           通过Scaffold.of(context)可以获取父级最近的Scaffold 组件的State对象。
        //        */
        //       Scaffold.of(context).openDrawer();
        //     },
        //   )
        // ]),
        // drawer: new MyDrawer(), //抽屉
        body: SafeArea(
          child: PageView(
            onPageChanged: _pageChange,
            controller: _pageController,
            children: pages,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
              _tabbarItem(0),
              _tabbarItem(1),
              _tabbarItem(2),
              _tabbarItem(3),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectIndex,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
      )
    );
  }

  void _pageChange(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  void _onItemTapped(int index) {
    //bottomNavigationBar 和pageview 关联
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        //移除抽屉菜单顶部默认留白
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/user_default_portrait_70.png",
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                  Text(
                    "个人信息",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: Image.asset(
                      "assets/images/ic_mine_friend.png",
                      width: 20,
                      height: 20,
                    ),
                    title: const Text("我的亲友"),
                  ),
                  ListTile(
                    leading: Image.asset(
                      "assets/images/ic_mine_doctor.png",
                      width: 20,
                      height: 20,
                    ),
                    title: const Text("我的医生"),
                  ),
                  ListTile(
                    leading: Image.asset(
                      "assets/images/ic_mine_order.png",
                      width: 20,
                      height: 20,
                    ),
                    title: const Text("我的订单"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
