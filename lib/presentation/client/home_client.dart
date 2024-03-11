import 'package:flutter/material.dart';

class HomeClient extends StatefulWidget {
  const HomeClient({Key? key}) : super(key: key);

  @override
  State<HomeClient> createState() => _HomeClientState();
}

class _HomeClientState extends State<HomeClient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Home client"),
      ),
    );
  }
}
