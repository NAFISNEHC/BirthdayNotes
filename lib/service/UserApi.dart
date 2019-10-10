import 'package:flutter_app/utils/HttpRequest.dart';

class UserApi {
  // 获取用户列表数据，这里要带上async哦
  static getUserList(params) async {
    return HttpRequest.post("http://47.110.46.62:3000/mock/40/regSys/api/user/list", );
  }
}
