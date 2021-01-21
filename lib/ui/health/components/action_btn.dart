import 'package:patient/ui/page_index.dart';

class ActionBtn extends StatelessWidget {
  final Function cb;
  final String text;
  ActionBtn({
    @required this.text,
    this.cb,
  });

  Widget build(BuildContext context) {
//    print("SelfUploadBtn");
//    print(type);
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5.w)),
      child: SizedBox(
        height: 45.h,
        child: RaisedButton(
            color: AppColors.themeColor,
            onPressed: () {
              cb();
            },
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 17.sp),
            )),
      ),
    );
  }
}
