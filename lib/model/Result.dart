class Result<T> {
  int code;
  String msg;
  dynamic result;

  Result({this.code, this.msg, this.result});

  Result.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.result != null) {
      data['result'] = this.result.toString();
    }
    return data;
  }
}
