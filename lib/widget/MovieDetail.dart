import 'dart:convert';
import 'dart:ui' as prefix0;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix1;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demo/entity/movie_detail_entity.dart';
import 'package:flutter_demo/net/http_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'StillsPage.dart';

///影片信息
// ignore: must_be_immutable
class MovieDetail extends StatefulWidget {
  String movieId;

  MovieDetail(this.movieId);

  @override
  State<StatefulWidget> createState() {
    return new MovieDetailState(movieId);
  }
}

class MovieDetailState extends State<MovieDetail> {
  String id;
  double alpha = 0.0;

  ScrollController controller = ScrollController();

  MovieDetailState(this.id);

  MovieDetailEntity movieDetailEntity;

  @override
  void initState() {
    if (id != null) {
      getDetail(id);
    }
    super.initState();
    controller.addListener(() {
      /// controller.offset为滑动距离
      double value = controller.offset / 180;
      setState(() {
        if (value < 1.0) {
          alpha = value;
        } else {
          alpha = 1.0;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //不加Scaffold背景会变成黑色
    return Scaffold(
        body: new Stack(
      children: <Widget>[
        ScrollList(context),
        titleWidget(context),
      ],
    ));
  }

  ///整体滑动列表
  Widget ScrollList(BuildContext context) {
    if (movieDetailEntity != null) {
      return new ListView(
        padding: EdgeInsets.all(0),
        controller: this.controller,
        children: <Widget>[
          topImage(context),
          new Container(
            padding: EdgeInsets.only(top: 15, left: 15),
            color: Color(0xFF1A253C),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  "简介",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      decorationThickness: 2),
                ),
                new Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    movieDetailEntity.summary.isEmpty
                        ? "暂无简介"
                        : movieDetailEntity.summary,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white70,
                    ),
                  ),
                ),
                baseTitle("导演"),
                movieDetailEntity.directors != null &&
                        movieDetailEntity.directors.length > 0
                    ? new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            width: 75,
                            height: 75,
                            decoration: ShapeDecoration(
                                shape: CircleBorder(side: BorderSide.none),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(movieDetailEntity
                                        .directors[0].avatars.large))),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 5),
                            width: 75,
                            child: Text(
                              movieDetailEntity.directors[0].name,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                  fontSize: 13, color: Colors.white70),
                            ),
                          )
                        ],
                      )
                    : new Text("暂无导演信息",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white70,
                        )),
                baseTitle("编剧"),
                movieDetailEntity.writers != null &&
                        movieDetailEntity.writers.length > 0
                    ? Container(
                        height: 110, //必须要设置高度，不然listView不显示
                        child: ListView.builder(
                            padding: EdgeInsets.only(left: 5),
                            scrollDirection: Axis.horizontal,
                            itemCount: movieDetailEntity.writers.length,
                            itemBuilder: (BuildContext context, int index) {
                              return writersItem(index);
                            }),
                      )
                    : new Text("暂无编剧信息",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white70,
                        )),
                baseTitle("剧照"),
                movieDetailEntity.photos != null &&
                        movieDetailEntity.photos.length > 0
                    ? Container(
                        height: 110, //必须要设置高度，不然listView不显示
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: movieDetailEntity.photos.length,
                            itemBuilder: (BuildContext context, int index) {
                              return photosItem(index);
                            }),
                      )
                    : new Text("暂无剧照信息",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white70,
                        )),
                baseTitle("热评"),
                movieDetailEntity.popularReviews != null &&
                        movieDetailEntity.popularReviews.length > 0
                    ? Container(
                        margin: EdgeInsets.only(right: 15),
                        child: ListView.builder(
                            padding: EdgeInsets.only(top: 15),
                            shrinkWrap: true,
                            physics: new NeverScrollableScrollPhysics(),
                            itemCount: movieDetailEntity.popularReviews.length,
                            itemBuilder: (BuildContext context, int index) {
                              return reviews(index);
                            }),
                      )
                    : new Text("暂无热评信息",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white70,
                        )),
              ],
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

  ///热评列表
  Widget reviews(int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: new ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        child: new Container(
          color: Colors.white10,
          width: MediaQuery.of(context).size.width,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 10),
                    width: 45,
                    height: 45,
                    decoration: ShapeDecoration(
                        shape: CircleBorder(side: BorderSide.none),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(movieDetailEntity
                                .popularReviews[index].author.avatar))),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 10),
//                    color: Colors.cyanAccent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            movieDetailEntity.popularReviews[index].author.name,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: 20,
                                width: 80,
                                child: new ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return new Icon(
                                        Icons.star_border,
                                        color: Colors.redAccent,
                                        size: 15,
                                      );
                                    }),
                              ),
                              Text(
                                "2019-9-17",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white70,
                                    wordSpacing: 2,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),

              ///评论
              Container(
                margin:
                    EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 5),
                child: Text(
                  movieDetailEntity.popularReviews[index].summary,
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                      wordSpacing: 2,
                      fontWeight: FontWeight.w200),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///评分star
//  Icon starItem() {
//    return
//
//  }

  ///顶部标题栏
  Container titleWidget(BuildContext context) {
    return new Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      color: new Color.fromRGBO(26, 37, 60, alpha),
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: EdgeInsets.only(left: 15, bottom: 10),
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
    );
  }

  ///剧照列表
  Widget photosItem(int index) {
    return GestureDetector(
      onTap: () {
        clickPhoto(index);
      },
      child: Container(
        margin: EdgeInsets.only(top: 10, right: 10),
        width: 180,
        height: 110,
        child: Image.network(
          movieDetailEntity.photos[index].image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  ///编剧列表
  Widget writersItem(int index) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10, right: 20),
          width: 75,
          height: 75,
          decoration: ShapeDecoration(
              shape: CircleBorder(side: BorderSide.none),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: (movieDetailEntity.writers[index].avatars != null &&
                          movieDetailEntity.writers[index].avatars.large !=
                              null)
                      ? NetworkImage(
                          movieDetailEntity.writers[index].avatars.large)
                      : AssetImage("personal_icon.png"))),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 5),
          width: 75,
          child: Text(
            movieDetailEntity.writers[index].name,
            softWrap: false,
            overflow: TextOverflow.fade,
            style: TextStyle(fontSize: 13, color: Colors.white70),
          ),
        )
      ],
    );
  }

  ///子标题
  Container baseTitle(String title) {
    return new Container(
      padding: EdgeInsets.only(top: 20),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.underline,
            decorationThickness: 2),
      ),
    );
  }

  /// 顶部图片
  Container topImage(BuildContext context) {
    return new Container(
      height: 280,
      width: MediaQuery.of(context).size.width,
      child: new Stack(
        children: <Widget>[
          new Container(
            height: 280,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              movieDetailEntity.images.large,
              fit: BoxFit.fitWidth,
            ),
          ),

          //添加模糊层
          new BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 280,
                  color: Colors.white10,
                  child: Stack(
                    children: <Widget>[
                      new Center(
                        child: Image.network(
                          movieDetailEntity.images.large,
                          fit: BoxFit.scaleDown,
                          width: 140,
                          height: 210,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          bottom: 5,
                        ),
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          movieDetailEntity.title,
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  )))
        ],
      ),
    );
  }

  void getDetail(movieId) {
    Map<String, String> detailData = {
      "apikey": "0b2bdeda43b5688921839c8ecb20399b",
      "client": "somemessage",
      "udid": "dddddddddddddddddddddd"
    };

    HttpManager.getInstanc().get(
      "/v2/movie/subject/" + movieId,
      parameters: detailData,
      success: (result) {
        setState(() {
          Map movieDetail = json.decode(result.toString());
          movieDetailEntity = MovieDetailEntity.fromJson(movieDetail);
        });
      },
      error: (errorMsg) {
        Fluttertoast.showToast(
          msg: errorMsg,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          fontSize: 15,
          textColor: Colors.black,
        );
      },
    );
  }

  ///点击剧照
  clickPhoto(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                new StillsPage(index, id, movieDetailEntity.photosCount)));
  }
}
