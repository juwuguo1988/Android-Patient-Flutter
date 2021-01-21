import 'package:flutter/material.dart';

class HomeChatPageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeChatViewUI();
  }
}

class _HomeChatViewUI extends State<HomeChatPageView>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "医患聊天"
      ),
    );
  }
}
