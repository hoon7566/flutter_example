import 'package:actual/common/const/data.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:actual/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List> paginateRestaurant() async {
      final dio = Dio();

      final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

      final resp = await dio.get("http://$SERVER_IP/restaurant",
          options: Options(headers: {
            'authorization': 'Bearer $accessToken',
          }));

      return resp.data['data'];
    }

    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FutureBuilder<List>(
            future: paginateRestaurant(),
            builder: (context, AsyncSnapshot<List> snapshot) {
              print(snapshot.data);
              print(snapshot.error);

              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              return ListView.separated(
                  itemBuilder: (context, index) {
                    final item = snapshot.data![index];
                    final pItem = RestaurantModel.fromJson(json: item);
                    return GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return RestaurantDetailScreen(restaurantId: pItem.id);
                          }));
                        },
                        child: RestaurantCard.fromModel(model: pItem));
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
