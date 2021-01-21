import 'package:flutter/material.dart';

class BloodSugarHistory extends StatelessWidget {
  BloodSugarHistory();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('血糖历史'),
      ),
      body: Container(
          color: Colors.white,
          child: Text("data")),
    );
  }
}
