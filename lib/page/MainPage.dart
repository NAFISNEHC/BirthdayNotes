import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent, //把scaffold的背景色改成透明
        appBar: null,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Container(
              margin: EdgeInsets.only(top: 60.0),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new AssetImage('images/logo2.png')),
              ),
              height: 180.0,
            ),
            new Container(
              margin: EdgeInsets.only(
                top: 10.0,
              ),
              child: new Text(
                'Birthday Notes',
                style: TextStyle(color: Colors.black87, fontSize: 30.0),
                textAlign: TextAlign.center,
              ),
              width: 300.0,
            ),
            new Container(
              margin: EdgeInsets.only(
                top: 50.0,
              ),
              child: new Text(
                'Each birthday is a milestone we touch along life\'s way.\nAffectionate birthday greetings!',
                style: TextStyle(color: Colors.black87, fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
              width: 300.0,
            ),
            new Container(
              margin: EdgeInsets.only(
                top: 160.0,
              ),
              child: new Material(
                color: Colors.black87,
                child: RaisedButton(
                  child: Text("Login"),
                  onPressed: () => Navigator.pushNamed(context, 'login_page'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
