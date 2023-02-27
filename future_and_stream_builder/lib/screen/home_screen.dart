import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static final textStyle = TextStyle(fontSize: 16.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: StreamBuilder<int>(
          stream: getNumberStream(),
          builder: (context, snapshot) {

            // if (!snapshot.hasData) {
            //   return Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }


            return Column(
              children: [
                Text('StreamBuilder',
                    style: textStyle.copyWith(
                        fontSize: 24.0, fontWeight: FontWeight.bold)),
                Text('Constate : ${snapshot.connectionState}',
                    style: textStyle),
                Text('data : ${snapshot.data}',
                    style: textStyle),
                Text('Error : ${snapshot.error}',
                    style: textStyle),
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: Text('Click me'),
                )
              ],
            );
          }),
    );
  }

  Future<int> getNumber() async {
    await Future.delayed(Duration(seconds: 3));

    final random = Random();
    return random.nextInt(100);
  }

  Stream<int> getNumberStream() async* {
    final random = Random();

    for (var i = 0; i < 10; i++) {
      await Future.delayed(Duration(seconds: 1));
      if (i == 5) {
        throw Exception('Error');
      }
      yield random.nextInt(100);
    }
  }
}
