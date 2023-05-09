
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpd/layout/default_layout.dart';

import '../riverpod/state_provider_screen.dart';

class StateProviderScreen extends ConsumerWidget {
  const StateProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(numberProvider);


    return DefaultLayout(title: "StateProviderScreen", body: Column(
      children: [
        Text(provider.toString()),
        ElevatedButton(
          onPressed: () {
            ref.read(numberProvider.notifier).update((state) => state+1);
          },
          child: Text("UP"),
        ),
        ElevatedButton(
          onPressed: () {
            ref.read(numberProvider.notifier).state = ref.read(numberProvider.notifier).state -1;
          },
          child: Text("DOWN"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => _NextScreen(),)
            );
          },
          child: Text("Next page"),
        ),
      ],
    ));
  }
}

class _NextScreen extends ConsumerWidget {
  const _NextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(numberProvider);


    return DefaultLayout(title: "StateProviderScreen", body: Column(
      children: [
        Text(provider.toString()),
        ElevatedButton(
          onPressed: () {
            ref.read(numberProvider.notifier).update((state) => state+1);
          },
          child: Text("UP"),
        ),
      ],
    ));
  }
}



