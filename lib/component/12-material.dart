import 'package:flutter/material.dart';

///
///  materialApp
///  home    指定我们 app的主页

void main(List<String> args) =>
    runApp(MaterialApp(home: MyHomePage(), title: 'MaterialApp', routes: {
      '/other': (BuildContext context) => OtherPage(),
    })); // runApp 是定义在 widget 库中

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final _widgetsOptions = [
    Text('信息'),
    Text('通讯录'),
    Text('发现'),
    Text('我'),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.grey,
          title: Text(
            'Material Design风格组件库',
          ),
          leading: Icon(Icons.home),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => print('搜索'),
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () => print('更多'),
            )
          ],
        ),
        body: Center(
          child: Column(
            children: <Widget>[_widgetsOptions[_currentIndex], Text('哈哈哈')],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          tooltip: '长按会跳出来',
          onPressed: () => Navigator.pushNamed(context, '/other'),
          // foregroundColor: Colors.yellow,
          // backgroundColor: Colors.grey,
          elevation: 10.0,
          // shape: RoundedRectangleBorder(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // backgroundColor: Colors.pink,
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              title: Text('信息'),
              icon: Icon(Icons.message),
            ),
            BottomNavigationBarItem(
              title: Text('通讯录'),
              icon: Icon(Icons.contacts),
            ),
            BottomNavigationBarItem(
              title: Text('发现'),
              icon: Icon(Icons.location_on),
            ),
            BottomNavigationBarItem(
              title: Text('我'),
              icon: Icon(Icons.person),
            ),
          ],
          // 默认的type 是  底部导航栏 混合模式
          // type: BottomNavigationBarType.shifting,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        drawer: _buildDrawer(),
        endDrawer: Container(
          child: Text('aaa'),
        ),
      );

  Drawer _buildDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            // 点击头像   会有一个账户信息
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'http://b-ssl.duitang.com/uploads/item/201809/26/20180926162125_vjbwi.jpg'),
            ),
            accountName: Text('Eason'),
            accountEmail: Text('2330053753@qq.com'),
            otherAccountsPictures: <Widget>[
              Icon(Icons.camera),
              Icon(Icons.error),
            ],
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/tzd.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('会员特权'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('会员特权'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('会员特权'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('会员特权'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('会员特权'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('会员特权'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('会员特权'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('会员特权'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('会员特权'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('会员特权'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          AboutListTile(
            icon: Icon(Icons.error),
            child: Text('关于我们'),
            applicationIcon: Icon(Icons.person),
            applicationName: '天之道',
            applicationVersion: '1.0.3',
          )
        ],
      ),
    );
  }
}

class OtherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('另一个页面'),
        ),
        body: Text('我的另一个页面'),
      );
}
