import 'package:actual/common/layout/default_layout.dart';
import 'package:actual/product/view/product_card.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import '../../common/const/data.dart';
import '../model/restaurant_detail_model.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String restaurantId;

  const RestaurantDetailScreen({required this.restaurantId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<Map<String, dynamic>> restaurantDetail() async {
      final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
      Dio dio = Dio();
      final resp = await dio.get("http://$SERVER_IP/restaurant/$restaurantId",
          options: Options(headers: {'authorization': 'Bearer $accessToken'}));
      log("resp : $resp");
      return resp.data;
    }

    return FutureBuilder(
      future: restaurantDetail(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final pitem = RestaurantDetailModel.fromJson(json: snapshot.data!);

        return DefaultLayout(
            title: "불타는 떡볶이",
            child: CustomScrollView(
              slivers: [
                renderTop(pitem),
                renderLabel(),
                renderProducts(pitem.products),
              ],
            )

            // Column(
            //   children: [
            //     RestaurantCard.fromModel(model: pitem, isDetail: true, detail: pitem.detail),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //       child: ProductCard(),
            //     )
            //   ],
            // ),
            );
      },
    );
  }

  SliverToBoxAdapter renderTop(RestaurantDetailModel model) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
          model: model, isDetail: true, detail: model.detail),
    );
  }

  SliverPadding renderLabel(){
    return  SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            "메뉴",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  SliverPadding renderProducts( List<RestaurantProductModel> products){
    return SliverPadding(
      padding: const EdgeInsets.symmetric( horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: ProductCard(),
          );
        }, childCount: products.length),
      ),
    );
  }
}
