import 'package:flutter/material.dart';
import 'package:major_app/screens/home_screen.dart';
import 'package:major_app/screens/movies_screen.dart';// Import your home screen file

void main() {
  runApp(MajorCloneApp());
}

class MajorCloneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Major Cineplex Clone',
      theme: ThemeData.dark(),
      home: MoviesScreen(),
    );
  }
}
