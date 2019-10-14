import 'dart:convert';

import 'package:flutter_app/model/PageData.dart';
import 'package:flutter_app/model/UserInfo.dart';
import 'package:flutter_app/utils/HttpUtils.dart';

class UserApi {
  static getUserList(params) async {
    var pageData = await HttpUtils.request(
        "/api/user/list",
        method: HttpUtils.POST,
        data: params,
        headers: {"content-type" : "application/json"}
    );
    PageData pageData2 = PageData.fromJson(pageData);
    List<UserInfo> userList = new List<UserInfo>.from(pageData2.records.map((item) => new UserInfo.fromJson(item)).toList());
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
