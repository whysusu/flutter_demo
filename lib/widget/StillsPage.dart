import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demo/entity/photos_entity.dart';
import 'package:flutter_demo/net/http_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';

///剧照页面
// ignore: must_be_immutable
class StillsPage extends StatefulWidget {
  int index;
  String id;
  int photosCount;

  StillsPage(this.index, this.id, this.photosCount);

  @override
  State<StatefulWidget> createState() {
    return StillsPageState(index, id, photosCount);
  }
}

class StillsPageState extends State<StillsPage> {
  int index;
  String id;
  int photosCount;

  int currentIndex = 0;

  StillsPageState(this.index, this.id, this.photosCount);

  PhotosEntity photoBean;

  @override
  void initState() {
    super.initState();
    getStills();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF1A253C), body: photoPageView(context));
  }

  Widget photoPageView(BuildContext context) {
    if (photoBean != null) {
      return new Stack(
        children: <Widget>[
          PageView.builder(
              pageSnapping: true,
              itemCount: photoBean.total,
              scrollDirection: Axis.horizontal,
              onPageChanged: (currentIndex) {
                //页面状态改变监听
                setState(() {
                  this.currentIndex = currentIndex;
                });
              },
              controller: PageController(
                  initialPage:1, keepPage: true, viewportFraction: 1.0),
              itemBuilder: (BuildContext context, int index) {
                return photosItem(index);
              }),
          Positioned(
              top: MediaQuery.of(context).size.height - 50,
              left: MediaQuery.of(context).size.width / 2 - 25,
              width: 50,
              height: 30,
              child: Container(
                alignment: Alignment.center,
                color: Colors.redAccent,
                child: Text(
                  (currentIndex + 1).toString() +
                      "/" +
                      photoBean.total.toString(),
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              )),
          Container(
            child: Container(
              margin: EdgeInsets.only(left: 15, top: 40),
              child: new GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: new Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          )
        ],
      );
    } else {
      return new Container(
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
      );
    }
  }

  void getStills() {
    Map<String, String> stillsParameter = {
      "apikey": "0b2bdeda43b5688921839c8ecb20399b",
      "client": "somemessage",
      "udid": "dddddddddddddddddddddd",
      "count": (photosCount).toString(),
      "start": "0"
    };
    HttpManager.getInstanc().get("/v2/movie/subject/" + id + "/photos",
        parameters: stillsParameter, success: (result) {
      setState(() {
        Map photos = json.decode(result.toString());
        photoBean = PhotosEntity.fromJson(photos);
      });
    }, error: (errorMsg) {
      Fluttertoast.showToast(
        msg: errorMsg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 15,
        textColor: Colors.black,
      );
    });
  }

  Widget photosItem(int index) {
    return new Center(
      child: Image.network(
        photoBean.photos[index].image,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
