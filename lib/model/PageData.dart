class PageData<T> {
  List<T> records;
  int total;
  int size;
  int pages;

  PageData({this.records, this.total, this.size, this.pages});

  PageData.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = new List<T>();
      json['records'].forEach((v) {
        records.add(v);
      });
    }
    total = json['total'];
    size = json['size'];
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.records != null) {
      data['records'] = this.records.map((v) => v.toString()).toList();
    }
    data['total'] = this.total;
    data['size'] = this.size;
    data['pages'] = this.pages;
    return data;
  }
}