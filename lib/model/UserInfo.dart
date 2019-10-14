class UserInfo {
  String userName;
  int sex;
  String phone;
  bool sendSMS;

  UserInfo({this.userName, this.sex, this.phone, this.sendSMS});

  UserInfo.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    sex = json['sex'];
    phone = json['phone'];
    sendSMS = json['sendSMS'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['sex'] = this.sex;
    data['phone'] = this.phone;
    data['sendSMS'] = this.sendSMS;
    return data;
  }
}