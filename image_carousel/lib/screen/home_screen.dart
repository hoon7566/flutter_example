import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? _timer = null;
  PageController _pageController = PageController(
    initialPage: 0,
    // viewportFraction: 0.8,
  );

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      print('timer');
      int currentPage = _pageController.page?.toInt() ?? 0;
      int nextPage = (currentPage + 1) % 4;

      _pageController.animateToPage(
        nextPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );

    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [1, 2, 3, 4, 5]
            .map((e) => Image(
                  image: AssetImage('assets/img/image_$e.jpeg'),
                  fit: BoxFit.cover,
                ))
            .toList(),
      ),
    );
  }
}
