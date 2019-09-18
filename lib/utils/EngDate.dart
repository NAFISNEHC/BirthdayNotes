class EngDate {
  EngDate(this.month, this.day);
  String judgeMonth() {
    if (this.month == 1)
      return 'January';
    else if (this.month == 2)
      return 'February';
    else if (this.month == 3)
      return 'March';
    else if (this.month == 4)
      return 'April';
    else if (this.month == 5)
      return 'May';
    else if (this.month == 6)
      return 'June';
    else if (this.month == 7)
      return 'July';
    else if (this.month == 8)
      return 'August';
    else if (this.month == 9)
      return 'September';
    else if (this.month == 10)
      return 'October';
    else if (this.month == 11)
      return 'November';
    else
      return 'December';
  }

  String judgeDay() {
    if (this.day == 1 || this.day == 21 || this.day == 31)
      return 'st';
    else if (this.day == 2 || this.day == 22)
      return 'nd';
    else if (this.day == 3 || this.day == 23)
      return 'rd';
    else
      return 'th';
  }

  var month;
  var day;
}
