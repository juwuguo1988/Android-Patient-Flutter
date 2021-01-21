import 'package:patient/ui/page_index.dart';
import 'package:patient/ui/health/page/blood_pressure.dart';
import 'package:patient/ui/health/page/blood_sugar.dart';
import 'package:patient/ui/health/page/blood_fat.dart';
import 'package:patient/ui/health/page/uric_acid.dart';

class MedicineStandard extends StatefulWidget {
  MedicineStandard();

  _MedicineStandardState createState() => _MedicineStandardState();
}

class _MedicineStandardState extends State<MedicineStandard>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  var tabs = ["血压", "血糖", "血脂", "尿酸"];
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: tabs.length);
  }

  Widget _tabbarTitle() {
    return Container(
        child: TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: AppColors.themeColor,
            labelStyle: TextStyle(
              fontSize: 16.sp,
            ),
            indicatorWeight: 2,
            unselectedLabelColor: AppColors.mainText,
            tabs: tabs.map((tab) {
              return Tab(
                key: Key(tab),
                text: tab,
              );
            }).toList()));
  }

  Widget _tabbarView() {
    return TabBarView(
        controller: _tabController,
        // ignore: missing_return
        children: tabs.map((tab) {
          switch (tab) {
            case "血压":
              return BloodPressure();
            case "血糖":
              return BloodSugar();
            case "血脂":
              return BloodFat();
            case "尿酸":
              return UricAcid();
          }
        }).toList());
  }

  _handleTapHistory(BuildContext context) {
    List<String> historyOfMedicineStandard = [
      '/blood_pressure_history',
      '/blood_sugar_history',
      '/blood_fat_history',
      '/uric_history'
    ];
    print('_tabController $_tabController, ${_tabController.index}');
    Application.go(
        context, '${historyOfMedicineStandard[_tabController.index]}');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用药达标'),
        actions: <Widget>[
          InkWell(
            onTap: () {
              _handleTapHistory(context);
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 15.w),
              child: Text("历史",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.sp)),
            ),
          ),
        ],
//        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        width: 375.w,
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.fromLTRB(18.w, 0, 18.w, 0),
                margin: EdgeInsets.only(bottom: 10.h),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(width: 1.h, color: Colors.white)),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 0),
                          color: Color.fromARGB(10, 0, 0, 0),
                          blurRadius: 2.0,
                          spreadRadius: 4.0)
                    ]),
                child: _tabbarTitle()),
            Expanded(child: _tabbarView())
          ],
        ),
      ),
    );
  }
}
