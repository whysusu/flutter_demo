import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/HomeTabPage.dart';
import 'package:flutter_demo/widget/MessagePage.dart';
import 'package:flutter_demo/widget/PersonalCenterPage.dart';

class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: true,
      home: new MainPageWidget(),
    );
  }
}

class MainPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MainPageState();
  }
}

class MainPageState extends State<MainPageWidget> with AutomaticKeepAliveClientMixin{
  int tabIndex = 0;
  var tabImage;
  var tabTitle = ['首页', '消息', '我的'];
  var bodys;

  /*
   * 根据索引获得对应的normal或是press的icon
   */
  Image getTabImage(path) {
    return new Image.asset(path, width: 20.0, height: 20.0);
  }

  /*
   * 根据索引获得对应的normal或是press的icon
   */
  Image getTabIcon(int curIndex) {
    if (curIndex == tabIndex) {
      return tabImage[curIndex][0];
    }
    return tabImage[curIndex][1];
  }

  /*
   * 获取bottomTab的颜色和文字
   */
  Text getTabTitle(int curIndex) {
    if (curIndex == tabIndex) {
      return new Text(tabTitle[curIndex],
          style: new TextStyle(color: const Color(0xff5CA52A)));
    } else {
      return new Text(tabTitle[curIndex],
          style: new TextStyle(color: const Color(0xff888888)));
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    initData();
    return new Scaffold(
      body: bodys[tabIndex],
      bottomNavigationBar: new BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
              icon: getTabIcon(0), title: getTabTitle(0)),
          new BottomNavigationBarItem(
              icon: getTabIcon(1), title: getTabTitle(1)),
          new BottomNavigationBarItem(
              icon: getTabIcon(2), title: getTabTitle(2)),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: tabIndex,
        onTap: (index) {
          setState(() {
            tabIndex = index;
          });
        },
      ),
    );
  }

  void initData() {
    tabImage = [
      [
        //首页
        getTabImage('images/img_bottom_index_select_v2.png'),
        getTabImage('images/img_bottom_index_v2.png')
      ],
      [
        //消息
        getTabImage('images/img_bottom_mess_select_v2.png'),
        getTabImage('images/img_bottom_mess_v2.png')
      ],
      [
        //我的
        getTabImage('images/img_bottom_my_select_v2.png'),
        getTabImage('images/img_bottom_my_v2.png')
      ]
    ];

    bodys = [new HomeTabPage(), new MessagePage(), new PersonalCenterPage()];
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
