import 'package:patient/ui/page_index.dart';
import 'package:patient/ui/health/components/left_border_title.dart';

class LipidAndUaItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 345.w,
      height: 100.h,
      padding: EdgeInsets.only(top: 10.h, left: 10.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.w)),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(10, 0, 0, 0),
                offset: Offset(0, 0),
                blurRadius: 7,
                spreadRadius: 2)
          ],
          border: Border.all(width: 0.5.w, color: Colors.black12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          LeftBorderTitle('总胆固醇'),
          Row(),
        ],
      ),
    );
  }
}
