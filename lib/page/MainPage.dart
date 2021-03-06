import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String devId;

  @override
  void initState() {
    super.initState();
    getDevId();
  }

  // 获取设备信息
  getDevId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.androidId}');
    setState(() {
      devId = androidInfo.androidId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent, //把scaffold的背景色改成透明
        appBar: null,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Container(
              margin: EdgeInsets.only(top: 60.0),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new AssetImage('images/logo2.png')),
              ),
              height: 180.0,
            ),
            new Container(
              margin: EdgeInsets.only(
                top: 20.0,
              ),
              child: new Text(
                'Birthday Notes',
                style: TextStyle(color: Colors.black87, fontSize: 30.0),
                textAlign: TextAlign.center,
              ),
              width: 300.0,
            ),
            new Container(
              margin: EdgeInsets.only(
                top: 60.0,
              ),
              child: new Text(
                'Each birthday is a milestone we touch along life' +
                    '\'s way.\nAffectionate birthday greetings!' +
                    '\n设备唯一码为\n$devId\n(提交此设备码给管理进行授权访问)',
                style: TextStyle(color: Colors.black87, fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
              width: 300.0,
            ),
            new Container(
                margin: EdgeInsets.only(
                  top: 10.0,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding:
                            EdgeInsets.only(top: 50.0, left: 27.0, right: 20.0),
                        height: 120,
                        child: RaisedButton(
                          child: Text(
                            "开始使用",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.red[200],
                          onPressed: () =>
                              Navigator.pushNamed(context, 'user_list'),
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
