import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpd/screen/home_screen.dart';

void main() {
  // 초기화
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(
    child: MaterialApp(
      home: HomeScreen(),
    ),
  ));
}
