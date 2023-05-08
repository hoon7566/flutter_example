import 'package:actual/common/model/cursor_pagination_model.dart';
import 'package:actual/restaurant/model/restaurant_detail_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../model/restaurant_model.dart';

part 'restaurant_client.g.dart';

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
