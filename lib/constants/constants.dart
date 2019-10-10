// 用来保存一些 经常用到的常量
abstract class AppColors {
  // 应用的主题相关
  static const APP_THEME = 0xff63ca6c;
  static const APPBAR = 0xffffffff;
}

// 应用 信息
abstract class AppInfo {
  static const String CLIENT_ID = '9CMQgngfBgrL9BolOi8m';
  static const String CLIENT_SECRET = 'klItiBFGXKpSp4cDzCAhoOTa2ULdjkvQ';
  static const String REDIRECT_URI = 'https://www.dongnaoedu.com';
}

// 接口信息
abstract class AppUrls {
  // host
  static const String HOST = 'https://www.oschina.net';

  // 授权登录
  static const String OAUTH2_AUTHORIZE = HOST + '/action/oauth2/authorize';
  static const String OAUTH2_TOKEN = HOST + '/action/openapi/token';

  // 用户信息
  static const String OPENAPI_USER = HOST + '/action/openapi/user';

  // 我的资料
  static const String MY_INFORMATION = HOST + '/action/openapi/my_information';

  // 私信列表
  static const String MESSAGE_LIST = HOST + '/action/openapi/message_list';
}
