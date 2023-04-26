import 'dart:isolate';

import 'package:alarm/alarm.dart';
import 'package:alarm_example/screen/home_screen.dart';
import 'package:flutter/material.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Alarm.init();



  runApp( MaterialApp(
    home: HomeScreen(),
  ));
}
