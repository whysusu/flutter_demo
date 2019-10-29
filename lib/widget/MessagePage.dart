import 'package:flutter/material.dart';
import 'package:flutter_demo/net/http_manager.dart';
import "package:http/http.dart" as http; //导入网络请求相关的包
import 'dart:convert';
//import 'dart:io';

class MessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MessagePageState();
  }
}

class MessagePageState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MessagePageState();
  }
}

class _MessagePageState extends State<MessagePageState> {
  //数据源
  List data;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView(children: data != null ? _getItem() : _loading()),

    );
  }

  @override
  void initState() {
    super.initState();
    _pullNet();
  }

  void _pullNet() async {
//    Map<String, String> weatherNowRequestBean = {
//      "location": "武汉",
//      "client": "somemessage",
//      "udid": "dddddddddddddddddddddd",
//      "start": newMovieStart.toString(),
//      "count": "9"
//    };
//    HttpManager.getInstanc().get(
//        "https://api.heweather.net/s6/weather/now?", parameters:)
  }

  List<Widget> _getItem() {
    return data.map((item) {
      return new Card(
        child: new Padding(
          padding: const EdgeInsets.all(10.0),
          child: _getRowWidget(item),
        ),
        elevation: 3.0,
        margin: const EdgeInsets.all(10.0),
      );
    }).toList();
  }

  Widget _getRowWidget(item) {
    return new Row(
      children: <Widget>[
        new Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: new Stack(
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    new Text(
                      "${item["title"]}".trim(),
                      style: new TextStyle(color: Colors.black, fontSize: 20.0),
                      textAlign: TextAlign.left,
                    ),
                    new Text(
                      "${item["desc"]}",
                      maxLines: 3,
                    )
                  ],
                )
              ],
            )),
        new ClipRect(
          child: new FadeInImage.assetNetwork(
            placeholder: "images/ic_shop_normal.png",
            image: "${item['envelopePic']}",
            width: 50.0,
            height: 50.0,
            fit: BoxFit.fitWidth,
          ),
        )
      ],
    );
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
