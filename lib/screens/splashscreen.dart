import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:tugasmodul3kel31/screens/navbar.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  @override
  _Splashskrin createState() => new _Splashskrin();
}

class _Splashskrin extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 6,
        title: new Text('MyAnime Kel31', textScaleFactor: 2),
        image: new Image.asset('assets/nyancat.png'),
        loadingText: Text("Loading"),
        photoSize: 100.0,
        loaderColor: Colors.blue,
        navigateAfterSeconds: new Navbar());
  }
}
