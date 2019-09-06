import 'package:flutter/material.dart';
import 'homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'Birthday Notes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent, //把scaffold的背景色改成透明
        appBar: AppBar(
          backgroundColor: Colors.transparent, //把appbar的背景色改成透明
          elevation: 0, //appbar的阴影
        ),
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
                top: 130.0,
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
                top: 80.0,
              ),
              child: new Material(
                color: Colors.black87,
                child: new MaterialButton(
                  child: new Text(
                    'Take Notes',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  minWidth: 200.0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new homepage()),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
