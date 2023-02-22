import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_number/component/NumberRow.dart';
import 'package:random_number/constant/color.dart';
import 'package:random_number/screen/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Set<int> randomNumbers = {123, 456, 789};
  int maxNumber = 899;
  changeRandomNumbers() {

    final random = Random();
    setState(() {
      randomNumbers.clear();
      while (randomNumbers.length < 3) {
        randomNumbers.add(random.nextInt(maxNumber) + 100);
      }
    });
  }

  settingBtnPressed () async {
    final int? result = await Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context){
          return SettingsScreen(maxNumber: maxNumber,);
        })
    );
    if(result != null){
      print(result);
      setState(() {
        maxNumber = result;
        changeRandomNumbers();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(settingBtnPressed: settingBtnPressed),
             _Body(randomNumbers: randomNumbers),
            _Footer(onPressed: changeRandomNumbers),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final VoidCallback settingBtnPressed;
  const _Header({Key? key
    , required this.settingBtnPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('랜덤 숫자 생성기',
              style: TextStyle(fontSize: 20, color: Colors.white)),
          IconButton(
              onPressed: settingBtnPressed, icon: Icon(Icons.settings, color: RED_COLOR)),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final Set<int> randomNumbers;
  _Body({Key? key, required this.randomNumbers }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: randomNumbers
              .map((e) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: NumberRow(number: e),
          ))
              .toList()),
    );
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onPressed;
  const _Footer({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: RED_COLOR,
          ),
          onPressed: onPressed,
          child: Text('생성하기'),
        ),
      ),
    );
  }
}
