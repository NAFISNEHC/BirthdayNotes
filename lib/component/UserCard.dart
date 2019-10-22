import 'package:flutter/material.dart';
import 'package:flutter_app/model/UserInfo.dart';
import 'package:flutter_app/utils/JudgeSex.dart';

/// 用户的卡片
class UserCard extends StatelessWidget {
  final UserInfo userInfo;

  UserCard({Key key, @required this.userInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String sendStr = (userInfo.sendSMS == 1) ? '待发送' : '已发送';
    return Card(
      elevation: 5.0, //设置阴影
      color: Colors.white,
      margin: EdgeInsets.only(top: 1.0, bottom: 15.0),
      shape: RoundedRectangleBorder(
        // 圆角
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(JudgeSex(userInfo.sex).judge()),
                    backgroundColor: Colors.white,
                  ),
                  title: Text(
                    userInfo.userName + '（$sendStr）',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    userInfo.phone,
                    style: TextStyle(color: Colors.black87),
                  ),
                )
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.black87),
            onPressed: null,
          )
        ],
      ),
    );
  }
}
