import 'package:patient/http/entity/health_entity.dart';
import 'package:patient/ui/page_index.dart';
import 'package:flui/flui.dart' show FLEmptyContainer;
import 'package:patient/components/divider_line.dart';

class HealthViewUI extends StatefulWidget {
  _HealthUIState createState() => _HealthUIState();
}

class _HealthUIState extends State<HealthViewUI>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;

  void initState() {
    super.initState();
  }

  Future _getHealthInfo(context) async {
    bool loaded = Provider.of<HealthProvider>(context).loaded;
    if (!loaded) {
      try {
        await Provider.of<HealthProvider>(context, listen: false)
            .getHealthInfo();
      } catch (e) {
        print(e);
      }
    }
    return 'success';
  }

  Widget _titleWidget(String text, int padTop, int height) {
    return Container(
        width: 38.w,
        height: height.h,
        padding: EdgeInsets.fromLTRB(11.w, padTop.h, 11.w, 0),
        decoration: BoxDecoration(
          color: AppColors.riskTitleText.withOpacity(0.2),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.riskTitleText,
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
          ),
        ));
  }

  Widget _commonWidget({
    @required String subPage,
    @required int height,
    @required List<Widget> children,
  }) {
    return InkWell(
        onTap: () {
          _navToHealthSub(subPage);
        },
        child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              height: height.h,
              width: 345.w,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: children,
              ),
            )));
  }

  Widget _riskWidget(List<RiskAssessment> risks) {
    List<Widget> _children = [
      _titleWidget('风险评估', 30, 138),
      _riskItem(risks),
      _headlthArrow()
    ];
    return _commonWidget(
        subPage: '/risk_evaluate', height: 138, children: _children);
  }

  Widget _riskItem(List<RiskAssessment> risks) {
    return Container(
      height: 138.h,
      width: 280.w,
      padding: EdgeInsets.fromLTRB(18.w, 18.h, 5.w, 18.h),
      child: ListView.builder(
          itemCount: risks.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var currentRisk = risks[index];
            String status = currentRisk.status;
            return Container(
                height: 15.h,
                margin: EdgeInsets.only(top: index == 0 ? 0 : 14.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      currentRisk.name,
                      style: TextStyle(
                          height: 1,
                          fontSize: 15.sp,
                          color: AppColors.riskItemText),
                    ),
                    Text(
                      currentRisk.value,
                      style: TextStyle(
                          height: 1,
                          fontSize: 15.sp,
                          color: status == 'LOW'
                              ? AppColors.lowRisk
                              : status == 'MIDDLE'
                                  ? AppColors.middleRisk
                                  : AppColors.highRisk),
                    ),
                  ],
                ));
          }),
    );
  }

  Widget _medicineWidget(List<MedicineInspection> medInspection) {
    List<Widget> _children = [
      _titleWidget('用药达标', 89, 254),
      _medicineItem(medInspection),
      _headlthArrow()
    ];
    return _commonWidget(
        subPage: '/medicine_standard', height: 254, children: _children);
  }

  Widget _medicineItem(List<MedicineInspection> medInspection) {
    return Column(
      children: <Widget>[
        _itemTitle(),
        Container(
          height: 215.h,
          width: 280.w,
          padding: EdgeInsets.fromLTRB(18.w, 14.h, 0, 0),
          child: ListView.builder(
              itemCount: medInspection.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var currentMedicine = medInspection[index];
                String status = currentMedicine.status;
                return Container(
                    height: 15.h,
                    margin: EdgeInsets.only(top: index == 0 ? 0 : 14.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        _itemNameContainer(Text(
                          currentMedicine.name == '低密度脂蛋白'
                              ? 'LDL-C'
                              : currentMedicine.name,
                          style: TextStyle(
                              height: 1,
                              fontSize: 15.sp,
                              color: AppColors.riskItemText),
                        )),
                        _itemRefContainer(Text(
                          currentMedicine.referenceValue,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            height: 1,
                            fontSize: 15.sp,
                          ),
                        )),
                        _itemValueContainer(Text(
                          currentMedicine.realValue,
                          style: TextStyle(
                              height: 1,
                              fontSize: 15.sp,
                              color: status == 'NORMAL'
                                  ? AppColors.normalMed
                                  : status == 'HIGH'
                                      ? AppColors.highMed
                                      : AppColors.lowMed),
                        ))
                      ],
                    ));
              }),
        ),
      ],
    );
  }

  Widget _lifeWidget(List<LifeStandard> lifeStandard) {
    List<Widget> _children = [
      _titleWidget('生活达标', 15, 144),
      _lifeItem(lifeStandard),
      _headlthArrow()
    ];
    return _commonWidget(
        subPage: '/life_standard', height: 144, children: _children);
  }

  Widget _lifeItem(List<LifeStandard> lifeStandard) {
    return Column(
      children: <Widget>[
        _itemTitle(),
        Container(
          height: 100.h,
          width: 280.w,
          padding: EdgeInsets.fromLTRB(18.w, 14.h, 0, 0),
          child: ListView.builder(
              itemCount: lifeStandard.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var currentLife = lifeStandard[index];
//                String status = currentLife.status;
                return Container(
                    height: 15.h,
                    margin: EdgeInsets.only(top: index == 0 ? 0 : 14.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        _itemNameContainer(
                          Text(
                            currentLife.name,
                            style: TextStyle(
                                height: 1,
                                fontSize: 15.sp,
                                color: AppColors.riskItemText),
                          ),
                        ),
                        _itemRefContainer(
                          Text(
                            '${currentLife.referenceValue}${currentLife.unit}',
                            style: TextStyle(
                              height: 1,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                        _itemValueContainer(
                          Text(
                            currentLife.realValue != null
                                ? '${currentLife.realValue}${currentLife.unit}'
                                : '--',
                            style: TextStyle(
                              height: 1,
                              fontSize: 15.sp,
                            ),
                          ),
                        )
                      ],
                    ));
              }),
        )
      ],
    );
  }

  Widget _itemTitle() {
    TextStyle textStyle = TextStyle(
      fontSize: 15.sp,
      height: 1,
      color: AppColors.riskSubTitleText,
    );
    return Container(
        height: 15.h,
        width: 280.w,
        margin: EdgeInsets.only(top: 18.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 18.w),
              width: 64.w,
            ),
            Container(
              width: 50.w,
              margin: EdgeInsets.fromLTRB(40.w, 0, 40.w, 0),
              child: Text(
                '达标值',
                textAlign: TextAlign.center,
                style: textStyle,
              ),
            ),
            Container(
              width: 50.w,
              child: Text('实际值', textAlign: TextAlign.center, style: textStyle),
            ),
          ],
        ));
  }

  Widget _itemNameContainer(child) {
    return Container(
      width: 64.w,
      child: child,
    );
  }

  Widget _itemRefContainer(child) {
    return Container(
      width: 60.w,
      margin: EdgeInsets.fromLTRB(40.w, 0, 40.w, 0),
      child: child,
    );
  }

  Widget _itemValueContainer(child) {
    return Container(
      width: 50.w,
      child: child,
    );
  }

  Widget _headlthArrow() {
    return Container(
        width: 6.w,
        child: Icon(
          Icons.arrow_forward_ios,
          color: AppColors.linkText,
        ));
  }

  void _navToHealthSub(String subPage) {
    print(subPage);
    Application.go(context, subPage);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('健康'),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: _getHealthInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            HealthProvider provider = Provider.of<HealthProvider>(context);
            List<RiskAssessment> riskAssessment = provider.riskAssessment;
            List<MedicineInspection> medicineInspection =
                provider.medicineInspection;
            List<LifeStandard> lifeStandard = provider.lifeStandard;
            return SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.fromLTRB(15.w, 13.h, 15.w, 13.h),
                    decoration: BoxDecoration(
                      color: AppColors.pageBg,
                    ),
                    child: Column(
                      children: <Widget>[
                        _riskWidget(riskAssessment),
                        DividerLine(height: 13),
                        _medicineWidget(medicineInspection),
                        DividerLine(height: 13),
                        _lifeWidget(lifeStandard),
                      ],
                    )));
          } else {
            return FLEmptyContainer(
              showLoading: true,
              title: '加载中...',
            );
          }
        },
      ),
    );
  }
}
