class UserInfo {
  String name;
  String sex;
  String phone;
  String img;
  bool sendSMS;

  UserInfo({this.name, this.sex, this.phone, this.img, this.sendSMS});

  UserInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    sex = json['sex'];
    phone = json['phone'];
    img = json['img'];
    sendSMS = json['sendSMS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['sex'] = this.sex;
    data['phone'] = this.phone;
    data['img'] = this.img;
    data['sendSMS'] = this.sendSMS;
    return data;
  }
}