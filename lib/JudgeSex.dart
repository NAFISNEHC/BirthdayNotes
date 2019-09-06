class JudgeSex {
  JudgeSex(this.sex) {}
  String Judge() {
    if (sex == '男')
      return 'images/boy.png';
    else
      return 'images/girl.png';
  }

  String sex;
}
