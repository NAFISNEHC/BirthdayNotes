import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/component/Item.dart';
import 'package:flutter_app/component/UserCard.dart';
import 'package:flutter_app/model/UserInfo.dart';
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

  final title = 'Longevity star';
  var today = DateTime.now();
  var month = DateTime.now().month;
  var day = DateTime.now().day;
  bool flag = false;
  String str = "";

  RefreshController _refreshController = RefreshController(initialRefresh: false);
  List<UserInfo> userList = [];

  @override
  void initState() {
    super.initState();
    getUserList(null).then((data){
      userList = data;
      setState(() { });
    });
  }

  Future<List<UserInfo>> getUserList(params) async{
    List<UserInfo> userList = await UserApi.getUserList(params);
    return userList;
  }

  // 生成一个一个的
  Widget buildUserCard() {
    if(userList.length == 0) return null;
    return ListView.separated(
      physics: ClampingScrollPhysics(),
      padding: EdgeInsets.only(left: 5, right: 5),
      itemBuilder: (c, i) => UserCard(
        userInfo: userList[i],
      ),
      separatorBuilder: (context, index) {
        return Container(
          height: 0.5,
          color: Colors.greenAccent,
        );
      },
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
          body: Builder(
            builder: (BuildContext context){
              return Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.white,
                      border: Border.all(color: Colors.white, width: 2.0),
                    ),
                    height: 40.0,
                    padding: EdgeInsets.only(top: 5.0, left: 16.0, right: 16.0),
                    margin: EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
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
                      onSubmitted: (s) async{
                        try{
                          if(s == "") {
                            List<UserInfo> userData = await UserApi.getUserList(null);
                            userList = userData;
                          }
                          for(var i = 0; i < userList.length; ++i) {
                            if(s != "" && userList[i].name != s && userList[i].phone != s) {
                              userList.elementAt(i--);
                              userList.length--;
                            }
                          }
                          if(s != ""){
                            flag = true;
                          }
                          else{
                            flag = false;
                          }
                          str = s;
                          if (mounted) setState(() {});
                          _refreshController.refreshCompleted();
                        }catch(e){
                          _refreshController.refreshFailed();
                        }
                      },
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 20.0, top: 10.0),
                        child: Text.rich(TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                '${EngDate(this.month, this.day).judgeMonth()}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28.0,
                                    decoration: TextDecoration.none)),
                            TextSpan(
                                text: ', ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    decoration: TextDecoration.none)),
                            TextSpan(
                                text: '${this.day}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    decoration: TextDecoration.none)),
                            TextSpan(
                                text:
                                ' ${EngDate(this.month, this.day).judgeDay()}',
                                style: TextStyle(
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
                      child: buildUserCard(),
                      footer: CustomFooter(
                        builder: (BuildContext context,LoadStatus mode){
                          Widget body ;
                          if(mode==LoadStatus.idle){
                            body =  Text("上拉加载");
                          }
                          else if(mode==LoadStatus.loading){
                            body =  CupertinoActivityIndicator();
                          }
                          else if(mode == LoadStatus.failed){
                            body = Text("加载失败！点击重试！");
                          }
                          else if(mode == LoadStatus.canLoading){
                            body = Text("松手,加载更多!");
                          }
                          else{
                            body = Text("没有更多数据了!");
                          }
                          return Container(
                            height: 55.0,
                            child: Center(child:body),
                          );
                        },
                      ),
                      header: WaterDropHeader(),
                      // 刷新
                      onRefresh: () async {
                        //从网络获取数据
                        try{
                          if(!flag) {
                            List<UserInfo> userData = await UserApi.getUserList(
                                null);
                            userList = userData;
                          }
                          if (mounted) setState(() {});
                            _refreshController.refreshCompleted();
                        }catch(e){
                          _refreshController.refreshFailed();
                        }
                      },
                      // 加载
                      onLoading: () async {
                        //从网络获取数据
                        try{
                          List<UserInfo> date = await UserApi.getUserList(null);
                          if(flag) {
                            for(var i = 0; i < date.length; ++i) {
                              print(date[i].name);
                              if(date[i].name != str && date[i].phone != str) {
                                date.elementAt(i--);
                                date.length--;
                              }
                            }
                          }
                          if(date.length == 0) {
                            _refreshController.loadNoData();
                          }
                          userList.addAll(date);
                          if (mounted) setState(() { });
                          _refreshController.loadComplete();
                        }catch(e){
                          _refreshController.loadFailed();
                        }
                      },
                    ),
                  ),
                ],
              );
            },
          )
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