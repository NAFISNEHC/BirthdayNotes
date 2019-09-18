import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_app/routers/MainRouters.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      navigatorObservers: [BotToastNavigatorObserver()], //1.注册路由观察者
      initialRoute: '/',
      routes: MainRouters.routes(),
    );
  }
}
