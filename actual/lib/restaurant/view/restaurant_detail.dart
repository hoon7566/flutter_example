import 'package:actual/common/layout/default_layout.dart';
import 'package:actual/product/view/product_card.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../common/const/data.dart';

class RestaurantDetail extends StatelessWidget {
  final String restaurantId;

  const RestaurantDetail({required this.restaurantId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<Map<String, dynamic>> restaurantDetail() async {
      Dio dio = Dio();
      final resp = await dio.get("http://$SERVER_IP/restaurant/$restaurantId");
      return resp.data;
    }

    return FutureBuilder(
      future: restaurantDetail(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          print("object");
          return CircularProgressIndicator();
        }

        final pitem = RestaurantModel.fromJson(json: snapshot.data!);


        return DefaultLayout(

          title: "불타는 떡볶이",
          child: Column(
            children: [
              RestaurantCard.fromModel(model: pitem, isDetail: true),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ProductCard(),
              )
            ],
          ),
        );
      },
    );
  }
}
