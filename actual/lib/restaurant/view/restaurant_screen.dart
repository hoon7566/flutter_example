import 'package:actual/common/const/data.dart';
import 'package:actual/common/dio/custom_interceptor.dart';
import 'package:actual/restaurant/client/restaurant_client.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:actual/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/model/cursor_pagination_model.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  // Future<List<RestaurantModel>> paginateRestaurant(WidgetRef ref) async {
  //   Dio dio = ref.watch(dioProvider);
  //
  //   RestaurantClient client = RestaurantClient(
  //       dio, baseUrl: "http://$SERVER_IP/restaurant");
  //
  //   final resp = await client.getRestaurants();
  //   return resp.data;
  // }


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FutureBuilder<CursorPagination<RestaurantModel>>(
            future: ref.watch(restaurantClientProvider).getRestaurants(),
            builder: (context, AsyncSnapshot<CursorPagination<RestaurantModel>> snapshot) {
              print(snapshot.data);
              print(snapshot.error);

              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              return ListView.separated(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return RestaurantDetailScreen(restaurantId: snapshot.data!.data[index].id);
                          }));
                        },
                        child: RestaurantCard.fromModel(model: snapshot.data!.data[index]));
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 16,
                    );
                  },
                  itemCount: snapshot.data!.data.length);
            },
          ),
        ),
      ),
    );
  }
}
