import 'package:patient/ui/page_index.dart';

class RecordTitle extends StatelessWidget {
  final String title;
  final String subTitle;
  RecordTitle({
    @required this.title,
    @required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    var mainStyle =
        TextStyle(fontSize: 15.sp, height: 1, color: AppColors.mainText);
    var helpStyle =
        TextStyle(fontSize: 13.sp, height: 1.3, color: AppColors.helpText);
    return Container(
      height: 17.h,
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Text(title, style: mainStyle),
        Container(
          margin: EdgeInsets.only(left: 10.w, right: 10.w),
          child: Text("|", style: helpStyle),
        ),
        Text(subTitle, style: helpStyle),
      ]),
    );
  }
}
