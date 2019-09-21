import 'package:flutter/material.dart';

/// flutter中 ，页面之间的跳转，是通过 Route 和Navigator
/// Route  路由，页面的抽象  创建对应的界面，并且 接受参数，响应 Navigator
/// Navigator 会 维护一个 路由栈 去管理  Route   ,打开一个页面，可以想象成  入栈，  关闭页面，理解成  出栈
///
///
/// 路由分为 两种方式：   基本路由   、    命名路由

void main(List<String> args) => runApp(MaterialApp(
      home: FirstPage(),
      routes: {
        'second_page': (context) => SecondPage(),
        'third_page': (context) => ThirdPage(),
      },
      onUnknownRoute: (RouteSettings setting) => MaterialPageRoute(
        builder: (context) => UnkownPage(),
      ),
    ));

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String _msg = 'hd参数';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第一个页面'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('跳转到第二个页面'),
              // onPressed: () => Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => SecondPage(),
              //   ),
              // ),
              onPressed: () => Navigator.pushNamed(context, 'second_page'),
              // onPressed: () => Navigator.pushNamed(context, 'safsdafsad'),
            ),
            RaisedButton(
              child: Text('错误页面，统一跳转'),
              onPressed: () => Navigator.pushNamed(context, 'safsdafsad'),
            ),
            RaisedButton(
              child: Text('路由传参'),
              onPressed: () =>
                  Navigator.pushNamed(context, 'third_page', arguments: 'haha')
                      .then((msg) {
                setState(() {
                  _msg = msg;
                });
              }),
            ),
            Text('回传过来的参数: $_msg'),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第二个页面'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('返回'),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String msg = ModalRoute.of(context).settings.arguments as String;
    // msg = msg == null ? '没有参数' : msg;
    msg ??= '没有参数';

    return Scaffold(
      appBar: AppBar(
        title: Text('接受参数'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('传递过来过的参数是：$msg'),
            RaisedButton(
              child: Text('返回并传参'),
              onPressed: () => Navigator.pop(context, '回传的参数'),
            ),
          ],
        ),
      ),
    );
  }
}

class UnkownPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('404页面'),
        ),
        body: Text('您访问的资源没有！'),
      );
}
