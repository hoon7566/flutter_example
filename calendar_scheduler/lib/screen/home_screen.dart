import 'package:calendar_scheduler/component/calendar.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar Scheduler'),
      ),
      body: SafeArea(
        child: Center(
          child: Calendar(),
        ),
      ),
    );

  }
}
