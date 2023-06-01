import 'package:actual/common/model/cursor_pagination_model.dart';
import 'package:actual/restaurant/client/restaurant_client.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>(
        (ref) => RestaurantStateNotifier(ref.watch(restaurantClientProvider)));

class RestaurantStateNotifier extends StateNotifier<CursorPaginationBase> {
  final RestaurantClient restaurantClient;

  // 맨 처음은 로딩상태이므로 super의 생성자값은 CursorPaginationLoading이 된다.
  RestaurantStateNotifier(this.restaurantClient)
      : super(CursorPaginationLoading()) {
    paginate();
  }

  paginate({
    int fetchCount = 20,
    // true - 추가로 데이터 더 가져옴
    // false - 새로고침 ( 현재 상태를 덮어씌움)
    bool fetchMore = false,
    // 강제로 다시 로딩하기
    // true - CursorPaginationLoading()
    bool isRefresh = false,
  }) async {
    // 5가지 경우의 수가 존자함.
    // 1) CursorPagination - 정상적으로 데이터가 있는 상태
    // 2) CursorPaginationLoading - 데이터가 로딩중인 상태 ( 현재 캐시 없음)
    // 3) CursorPaginationError - 데이터 로딩중 에러가 발생한 상태
    // 4) CursorPaginationRefetching - 첫번째 페이지부터 다시 데이터를 가져올 때
    // 5) CursorPaginationFetchMore - 추가 데이터를 pagination하는 요청을 받은 상태


    // final resp = await restaurantClient.getRestaurants();
    // state = resp;
  }
}
