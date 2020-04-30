import 'package:flutter/material.dart';

import './screens/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.grey,
        primaryColor: Colors.white,
      ),
      home: HomeScreen(),
    );
  }
}
