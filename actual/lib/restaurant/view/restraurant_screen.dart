import 'package:actual/restaurant/component/restraurant_card.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: RestaurantCard(
              image: Image.asset("asset/img/food/ddeok_bok_gi.jpg" , fit: BoxFit.cover,), // 이래야 전체를 차지함
              name: "불타는 떡볶이",
              tags: ["떡볶이", "치즈", "매운 맛"],
              ratingCount: 32,
              deliveryTime: 30,
              deliveryFee: 2500,
              rating: 4.5),
        ),
      ],
    );
  }
}
