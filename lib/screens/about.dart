import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: AssetImage('assets/rickroll.jpg'),
            radius: 120,
          ),
          Padding(
            child: Text('Kelompok 31', textScaleFactor: 3),
            padding: EdgeInsets.all(10),
          ),
        ],
      )),
    );
  }
}
