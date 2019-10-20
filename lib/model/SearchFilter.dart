class SearchFilter {
  int pageNum;
  String keyword;
  String startDay;
  String endDay;

  SearchFilter(this.pageNum, this.keyword, this.startDay, this.endDay);

  Map toMap() {
    Map a = new Map();
    a['pageNum'] = this.pageNum;
    a['keyword'] = this.keyword;
    a['startDay'] = this.startDay;
    a['endDay'] = this.endDay;
    return a;
  }
}
