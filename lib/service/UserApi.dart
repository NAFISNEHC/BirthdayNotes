import 'dart:convert';

import 'package:flutter_app/model/UserInfo.dart';
import 'package:flutter_app/utils/HttpUtils.dart';

class UserApi {
  static getUserList(params) async {
    var userListJson = await HttpUtils.request(
        "/api/user/list",
        method: HttpUtils.POST,
        data: params
    );
    List<UserInfo> userList = new List<UserInfo>.from(userListJson.map((item) => new UserInfo.fromJson(item)).toList());
    return userList;
  }

  static getUserInfo(userId) async {
    var data = await HttpUtils.request(
      "/api/user/info",
      method: HttpUtils.POST,
      data: { userId: userId }
    );
    return new UserInfo.fromJson(data);
  }
}
