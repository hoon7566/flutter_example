import 'package:actual/common/const/colors.dart';
import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final String? title;
  final Widget? bottomNavigationBar;

  const DefaultLayout(
      {required this.child,
      this.backgroundColor,
      this.title,
      this.bottomNavigationBar,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      backgroundColor: backgroundColor ?? Colors.white,
      body: child,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  AppBar? renderAppBar() {
    if (title == null) {
      return null;
    }

    return AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0.0, //  그림자 제거   튀어나오는 효과를 주는건데 디자인적으로 요새는 없는게 트랜드라서 없앤다.
        title: Text(
          title!,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ));
  }
}
