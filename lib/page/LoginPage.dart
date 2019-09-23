import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[50],
      
      //child: Icon(Icons.ac_unit),
      child: new Text(
                'Each birthday is a milestone we touch along life\'s way.\nAffectionate birthday greetings!',
                style: TextStyle(color: Colors.blue[100], fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
    );
  }
}
