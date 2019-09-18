import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/page/HomePage.dart';
import 'package:flutter_app/page/MainPage.dart';

class MainRouters {
  static Map<String, WidgetBuilder> routes() {
    return <String, WidgetBuilder>{
      '/': (BuildContext context) => new MainPage(),
      '/home': (BuildContext context) => BotToastInit(
            child: HomePage(),
          ),
    };
  }
}
