import 'package:actual/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

import '../const/colors.dart';

class RootTab extends StatefulWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

//vsync : 애니메이션을 위한 것
// vsync를 위해서는 SingleTickerProviderStateMixin가 무조건 필요하다.
class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController; // late : 나중에 초기화 할것 라는 의미, 안하고 사용하면 에러남

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      tabListener();
    });
  }

  // 탭바가 이동할때마다 호출되는 함수
  void tabListener() {
    setState(() {
      _selectedIndex = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(() {
      tabListener();
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '코팩 딜리버리',
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(), // 스크롤을 막는다. 오히려 스왑으로 웁직이게 되면 불편 할 수 있기 때문.
        controller: _tabController,
        children: [
          Center(child: Container(child: Text("홈"))),
          Center(child: Container(child: Text("음식"))),
          Center(child: Container(child: Text("주문"))),
          Center(child: Container(child: Text("프로필"))),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        // 기본이 shifting임 (shifting은 선택했을때 쫌더 커짐)
        onTap: (int index) {
          _tabController.animateTo(index); // 탭바 컨트롤러를 이용해서 탭바를 이동시킴
        },
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
          BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined), label: '음식'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: '주문'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: '프로필'),
        ],
      ),
    );
  }
}
