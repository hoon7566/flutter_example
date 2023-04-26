import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Container(
        // press the button to test the stomp client
        child: IconButton(
          icon: Icon(Icons.add),
          onPressed: test,
      ),

    )
    );
  }

  test() {
    print(1);
    StompClient client = StompClient(
      config: StompConfig.SockJS(
        url: 'http://localhost:1123/ws-sockjs',
        onConnect: onConnect,
        onWebSocketError: (dynamic error) => print(error.toString()),
      ),
    );
    client.activate();
    return 1;
  }

  void onConnect(StompFrame frame) {
    frame.headers.forEach((key, value) => print('$key: $value'));
    frame.body != null ? print(frame.body) : print('no body');
    print('connected');
  }
}


