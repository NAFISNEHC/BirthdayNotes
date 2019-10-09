import 'package:flutter/material.dart';
import 'package:flutter_app/component/UserCard.dart';
import 'package:flutter_app/model/UserInfo.dart';

class UserListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _UserListPage();
}

class _UserListPage extends State<UserListPage> {
  List<UserInfo> list = new List(); //列表要展示的数据
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    getData();
    _scrollController.addListener(() {
      print("滑动pixels：" + _scrollController.position.pixels.toString());
      print("滑动maxScrollExtent：" +
          _scrollController.position.maxScrollExtent.toString());
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  /// 初始化list数据 加延时模仿网络请求
  Future getData() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        list = List.generate(
            15,
            (i) => UserInfo(
                name: '张三$i', sex: '男', phone: '17600666233', sendSMS: false));
      });
    });
  }

  // 加载更多
  Future _getMoreData() async {
    print("开始加载更多");
    await Future.delayed(Duration(seconds: 3), () {
      list.addAll(List.generate(
          15,
          (i) => UserInfo(
              name: '张三$i', sex: '男', phone: '17600666233', sendSMS: false)));
      setState(() {
        list = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.builder(
          itemBuilder: _renderRow,
          itemCount: list.length,
          controller: _scrollController,
        ),
      ),
    );
  }

  Widget _renderRow(BuildContext context, int index) {
    // 在每一列之前，添加一个1像素高的分隔线widget
    if (index.isOdd) return new Divider();
    // 最后一条数据
    if (index == list.length - 1) {
      return _buildLoadMore();
    } else {
      return UserCard(
        userInfo: list[index],
      );
    }
  }

  /// 下拉刷新方法,为list重新赋值
  Future<Null> _onRefresh() async {
    await Future.delayed(Duration(seconds: 3), () {
      print('refresh');
      setState(() {
        list = List.generate(
            15,
            (i) => UserInfo(
                name: '张三$i', sex: '男', phone: '17600666233', sendSMS: false));
      });
    });
  }

  // 加载更多
  Widget _buildLoadMore() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          // 转圈加载中
          child: CircularProgressIndicator(),
        ),
      ),
      color: Colors.white70,
    );
  }
}
