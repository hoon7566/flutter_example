import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpd/layout/default_layout.dart';
import 'package:riverpd/model/shopping_item_model.dart';
import 'package:riverpd/riverpod/state_notifier_provider.dart';

class StateNotifierProviderScreen extends ConsumerWidget {
  const StateNotifierProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<ShoppingItemModel> items = ref.watch(shoppingListNotifierProvider);

    return DefaultLayout(
      title: 'StateNotifierProvider',
      body: ListView(
        children: items
            .map(
              (e) => CheckboxListTile(
            value: e.hasBought,
            title: Text('${e.name}(${e.quantity})'),
            onChanged: (value) {
              ref.read(shoppingListNotifierProvider.notifier).toggleHasBought(
                name: e.name,
              );
            },
          ),
        )
            .toList(),
      ),
    );
  }
}