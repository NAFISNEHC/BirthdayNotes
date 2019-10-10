import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/component/Item.dart';
import 'package:flutter_app/service/UserApi.dart';
import 'package:flutter_app/utils/EngDate.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//only ListView
class UserListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UserListPageState();
  }
}

class _UserListPageState extends State<UserListPage> {
  DateTime _lastPressedAt; //上次点击时间

  //homepage({Key key, this.title}) : super(key: key);
  final title = 'Longevity star';
  var today = DateTime.now();
  var month = DateTime.now().month;
  var day = DateTime.now().day;

  RefreshController _refreshController = RefreshController(initialRefresh: false);
  List<String> data = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];

  Widget buildCtn() {
    return ListView.separated(
      physics: ClampingScrollPhysics(),
      padding: EdgeInsets.only(left: 5, right: 5),
      itemBuilder: (c, i) => Item(
        title: data[i],
      ),
      separatorBuilder: (context, index) {
        return Container(
          height: 0.5,
          color: Colors.greenAccent,
        );
      },
      itemCount: data.length,
    );
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
                child: SmartRefresher(
                  controller: _refreshController,
                  enablePullUp: true,
                  child: buildCtn(),
                  footer: ClassicFooter(
                    loadStyle: LoadStyle.ShowAlways,
                    completeDuration: Duration(milliseconds: 500),
                  ),
                  header: WaterDropHeader(),
                  onRefresh: () async {
                    //从网络获取数据
                    await Future.delayed(Duration(milliseconds: 1000));

                    if (data.length == 0) {
                      for (int i = 0; i < 10; i++) {
                        data.add("Item $i");
                      }
                    }
                    if (mounted) setState(() {});
                    _refreshController.refreshCompleted();
                  },
                  onLoading: () async {
                    //从网络获取数据
                    List<Map<String, dynamic>> userList = await UserApi.getUserList(null);
                    print(userList);
                    if (mounted) setState(() {});
                    _refreshController.loadFailed();
                  },
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