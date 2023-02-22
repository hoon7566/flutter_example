import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_number/constant/color.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('랜덤 숫자 생성기',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.settings, color: RED_COLOR)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('0'),
                  Text('0'),
                  Text('0'),
                  Text('0'),
                  Text('0')
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: RED_COLOR,
                  ),
                  onPressed: () {},
                  child: Text('생성하기'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
