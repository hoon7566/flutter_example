import 'package:flutter/material.dart';
import 'package:riverpd/layout/default_layout.dart';
import 'package:riverpd/screen/state_provider_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: "home screen",
        body: ListView(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => StateProviderScreen()));
              },
              child: Text("StateProviderScreen"),
            ),
          ],
        ));
  }
}
