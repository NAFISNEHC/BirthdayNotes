import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  String _username;
  String _password;

  void _login() {
    var _loginForm = _loginKey.currentState;
    if (_loginForm.validate()) {
      _loginForm.save();
      print('name: $_username; password: $_password');
      Navigator.pushNamed(context, 'home_page');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("登录"),
        ),
        body: Center(
          child: Container(
            color: Colors.blue[50],
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 40.0),
                      child: ClipOval(
                        child: FadeInImage.assetNetwork(
                          placeholder: "images/boy.png", //预览图
                          fit: BoxFit.fitWidth,
                          image:
                              "http://image.biaobaiju.com/uploads/20180802/01/1533142807-qciIlawNZp.jpg",
                          width: 60.0,
                          height: 60.0,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.only(top: 50),
                      padding: EdgeInsets.all(10),
                      child: Form(
                        key: _loginKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: '请输入用户名',
                                hintText: 'Eason',
                                labelStyle: TextStyle(fontSize: 20.0),
                              ),
                              onSaved: (value) {
                                _username = value;
                                print('onSaved: $value');
                              },
                              onFieldSubmitted: (value) {
                                print('onFieldSubmitted: $value');
                              },
                              validator: (value) =>
                                  value == '' ? '用户名不能为空' : null,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: '请输入密码',
                                hintText: '123456',
                                labelStyle: TextStyle(fontSize: 20.0),
                              ),
                              onSaved: (value) {
                                _password = value;
                              },
                              onFieldSubmitted: (value) {},
                              validator: (value) {
                                return value.length > 6 || value.length < 2
                                    ? '密码长度不能小于2或者大于6'
                                    : null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 250.0,
                      padding: EdgeInsets.only(top: 40.0),
                      child: RaisedButton(
                        child: Text('登录'),
                        onPressed: _login,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
