import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime dateTime = DateTime.parse("2020-07-22");

  Duration duration = DateTime.now().difference(DateTime.parse("2020-07-22"));

  void onHeartPressed() {
    showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: 300,
                color: Colors.white,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime.now(),
                  maximumDate: DateTime.now(),
                  onDateTimeChanged: (DateTime newDateTime) {
                    setState(() {
                      dateTime = newDateTime;
                      duration = dateTime.difference(DateTime.now());
                    });
                  },
                )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        bottom: false,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              _TopPart(
                  dateTime: dateTime,
                  duration: duration,
                  onPressed: onHeartPressed),
              _BottomPart(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopPart extends StatelessWidget {
  final DateTime dateTime;
  final Duration duration;
  final VoidCallback onPressed;

  _TopPart(
      {required this.dateTime,
      required this.duration,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('U&I', style: theme.textTheme.displayLarge),
          Column(children: [
            Text(
              '우리 처음 만난날',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'sunflower',
                fontWeight: FontWeight.w200,
                color: Colors.white,
              ),
            ),
            Text(
              '${dateTime.year}.${dateTime.month}.${dateTime.day}.',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'sunflower',
                fontWeight: FontWeight.w200,
                color: Colors.white,
              ),
            )
          ]),
          IconButton(
            icon: Icon(Icons.favorite),
            iconSize: 50,
            color: Colors.red,
            onPressed: onPressed,
          ),
          Text(
            'D+${duration.inDays}',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              fontFamily: 'sunflower',
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomPart extends StatelessWidget {
  const _BottomPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: const Image(
        image: AssetImage('asset/img/middle_image.png'),
      ),
    );
  }
}
