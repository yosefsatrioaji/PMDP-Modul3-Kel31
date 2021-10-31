import 'package:flutter/material.dart';
import 'package:tugasmodul3kel31/screens/home.dart';
import 'package:tugasmodul3kel31/screens/detail.dart';
import 'package:tugasmodul3kel31/screens/splashscreen.dart';
import 'package:tugasmodul3kel31/screens/about.dart';
import 'package:tugasmodul3kel31/screens/navbar.dart';

void main() async {
  runApp(const AnimeApp());
}

class AnimeApp extends StatelessWidget {
  const AnimeApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime app',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Splash(),
        '/home': (context) => const HomePage(),
        '/detail': (context) => const DetailPage(item: 0, title: ''),
        '/about': (context) => About(),
        '/navabar': (context) => Navbar(),
      },
    );
  }
}
