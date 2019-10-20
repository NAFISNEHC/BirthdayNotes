import 'package:flutter/widgets.dart';
import 'package:flutter_app/page/HomePage.dart';
import 'package:flutter_app/page/LoginPage.dart';
import 'package:flutter_app/page/MainPage.dart';
import 'package:flutter_app/page/UserListPage.dart';

class MainRouters {
  static Map<String, WidgetBuilder> routes(BuildContext context) {
    return <String, WidgetBuilder>{
      'main': (BuildContext context) => MainPage(),
      'home_page': (BuildContext context) => HomePage(),
      'login_page': (BuildContext context) => LoginPage(),
      'user_list': (BuildContext context) => UserListPage(),
    };
  }
}
