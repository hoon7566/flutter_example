import 'package:actual/common/const/data.dart';
import 'package:actual/common/dio/custom_interceptor.dart';
import 'package:actual/restaurant/client/restaurant_client.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:actual/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../common/model/cursor_pagination_model.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List<RestaurantModel>> paginateRestaurant() async {
      final dio =Dio();

      dio.interceptors.add(CustomInterceptor(storage: storage));

      RestaurantClient client = RestaurantClient(
          dio, baseUrl: "http://$SERVER_IP/restaurant");

      final resp = await client.getRestaurants();
      return resp.data;
    }

    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FutureBuilder<List<RestaurantModel>>(
            future: paginateRestaurant(),
            builder: (context, AsyncSnapshot<List<RestaurantModel>> snapshot) {
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
                            return RestaurantDetailScreen(restaurantId: snapshot.data![index].id);
                          }));
                        },
                        child: RestaurantCard.fromModel(model: snapshot.data![index]));
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 16,
                    );
                  },
                  itemCount: snapshot.data!.length);
            },
          ),
        ),
      ),
    );
  }
}
