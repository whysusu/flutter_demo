import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/entity/new_movie_entity_entity.dart';
import 'package:flutter_demo/entity/weekly_movie_entity_entity.dart';
import 'package:flutter_demo/net/http_manager.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/taurus_footer.dart';
import 'package:flutter_easyrefresh/taurus_header.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'MovieDetail.dart';

///排行榜页面
class RankingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RankingPageWidget();
  }
}

class RankingPageWidget extends State with SingleTickerProviderStateMixin {
  TabController controller;
  NewMovieEntityEntity newMovieEntity;
  WeeklyMovieEntityEntity weeklyMovieEntity;
  WeeklyMovieEntityEntity usBoxMovieEntity;
  List<String> titles = new List(); //tab集合
  int newMovieStart = 0;
  int weeklyMovieStart = 0;
  int usBoxMovieStart = 0;
  EasyRefreshController refreshController = EasyRefreshController();

  @override
  void initState() {
    // TODO: implement initState
    getRankingList();
    super.initState();
    titles.add("新片榜");
    titles.add("口碑榜");
    titles.add("北美票房榜");
    controller = TabController(length: 3, vsync: this);
    controller.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text(
            "电影排行榜",
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          //标题居中
          centerTitle: true,
          backgroundColor: Colors.cyan,
          //appBar底部的控件，一般房tabBar
          bottom: TabBar(
            controller: controller,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.white,
            labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            unselectedLabelColor: Colors.white70,
            tabs: titles.map((String title) {
              return Tab(text: title);
            }).toList(),
          ),
        ),
        body: TabBarView(
          controller: controller,
          children: <Widget>[
            newMovieRefresh(),
            weeklyMovieStartRefresh(),
            usBoxMovieRefresh(),
          ],
        ));
  }

  Widget usBoxMovieRefresh() {
    if (usBoxMovieEntity != null) {
      return EasyRefresh(
        child: ListView.builder(
            itemCount: usBoxMovieEntity.subjects.length,
            itemBuilder: (BuildContext context, int index) {
              return movieItem(index, 3);
            }),
        header: TaurusHeader(),
        footer: TaurusFooter(),
        onRefresh: () async {
          usBoxMovieStart = 0;
          usMovieRequest();
        },
        onLoad: () async {
          usBoxMovieStart++;
          usMovieRequest();
        },
      );
    } else {
      return loadingWidget();
    }
  }

  Widget weeklyMovieStartRefresh() {
    if (weeklyMovieEntity != null) {
      return EasyRefresh(
        header: TaurusHeader(),
        footer: TaurusFooter(),
        onRefresh: () async {
          weeklyMovieStart = 0;
          weeklyMovieRequest();
        },
        onLoad: () async {
          weeklyMovieStart++;
          weeklyMovieRequest();
        },
        child: ListView.builder(
            itemCount: weeklyMovieEntity.subjects.length,
            itemBuilder: (BuildContext context, int index) {
              return movieItem(index, 2);
            }),
      );
    } else {
      return loadingWidget();
    }
  }

  Widget newMovieRefresh() {
    if (newMovieEntity != null) {
      return EasyRefresh(
        child: ListView.builder(
            itemCount: newMovieEntity.subjects.length,
            itemBuilder: (BuildContext context, int index) {
              return movieItem(index, 1);
            }),
        header: TaurusHeader(),
        footer: TaurusFooter(),
        onRefresh: () async {
          newMovieStart = 0;
          newMovieRequest();
        },
        onLoad: () async {
          newMovieStart++;
          newMovieRequest();
        },
//              enableControlFinishLoad: true,
//              enableControlFinishRefresh: true,
//              controller: refreshController,
      );
    } else {
      return loadingWidget();
    }
  }

  Container loadingWidget() {
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

  ///电影列表
  Widget movieItem(int index, int type) {
    return GestureDetector(
        onTap: () {
          Fluttertoast.showToast(
            msg: "点击了第" + (index + 1).toString() + "个",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            fontSize: 15,
            textColor: Colors.black,
          );

          Navigator.push(context,
              new MaterialPageRoute(builder: (BuildContext context) {
            if (type == 1) {
              return MovieDetail(newMovieEntity.subjects[index].id);
            } else if (type == 2) {
              return MovieDetail(weeklyMovieEntity.subjects[index].subject.id);
            } else {
              return MovieDetail(usBoxMovieEntity.subjects[index].subject.id);
            }
          }));
        },
        child: Container(
          padding: index == 0
              ? EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10)
              : EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            child: Container(
              color: setBgColor(index),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 15, top: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      child: Container(
                        width: 80,
                        height: 30,
                        color: Colors.redAccent,
                        alignment: Alignment.center,
                        child: Text(
                          "No." + (index + 1).toString(),
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Image(
                            width: 140,
                            height: 210,
                            fit: BoxFit.fitHeight,
                            image: setImage(index, type),
                          ),
                        ),
                        Container(
                          width: 165,
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  setMovieTitle(index, type),
                                  softWrap: true,
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              contentInfo(setYear(index, type)),
                              contentInfo(setMovieType(index, type)),
                              contentInfo(setMovieRelease(index, type)),
                              contentInfo(setMovieTime(index, type)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Container contentInfo(String info) {
    return Container(
      padding: EdgeInsets.only(top: 5),
      child: Text(
        info,
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
      ),
    );
  }

  ///评分
  String setRating(int index, int type) {
    if (type == 1) {
      return ""; //newMovieEntity.subjects[index].rating.stars;
    } else if (type == 2) {
      return weeklyMovieEntity.subjects[index].subject.rating.stars;
    } else {
      return usBoxMovieEntity.subjects[index].subject.rating.stars;
    }
  }

  ///设置电影标题
  String setMovieTitle(int index, int type) {
    if (type == 1) {
      return newMovieEntity.subjects[index].title;
    } else if (type == 2) {
      return weeklyMovieEntity.subjects[index].subject.title;
    } else {
      return usBoxMovieEntity.subjects[index].subject.title;
    }
  }

  ///加载图片
  NetworkImage setImage(int index, int type) {
    if (type == 1) {
      return NetworkImage(newMovieEntity.subjects[index].images.large);
    } else if (type == 2) {
      return NetworkImage(
          weeklyMovieEntity.subjects[index].subject.images.large);
    } else {
      return NetworkImage(
          usBoxMovieEntity.subjects[index].subject.images.large);
    }
  }

  ///年份
  String setYear(int index, int type) {
    if (type == 1) {
      return newMovieEntity.subjects[index].year;
    } else if (type == 2) {
      return weeklyMovieEntity.subjects[index].subject.year;
    } else {
      return usBoxMovieEntity.subjects[index].subject.year;
    }
  }

  ///电影类型
  String setMovieType(int index, int type) {
    String movieType = "";
    if (type == 1) {
      for (int i = 0;
          i <= newMovieEntity.subjects[index].genres.length - 1;
          i++) {
        movieType = movieType + newMovieEntity.subjects[index].genres[i] + " ";
      }
    } else if (type == 2) {
      for (int i = 0;
          i <= weeklyMovieEntity.subjects[index].subject.genres.length - 1;
          i++) {
        movieType = movieType +
            weeklyMovieEntity.subjects[index].subject.genres[i] +
            " ";
      }
    } else {
      for (int i = 0;
          i <= usBoxMovieEntity.subjects[index].subject.genres.length - 1;
          i++) {
        movieType = movieType +
            usBoxMovieEntity.subjects[index].subject.genres[i] +
            " ";
      }
    }
    return movieType;
  }

  ///上映时间
  String setMovieRelease(int index, int type) {
    String seleaseStr = "";
    if (type == 1) {
      for (int i = 0;
          i <= newMovieEntity.subjects[index].pubdates.length - 1;
          i++) {
        if (i != newMovieEntity.subjects[index].pubdates.length - 1) {
          seleaseStr =
              seleaseStr + newMovieEntity.subjects[index].pubdates[i] + "\n";
        } else {
          seleaseStr = seleaseStr + newMovieEntity.subjects[index].pubdates[i];
        }
      }
    } else if (type == 2) {
      for (int i = 0;
          i <= weeklyMovieEntity.subjects[index].subject.pubdates.length - 1;
          i++) {
        if (i !=
            weeklyMovieEntity.subjects[index].subject.pubdates.length - 1) {
          seleaseStr = seleaseStr +
              weeklyMovieEntity.subjects[index].subject.pubdates[i] +
              "\n";
        } else {
          seleaseStr = seleaseStr +
              weeklyMovieEntity.subjects[index].subject.pubdates[i];
        }
      }
    } else {
      for (int i = 0;
          i <= usBoxMovieEntity.subjects[index].subject.pubdates.length - 1;
          i++) {
        if (i != usBoxMovieEntity.subjects[index].subject.pubdates.length - 1) {
          seleaseStr = seleaseStr +
              usBoxMovieEntity.subjects[index].subject.pubdates[i] +
              "\n";
        } else {
          seleaseStr =
              seleaseStr + usBoxMovieEntity.subjects[index].subject.pubdates[i];
        }
      }
    }
    return seleaseStr;
  }

  ///时长
  String setMovieTime(int index, int type) {
    String time = "";
    if (type == 1) {
      time = newMovieEntity.subjects[index].durations == null
          ? newMovieEntity.subjects[index].durations[0]
          : "";
    } else if (type == 2) {
      time = weeklyMovieEntity.subjects[index].subject.durations[0];
    } else {
      time = usBoxMovieEntity.subjects[index].subject.durations[0];
    }
    return time;
  }

  ///背景
  Color setBgColor(int index) {
    //随机获取一个背景色
    Random random = Random();
    int pos = random.nextInt(Colors.primaries.length);
    return Colors.primaries[pos];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  void getRankingList() {
    newMovieRequest();

    weeklyMovieRequest();

    usMovieRequest();
  }

  void usMovieRequest() async {
    Map<String, String> usMovieRequestBean = {
      "apikey": "0b2bdeda43b5688921839c8ecb20399b",
      "client": "somemessage",
      "udid": "dddddddddddddddddddddd",
      "start": "0",
      "count": "10"
    };

    //北美票房榜
    HttpManager.getInstanc().get("/v2/movie/us_box",
        parameters: usMovieRequestBean, success: (result) {
      if (mounted) {
        setState(() {
          Map newMovie = json.decode(result.toString());
          if (usBoxMovieStart == 0) {
            usBoxMovieEntity = WeeklyMovieEntityEntity.fromJson(newMovie);
          } else {
            usBoxMovieEntity.subjects
                .addAll(WeeklyMovieEntityEntity.fromJson(newMovie).subjects);
          }
        });
      }
    }, error: (msg) {});
  }

  void weeklyMovieRequest() async {
    Map<String, String> weeklyMovieRequestBean = {
      "apikey": "0b2bdeda43b5688921839c8ecb20399b",
      "client": "somemessage",
      "udid": "dddddddddddddddddddddd",
      "start": "0",
      "count": "10"
    };
    //口碑榜
    HttpManager.getInstanc().get("/v2/movie/weekly",
        parameters: weeklyMovieRequestBean, success: (result) {
      if (mounted) {
        setState(() {
          Map newMovie = json.decode(result.toString());
          if (weeklyMovieStart == 0) {
            weeklyMovieEntity = WeeklyMovieEntityEntity.fromJson(newMovie);
          } else {
            weeklyMovieEntity.subjects
                .addAll(WeeklyMovieEntityEntity.fromJson(newMovie).subjects);
          }
        });
      }
    }, error: (msg) {});
  }

  void newMovieRequest() {
    Map<String, String> newMovieRequestBean = {
      "apikey": "0b2bdeda43b5688921839c8ecb20399b",
      "client": "somemessage",
      "udid": "dddddddddddddddddddddd",
      "start": newMovieStart.toString(),
      "count": "9"
    };

    //新片榜
    HttpManager.getInstanc().get("/v2/movie/new_movies",
        parameters: newMovieRequestBean, success: (result) {
      if (mounted) {
        setState(() {
          Map newMovie = json.decode(result.toString());
          if (newMovieStart == 0) {
            newMovieEntity = NewMovieEntityEntity.fromJson(newMovie);
//          refreshController.finishRefresh(success: true);
          } else {
            newMovieEntity.subjects
                .addAll(NewMovieEntityEntity.fromJson(newMovie).subjects);
//          refreshController.finishRefresh(success: true);
          }
        });
      }
    }, error: (msg) {});
  }
}
