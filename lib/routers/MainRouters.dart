import 'package:flutter/widgets.dart';
import 'package:flutter_app/page/HomePage.dart';
import 'package:flutter_app/page/LoginPage.dart';
import 'package:flutter_app/page/MainPage.dart';
import 'package:flutter_app/page/UserListPage.dart';

class MainRouters {
  static Map<String, WidgetBuilder> routes() {
    return <String, WidgetBuilder>{
      'main': (context) => MainPage(),
      'home_page': (context) => HomePage(),
      'login_page': (context) => LoginPage(),
      'user_list': (context) => UserListPage(),
    };
  }
}
