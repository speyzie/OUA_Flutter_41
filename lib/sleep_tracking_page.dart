import 'package:flutter/material.dart';

class SleepTrackingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Uyku Takibi'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text('Uyku Takibi Sayfası'),
      ),
    );
  }
}
