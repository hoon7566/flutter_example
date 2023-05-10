import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpd/model/shopping_item_model.dart';

final shoppingListNotifierProvider =
    StateNotifierProvider<ShoppingListNotifier, List<ShoppingItemModel>>(
        (ref) => ShoppingListNotifier());

class ShoppingListNotifier extends StateNotifier<List<ShoppingItemModel>> {
  ShoppingListNotifier()
      : super([
          ShoppingItemModel('Apple', 1, false, false),
          ShoppingItemModel('Banana', 2, false, false),
          ShoppingItemModel('Orange', 3, false, false),
          ShoppingItemModel('Pineapple', 4, false, false),
          ShoppingItemModel('Watermelon', 5, false, false),
        ]);

  void toggleHasBought({required String name}) {
    state = state.map((e) {
      if (e.name == name) {
        e.hasBought = !e.hasBought;
        return e;
      } else {
        return e;
      }
    }).toList();
  }
}
