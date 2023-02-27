import 'package:flutter/material.dart';
import 'package:video_viewer/screen/HomeScreen.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: "/",
      home: Scaffold(
        body: HomeScreen()
      )
    )
  );
}
