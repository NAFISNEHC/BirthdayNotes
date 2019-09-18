import 'package:flutter/material.dart';
import 'package:flutter_app/page/MainPage.dart';
import 'package:bot_toast/bot_toast.dart';
import './page/HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      navigatorObservers: [BotToastNavigatorObserver()], //1.注册路由观察者
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => new MainPage(),
        '/home': (BuildContext context) => BotToastInit(
              child: HomePage(),
            ),
      },
    );
  }
}
