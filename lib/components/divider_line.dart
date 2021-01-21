import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient/common/constant.dart' show AppColors;

class DividerLine extends StatelessWidget {
  final int height;
  final int width;
  final Color color;
  const DividerLine({
    this.height,
    this.width: 375,
    this.color: AppColors.pageBg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: width.w,
      color: color,
    );
  }
}
