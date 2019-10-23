import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/Http.dart';
import 'package:fluttertoast/fluttertoast.dart';
import "package:http/http.dart" as http; //导入网络请求相关的包

class PersonalCenterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new PersonalCenterPageState();
  }
}

class PersonalCenterPageState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _PersonalCenterPageState();
  }
}

class _PersonalCenterPageState extends State<PersonalCenterPageState> {
  List data;

//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      body: new ListView(children: data != null ? _getItem(1) : _loading()),
////      body: new ListView(children: _getItem()),
//    );

  final random = Random();
  int dataSet = 0;

  void changeData() {
    setState(() {
      dataSet = random.nextInt(100);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
//        child: Text('Data set :$dataSet'),
        child: CustomPaint(
          size: Size(200.0, 100.0),
          painter: BarChartPainter(dataSet.toDouble()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: changeData,
      ),
    );
  }

  _getItem(int pageIndex) {
    String url =
//        "http://userapi.t.jjw.com/api/UserClickHistory/SelectUserClickHistoryList";
//    url += "?PageIndex=$pageIndex&PageSize=10";
        "http://www.wanandroid.com/project/list/1/json?cid=1";
    Http.get(url).then((res) {
      if (res != null) {
        Map<String, dynamic> map = json.decode(res);
        print("the res is" + map.toString());
//        if (map["code"] == 0) {}
      } else {
        Fluttertoast.showToast(
            msg: "错误了",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            textColor: Color(999999),
            backgroundColor: Color(33000000));
      }
    }).catchError((onError) {
      print('$onError错误');
    });
  }

  //正在加载页面
  _loading() {
    return <Widget>[
      new Container(
        height: 300.0,
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new CircularProgressIndicator(
                strokeWidth: 1.0,
              ),
              new Text("正在加载...")
            ],
          ),
        ),
      )
    ];
  }
}

class BarChartPainter extends CustomPainter {
  static const barWidth = 10.0;
  final double barHeigth;

  BarChartPainter(this.barHeigth);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue[400]
      ..style = PaintingStyle.fill;
    canvas.drawRect(
        Rect.fromLTWH((size.width - barHeigth) / 2.0, size.height - barHeigth,
            barWidth, barHeigth),
        paint);
  }

  @override
  shouldRepaint(BarChartPainter old) => barHeigth != old.barHeigth;
}
