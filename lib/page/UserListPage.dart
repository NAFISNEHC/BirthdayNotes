import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/component/UserCard.dart';
import 'package:flutter_app/model/SearchFilter.dart';
import 'package:flutter_app/model/UserInfo.dart';
import 'package:flutter_app/service/UserApi.dart';
import 'package:flutter_app/utils/DateUtils.dart';
import 'package:flutter_app/utils/EngDate.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//only ListView
class UserListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {

  //上次点击时间
  DateTime _lastPressedAt;

  // 上面显示的那个日期
  DateTime _date = DateTime.now();

  // 查询的参数
  SearchFilter _params = SearchFilter(
      1, null,
      DataUtils.instance
          .getStartAnEndDay(date: DateTime.now(), type: 's'),
      DataUtils.instance
          .getStartAnEndDay(date: DateTime.now()));

  // 刷新控制器
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  // 展示的用户数据
  List<UserInfo> userList = [];

  @override
  void initState() {
    super.initState();
    _params.pageNum = 1;
    getUserList(_params);
  }

  /// 日期选择
  ///
  /// [context] 上下文
  Future<void> _selectDay(BuildContext context) async {
    final DateTime picked = await showDatePicker(context: context,
      initialDate: _date,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      locale: Locale.fromSubtags(languageCode: 'zh'),
    );
    if (picked != null && picked != _date) {
      // 修改参数
      _params.startDay = DataUtils.instance
          .getStartAnEndDay(date: picked, type: 's');
      _params.endDay = DataUtils.instance
          .getStartAnEndDay(date: picked);
      // 获取数据
      getUserList(_params);
      setState(() {
        _date = picked;
      });
    }
    if (picked == null) _date = DateTime.now();
  }

  // 获取用户数据并且刷新列表
  Future<void> getUserList(SearchFilter params) async {
    List<UserInfo> data = await UserApi.getUserList(params);
    setState(() {
      userList = data;
      _params = _params;
    });
  }

  // 生成一个一个的
  Widget buildUserCard() {
    if (userList.length == 0) return null;
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      padding: EdgeInsets.only(left: 10, right: 10),
      itemBuilder: (c, i) => UserCard(
        userInfo: userList[i],
      ),
      itemCount: userList.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Container(
        color: Colors.black87,
        child: Scaffold(
            backgroundColor: Colors.transparent, //把scaffold的背景色改成透明
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            body: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.white,
                    border: Border.all(color: Colors.white, width: 2.0),
                  ),
                  height: 40.0,
                  padding: EdgeInsets.only(
                      top: 5.0, left: 16.0, right: 16.0),
                  margin:
                  EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
                  child: TextField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.search,
                        color: Colors.black87,
                      ),
                      hintText: '请输入要查询的客户信息',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      contentPadding: EdgeInsets.only(bottom: 2.0),
                      border: InputBorder.none,
                    ),

                    // 获取查找框输入的文本
                    onSubmitted: (s) async {
                      try {
                        _params.pageNum = 1;
                        _params.keyword = s;
                        getUserList(_params);
                        _refreshController.refreshCompleted();
                      } catch (e) {
                        _refreshController.refreshFailed();
                      }
                    },
                  ),
                ),
                Container(
                    width: double.infinity,
                    margin:
                    EdgeInsets.only(left: 10.0, top: 10.0, bottom: 20),
                    child: InkWell(
                      onTap: () {
                        _selectDay(context);
                      },
                      child: RichText(
                          textDirection: TextDirection.ltr,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                  '${EngDate(_date.month, _date.day)
                                      .judgeMonth()}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28.0,)),
                              TextSpan(
                                  text: ', ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,)),
                              TextSpan(
                                  text: '${_date.day}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,)),
                              TextSpan(
                                  text:
                                  ' ${EngDate(_date.month, _date.day)
                                      .judgeDay()}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,)),
                            ],
                          )),
                    )
                ),
                Flexible(
                  child: SmartRefresher(
                    controller: _refreshController,
                    enablePullUp: true,
                    child: buildUserCard(),
                    footer: CustomFooter(
                      builder: (BuildContext context, LoadStatus mode) {
                        Widget body;
                        if (mode == LoadStatus.idle) {
                          body = Text("上拉加载");
                        } else if (mode == LoadStatus.loading) {
                          body = CupertinoActivityIndicator();
                        } else if (mode == LoadStatus.failed) {
                          body = Text("加载失败！点击重试！");
                        } else if (mode == LoadStatus.canLoading) {
                          body = Text("松手,加载更多!");
                        } else {
                          body = Text("没有更多数据了!");
                        }
                        return Container(
                          height: 55.0,
                          child: Center(child: body),
                        );
                      },
                    ),
                    header: WaterDropHeader(),
                    // 刷新
                    onRefresh: () async {
                      //从网络获取数据
                      try {
                        _params.pageNum = 1;
                        getUserList(_params);
                        _refreshController.refreshCompleted();
                      } catch (e) {
                        print(e);
                        _refreshController.refreshFailed();
                      }
                    },
                    // 加载
                    onLoading: () async {
                      //从网络获取数据
                      try {
                        _params.pageNum++;
                        List<UserInfo> date =
                        await UserApi.getUserList(_params);
                        if (date.length == 0) {
                          BotToast.showSimpleNotification(title: "没有数据了");
                          _refreshController.loadNoData();
                        }
                        userList.addAll(date);
                        if (mounted) setState(() {});
                        _refreshController.loadComplete();
                      } catch (e) {
                        _refreshController.loadFailed();
                      }
                    },
                  ),
                )
              ],
            )),
      ),
      onWillPop: () async {
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
          //两次点击间隔超过1秒则重新计时
          _lastPressedAt = DateTime.now();
          BotToast.showText(text: "再按一下退出APP！"); //弹出简单通知Toast
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
