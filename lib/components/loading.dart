import 'package:flutter/material.dart';
import 'package:flui/flui.dart';

class Loading extends StatelessWidget {
  Loading();

  Widget build(BuildContext context) {
    return FLEmptyContainer(
      showLoading: true,
      title: '加载中...',
    );
  }
}
