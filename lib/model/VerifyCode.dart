class VerifyCOde {
  String base64;

  VerifyCOde.fromJson(Map<String, dynamic> json) {
    base64 = json['imgbase64'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}
