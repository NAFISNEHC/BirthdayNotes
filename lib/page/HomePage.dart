import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/ListItemModel.dart';
import '../utils/JudgeSex.dart';
import '../utils/EngDate.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomePage();
}

class _HomePage extends State {
  DateTime _lastPressedAt; //上次点击时间

  //homepage({Key key, this.title}) : super(key: key);
  final title = 'Longevity star';
  var today = DateTime.now();
  var month = DateTime.now().month;
  var day = DateTime.now().day;
  int _selectPage = 2;
  final PageController _defaultPageController = PageController(initialPage: 2);

  _addCounter() {
    setState(() {
      if (_selectPage != 5) {
        this.today = today.add(new Duration(days: 1));
        this.day = today.day;
        this.month = today.month;
      }
    });
  }

  _subCounter() {
    setState(() {
      if (_selectPage != 0) {
        this.today = today.subtract(new Duration(days: 1));
        this.day = today.day;
        this.month = today.month;
      }
    });
  }

  _onPageChanged(index) {
    setState(() {
      if (_selectPage < index) {
        _addCounter();
        _selectPage = index;
      } else if (_selectPage > index) {
        _subCounter();
        _selectPage = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Container(
        color: Colors.black87,
        child: new Scaffold(
          backgroundColor: Colors.transparent, //把scaffold的背景色改成透明
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: new Column(
            children: <Widget>[
              new Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.white,
                  border: Border.all(color: Colors.white, width: 2.0),
                ),
                height: 40.0,
                padding: EdgeInsets.only(top: 5.0, left: 16.0, right: 16.0),
                margin: EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
                child: new TextField(
                  maxLines: 1,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: Colors.black87,
                    ),
                    hintText: '请输入要查询的客户信息',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    contentPadding: new EdgeInsets.only(bottom: 2.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
              new Row(
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Text.rich(new TextSpan(
                      children: <TextSpan>[
                        new TextSpan(
                            text:
                                '${EngDate(this.month, this.day).judgeMonth()}',
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 28.0,
                                decoration: TextDecoration.none)),
                        new TextSpan(
                            text: ', ',
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                decoration: TextDecoration.none)),
                        new TextSpan(
                            text: '${this.day}',
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                decoration: TextDecoration.none)),
                        new TextSpan(
                            text:
                                ' ${EngDate(this.month, this.day).judgeDay()}',
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                decoration: TextDecoration.none)),
                      ],
                    )),
                  ),
                ],
              ),
              Flexible(
                child: new MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: new PageView.builder(
                    itemBuilder: ((context, index) {
                      return Container(
                        child: new _ListView(),
                      );
                    }),
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    reverse: false,
                    controller: _defaultPageController,
                    physics: PageScrollPhysics(parent: BouncingScrollPhysics()),
                    onPageChanged: _onPageChanged,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
          //两次点击间隔超过1秒则重新计时
          _lastPressedAt = DateTime.now();
          BotToast.showSimpleNotification(title: "在按一下退出APP"); //弹出简单通知Toast
          return false;
        }
        // 提示退出？
        _lastPressedAt = DateTime.now();
        await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return true;
      },
    );
  }
}

class _ListView extends StatelessWidget {
  const _ListView();

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(16.0),
      child: new ListView(
        children: items.map((item) {
          return new Card(
            elevation: 5.0, //设置阴影
            color: Colors.white,
            margin: EdgeInsets.only(bottom: 16.0),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))), //设置圆角
            child: new Row(
              children: <Widget>[
                Flexible(
                  child: new Column(
                    children: <Widget>[
                      new ListTile(
                        leading: new CircleAvatar(
                          backgroundImage:
                              AssetImage(new JudgeSex(item.sex).judge()),
                          backgroundColor: Colors.white,
                        ),
                        title: Text(
                          item.name,
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          item.phone,
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ),
                new IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Colors.black87,
                    ),
                    onPressed: null)
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
