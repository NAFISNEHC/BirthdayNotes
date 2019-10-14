class JudgeSex {

  int sex;

  JudgeSex(this.sex);
  String judge() {
    if (sex == 1)
      return 'images/boy.png';
    else
      return 'images/girl.png';
  }

}
