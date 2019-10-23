import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demo/entity/movie_entity.dart';
import 'package:flutter_demo/entity/new_movie_entity_entity.dart';
import 'package:flutter_demo/net/http_manager.dart';
import 'package:flutter_demo/widget/MovieDetail.dart';
import 'package:flutter_demo/widget/menu_bean_entity.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'RankingPage.dart';



///首页
class HomeTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new HomeTabPageState();
  }
}

class HomeTabPageState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomeTabPageState();
  }
}

class _HomeTabPageState extends State<HomeTabPageState> {
  List<ManuBeanDataNavmanu> menuBeanList = [];

  MovieEntity hitMovieEntity;
  MovieEntity comingSoonEntity;
  NewMovieEntityEntity newMovieEntity;

  List<MovieSubject> picList;
  List<MovieSubject> comingSoonList;
  List<NewMovieEntitySubject> newMovieList;

  @override
  void initState() {
    getMenu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    if (hitMovieEntity != null) {
      picList = hitMovieEntity.subjects;
    }

    if (comingSoonEntity != null) {
      comingSoonList = comingSoonEntity.subjects;
    }

    if (newMovieEntity != null) {
      newMovieList = newMovieEntity.subjects;
    }
    //ListView类似安卓中的scrollview
    return new ListView(
      padding: EdgeInsets.all(0),
      children: <Widget>[
        buildContainer(controller),
        banner(picList),
        movieTitle("影院热映"),
        hotMovie(picList),
        movieTitle("即将上映"),
        hotMovie(comingSoonList),
        weeklyTitle("电影榜单"),
        rankingList(newMovieList),
      ],
    );
  }

  Container weeklyTitle(String title) {
    return new Container(
      padding: EdgeInsets.only(top: 15, left: 10),
      child: Text(
        title,
        style: new TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  //热门城市标题
  Row movieTitle(String title) {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new Expanded(

          child: new Container(
            padding: EdgeInsets.only(top: 15, left: 10),
            child: new Text(
              title,
              //是否自动换行 false文字不考虑容器大小  单行显示   超出；屏幕部分将默认截断处理
              softWrap: false,
              //文字超出屏幕之后的处理方式  TextOverflow.clip剪裁   TextOverflow.fade 渐隐  TextOverflow.ellipsis省略号
              overflow: TextOverflow.fade,
              style: new TextStyle(
                //文字大小
                fontSize: 20,
                //字体粗细
                fontWeight: FontWeight.bold,
//                      //文字装饰：//none无文字装饰   lineThrough删除线   overline文字上面显示线    underline文字下面显示线
//                      decoration: TextDecoration.underline,
//                      //文字装饰的风格  dashed,dotted虚线(简短间隔大小区分)  double三条线  solid两条线
//                      decorationStyle: TextDecorationStyle.dashed
              ),
            ),
          ),
        ),
        new Container(
          margin: EdgeInsets.only(top: 10, right: 5),
          child: new Text(
            "更多",
            style: new TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        new Container(
          margin: EdgeInsets.only(right: 10, top: 10, bottom: 3),
          child: Image.asset(
            'images/iv_right.png',
            width: 10,
            height: 10,
          ),
        )
      ],
    );
  }

  ///热门电影 及即将上映影片
  Widget hotMovie(List<MovieSubject> picList) {
    if (picList != null && picList.length > 0) {
      return new Container(
        child: new GridView.builder(
            padding:
            new EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 20),
            //屏蔽GridView内部滚动；
            physics: new NeverScrollableScrollPhysics(),
            itemCount: picList.length > 6 ? 6 : picList.length,
            //必须加这个属性，不然GridView不显示
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //横轴元素个数
                crossAxisCount: 3,
                //纵轴间距
                mainAxisSpacing: 15,
                //横轴间距
                crossAxisSpacing: 5,
                //子组件宽高长度比例
                childAspectRatio: 0.47),
            itemBuilder: (BuildContext context, int indext) {
              return getHotMovie(picList[indext], indext);
            }),
      );
    }
  }

  /// banner
  Widget banner(List<MovieSubject> picList) {
    if (picList != null && picList.length > 0) {
      return new Container(
        margin: EdgeInsets.only(top: 10),
        height: 220,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Swiper(
          itemCount: picList.length > 6 ? 6 : picList.length,
          //自动播放延迟时间
          autoplayDelay: 3000,
          //播放动画时间
          duration: 1000,
          //图片
          itemBuilder: (BuildContext context, int index) {
            return Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(picList[index].images.large),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(6))));
          },
          //指示器
          pagination: new SwiperPagination(),
          //是否自动播放
          autoplay: true,
          //是否循环
          loop: true,
          // 两张图片之间的间隔
          scale: 0.7,
          // 当前视窗展示比例 小于1可见上一个和下一个视窗
          viewportFraction: 0.42,
          onTap: (index) {
            //点击事件
            Fluttertoast.showToast(
              msg: "第" + (index + 1).toString() + "个",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              fontSize: 15,
              textColor: Colors.black,
            );
          },
        ),
      );
    }
  }

  /// 搜索栏
  Widget buildContainer(TextEditingController controller) {
    return new Container(
        child: new Card(
          child: new Padding(
              padding:
              new EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 15),
              child: new Row(
                children: <Widget>[
                  new Text(
                    "武汉",
                    style: new TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  new Container(
                    width: 1,
                    height: 13,
                    color: Colors.black12,
                    margin: new EdgeInsets.only(left: 10, right: 10),
                  ),
                  new Image.asset(
                    "images/img_search_tag.png",
                    width: 15,
                    height: 15,
                  ),
                  new Expanded(
                    child: new TextField(
                      controller: controller,
                      style: new TextStyle(fontSize: 16, color: Colors.black),
                      maxLines: 1,
                      autofocus: false,
                      //是否自动获取焦点
                      decoration: new InputDecoration(
                          hintText: "热门电影搜索",
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.fromLTRB(
                              10, 0, 10, 0)), //若不设置，输入框有默认的padding
                    ),
                  ),
                ],
              )),
          margin: EdgeInsets.fromLTRB(15.0, 35, 15.0, 0.0),
          elevation: 3.0,
        ));
  }

  ///热映影片
  Widget getHotMovie(MovieSubject movieSubject, int indext) {
    return new GestureDetector(
      onTap: () {
        Fluttertoast.showToast(
          msg: "点击了第" + (indext + 1).toString() + "个",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          fontSize: 15,
          textColor: Colors.black,
        );

        Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => new MovieDetail(movieSubject.id)));
      },
      child: Container(
//      color: Colors.redAccent
        child: new Column(
          //子空间对齐方式
          crossAxisAlignment: CrossAxisAlignment.start,
          //子控件间距
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new FadeInImage.assetNetwork(
              placeholder: 'image/esf_menu.png',
              image: movieSubject.images.large,
              fit: BoxFit.cover,
              width: 240,
              height: 190,
            ),
            new Text(
              movieSubject.title,
              //是否自动换行 false文字不考虑容器大小  单行显示   超出；屏幕部分将默认截断处理
              softWrap: false,
              //文字超出屏幕之后的处理方式  TextOverflow.clip剪裁   TextOverflow.fade 渐隐  TextOverflow.ellipsis省略号
              overflow: TextOverflow.fade,
              style: new TextStyle(fontSize: 15, color: Colors.black),
            ),
            new Row(
              children: <Widget>[
                new Icon(
                  Icons.star_border,
                  color: Colors.redAccent,
                  size: 15,
                ),
                new Icon(
                  Icons.star_border,
                  color: Colors.redAccent,
                  size: 15,
                ),
                new Icon(
                  Icons.star_border,
                  color: Colors.redAccent,
                  size: 15,
                ),
                new Icon(
                  Icons.star_border,
                  color: Colors.redAccent,
                  size: 15,
                ),
                new Icon(
                  Icons.star_border,
                  color: Colors.redAccent,
                  size: 15,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  ///电影榜单
  Widget rankingList(List<NewMovieEntitySubject> weeklyList) {
    if (weeklyList != null && weeklyList.length > 0) {
      return new Container(
        margin: EdgeInsets.only(top: 10),
        height: 200,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Swiper(
          itemCount: weeklyList.length,
          autoplay: false,
          loop: true,
          scale: 0.95,
          viewportFraction: 0.9,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (BuildContext context){
                      return new RankingPage();
                    }));
              },
              child: new Stack(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(weeklyList[index].images.large),
                            fit: BoxFit.fitWidth,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(6)))),
                  Positioned(
                    top: 40,
                    left: 30,
                    child: Text(weeklyList[index].title,
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Positioned(
                    top: 80,
                    left: 30,
                    child: Text(weeklyList[index].genres[0],
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  Positioned(
                    top: 115,
                    left: 30,
                    child: Text("上映日期：" + weeklyList[index].pubdates[0],
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
  }

  ///获取热映电源
  void getMenu() async {
//    Fluttertoast.showToast(
//      msg: "请求接口",
//      toastLength: Toast.LENGTH_LONG,
//      gravity: ToastGravity.BOTTOM,
//      fontSize: 15,
//      textColor: Colors.black,
//    );
    Map<String, String> hotData = {
      "apikey": "0b2bdeda43b5688921839c8ecb20399b",
      "city": "武汉",
      "start": "0",
      "count": "6",
      "client": "somemessage",
      "udid": "dddddddddddddddddddddd"
    };

    //影院热映
    HttpManager().get("/v2/movie/in_theaters", parameters: hotData,
        success: (result) {
          setState(() {
            Map movieBean = json.decode(result);
            hitMovieEntity = MovieEntity.fromJson(movieBean);
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

    Map<String, String> comingSoonData = {
      "apikey": "0b2bdeda43b5688921839c8ecb20399b",
      "start": "0",
      "count": "6",
      "client": "somemessage",
      "udid": "dddddddddddddddddddddd"
    };

    //即将上映
    HttpManager().get("/v2/movie/coming_soon", parameters: comingSoonData,
        success: (result) {
          setState(() {
            Map movieBean = json.decode(result);
            comingSoonEntity = MovieEntity.fromJson(movieBean);
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

    Map<String, String> weeklyData = {
      "apikey": "0b2bdeda43b5688921839c8ecb20399b",
      "client": "somemessage",
      "udid": "dddddddddddddddddddddd"
    };

    //影院热映
    HttpManager().get("/v2/movie/new_movies", parameters: weeklyData,
        success: (result) {
          setState(() {
            Map movieBean = json.decode(result);
            newMovieEntity = NewMovieEntityEntity.fromJson(movieBean);
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
}
