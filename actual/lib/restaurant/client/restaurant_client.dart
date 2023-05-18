import 'package:actual/common/model/cursor_pagination_model.dart';
import 'package:actual/restaurant/model/restaurant_detail_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../../common/const/data.dart';
import '../../common/dio/custom_interceptor.dart';
import '../model/restaurant_model.dart';

part 'restaurant_client.g.dart';

final restaurantClientProvider = Provider<RestaurantClient>((ref) {
  final dio = ref.watch(dioProvider); //그럴일은 없겠지만 dioprovider가 바뀌면 다시 호출됨
  return RestaurantClient(dio, baseUrl: "http://$SERVER_IP/restaurant");
});

@RestApi()
abstract class RestaurantClient {
  factory RestaurantClient(Dio dio, {required String baseUrl}) =
      _RestaurantClient;

  @GET("/")
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<RestaurantModel>> getRestaurants();

  @GET("/{id}")
  @Headers({'accessToken': 'true'})
  Future<RestaurantDetailModel> getRestaurantDetail(@Path("id") String id);
}
