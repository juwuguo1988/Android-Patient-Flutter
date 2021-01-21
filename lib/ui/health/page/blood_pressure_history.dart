import 'package:flutter/material.dart';

class BloodPressureHistory extends StatelessWidget {
  BloodPressureHistory();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('血压历史'),
      ),
      body: Container(
          color: Colors.white,
          child: Text("data")),
    );
  }
}
