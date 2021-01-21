import 'package:patient/ui/page_index.dart';

class LeftBorderTitle extends StatelessWidget {

  final String title;
  LeftBorderTitle(this.title);

  Widget build(BuildContext context) {
    var _titleStyle =
    TextStyle(fontSize: 15.sp, height: 1, color: AppColors.mainText);
    return Container(
      padding: EdgeInsets.only(left: 7.w),
      height: 15.h,
      decoration: BoxDecoration(
        border:
        Border(left: BorderSide(width: 3.w, color: AppColors.themeColor)),
      ),
      child: Text(title, style: _titleStyle),
    );
  }
}
