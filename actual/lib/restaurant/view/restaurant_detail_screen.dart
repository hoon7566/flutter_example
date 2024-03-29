import 'package:actual/common/layout/default_layout.dart';
import 'package:actual/common/secure_storage/secure_storage.dart';
import 'package:actual/product/view/product_card.dart';
import 'package:actual/restaurant/client/restaurant_client.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer';

import '../../common/const/data.dart';
import '../../common/dio/custom_interceptor.dart';
import '../model/restaurant_detail_model.dart';

class RestaurantDetailScreen extends ConsumerWidget {
  final String restaurantId;

  const RestaurantDetailScreen({required this.restaurantId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantClient = ref.watch(restaurantClientProvider);
    return FutureBuilder(
      future: restaurantClient.getRestaurantDetail(restaurantId),
      builder: (context, restaurantDetailModel) {
        if (!restaurantDetailModel.hasData) {
          return DefaultLayout(child: Center(child: const CircularProgressIndicator()));
        }

        return DefaultLayout(
            title: "불타는 떡볶이",
            child: CustomScrollView(
              slivers: [
                renderTop(restaurantDetailModel.data!),
                renderLabel(),
                renderProducts(restaurantDetailModel.data!.products),
              ],
            )

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
    return  const SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.only(top: 16.0),
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
            child: ProductCard.fromModel(model: products[index]),
          );
        }, childCount: products.length),
      ),
    );
  }
}
