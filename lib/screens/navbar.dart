import 'package:flutter/material.dart';
import 'package:tugasmodul3kel31/screens/home.dart';
import 'package:tugasmodul3kel31/screens/about.dart';

class Navbar extends StatefulWidget {
  @override
  State createState() {
    return _BottomNavbar();
  }
}

class _BottomNavbar extends State {
  int _currentIndex = 0;
  final List _children = [HomePage(), About()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MyAnimeList')),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex:
            _currentIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: new Icon(Icons.person), label: 'Profile')
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
