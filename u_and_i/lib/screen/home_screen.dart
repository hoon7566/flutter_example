import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Text('Hello World'
                  ,style: TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'parisienne',
                    color: Colors.white,
                  ),
              ),
              Text('Hello World'),
              Text('Hello World'),
              IconButton(onPressed: (){}, icon: Icon(Icons.favorite)),
            ],
          ),
        ),
      ),
    );
  }
}