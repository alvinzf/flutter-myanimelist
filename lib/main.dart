import 'package:flutter/material.dart';
import 'package:mod3_kelxx/screens/home.dart';
import 'package:mod3_kelxx/screens/detail.dart';

void main() async {
  runApp(AnimeApp());
}

class AnimeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Anime app',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/detail': (context) => DetailPage(item: 0, title: ''),
      },
    );
  }
}