import 'package:flutter/material.dart';

import 'common/component/CustomTextFormField.dart';

void main() {
  runApp(
    _App()
  );
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(hintText: "이메일을 입력해주세요",),
            CustomTextFormField(),
          ],
        )
      ),
    );
  }
}
