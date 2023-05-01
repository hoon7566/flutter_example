import 'package:actual/common/const/data.dart';
import 'package:actual/restaurant/component/restraurant_card.dart';
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
                return  CircularProgressIndicator();
              }

              return ListView.separated(
                  itemBuilder: (context, index) {
                    final item = snapshot.data![index];

                    return RestaurantCard(
                        image: Image.network(
                          "http://$SERVER_IP${item['thumbUrl']}",
                          fit: BoxFit.cover,
                        ),
                        // 이래야 전체를 차지함
                        name: item['name'],
                        tags: List<String>.from(item['tags']),
                        ratingsCount: item['ratingsCount'],
                        deliveryTime: item['deliveryTime'] ,
                        deliveryFee: item['deliveryFee'] ,
                        ratings: item['ratings'] );
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
