import 'package:patient/ui/page_index.dart';
import 'package:patient/ui/health/components/record_title.dart';
import 'package:patient/ui/health/components/lipid_ua_item.dart';
import 'package:patient/components/loading.dart';

class BloodFat extends StatelessWidget {
  const BloodFat();

  Future _getLipid(context) async {
    return "success";
  }

  Widget build(BuildContext context) {
    Widget divider = Divider(
      height: 10,
      color: Colors.white,
    );

    return FutureBuilder(
      future: _getLipid(context),
      builder: (context, snapShot) {
//        print("snapShot $snapShot , ${snapShot.hasData}, ${snapShot.data}");
        if (snapShot.hasData) {
          return Consumer<HealthProvider>(
              builder: (context, healthProvider, _) {
                return Container(
                  padding: EdgeInsets.only(left: 15.w, right: 15.w),
                  child: Column(
                    children: <Widget>[
                      divider,
                      RecordTitle(
                        title: "最后一次记录",
                        subTitle: "3月20日",
                      ),
                      divider,
                      LipidAndUaItem(),
                    ],
                  ),
                );
              });
        } else {
          return Loading();
        }
      },
    );
  }
}
