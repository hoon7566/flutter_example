import 'package:actual/restaurant/client/restaurant_client.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantProvider =
StateNotifierProvider<RestaurantStateNotifier, List<RestaurantModel>>((ref) =>
    RestaurantStateNotifier(ref.watch(restaurantClientProvider)));

class RestaurantStateNotifier extends StateNotifier<List<RestaurantModel>> {
  final RestaurantClient restaurantClient;

  RestaurantStateNotifier(this.restaurantClient) : super([]) {
    paginate();
  }

  paginate() async {
    final resp = await restaurantClient.getRestaurants();
    state = resp.data;
  }
}
