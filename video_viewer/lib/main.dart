import 'package:flutter/material.dart';
import 'package:video_viewer/screen/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      home: Scaffold(
        body: HomeScreen()
      )
    )
  );
}
