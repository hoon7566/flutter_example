import 'package:actual/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

import '../const/colors.dart';

class RootTab extends StatefulWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '코팩 딜리버리', child: Center(child: Text('RootTab'))
      ,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed, // 기본이 shifting임 (shifting은 선택했을때 쫌더 커짐)
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: '홈'),
          BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined), label: '검색'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: '장바구니'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: '마이페이지'),
        ],
      ),

    );
  }
}
