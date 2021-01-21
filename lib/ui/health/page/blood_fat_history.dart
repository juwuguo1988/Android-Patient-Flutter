import 'package:flutter/material.dart';

class BloodFatHistory extends StatelessWidget {
  BloodFatHistory();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('血脂历史'),
      ),
      body: Container(
          color: Colors.white,
          child: Text("data")),
    );
  }
}
