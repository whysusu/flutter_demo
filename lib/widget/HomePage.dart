import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/list.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    var _tabBar = new _TabBar();
    return _tabBar;
  }
}

class _TabBar extends State<HomePage> {
  TabController _tabController;
  List<Widget> tabs = [
    _renderTab(Icons.apps, "首页"),
    _renderTab(Icons.add_alert, "消息"),
    _renderTab(Icons.account_circle, "我的"),
  ];

  static _renderTab(icon, text) {
    return new Tab(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[new Icon(icon, size: 16.0), new Text(text)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: null,
      body: new TabBarView(
          controller: _tabController,
          children: tabs,
         ),
      bottomNavigationBar: new Material(
      //为了适配主题风格，包一层Material实现风格套用
      color: Colors.black87, //底部导航栏主题颜色,
        child: new TabBar(
          isScrollable: false,
          //TabBar导航标签，底部导航放到Scaffold的bottomNavigationBar中
          controller: _tabController, //配置控制器
          tabs: tabs,
          indicatorColor: Colors.transparent,
          unselectedLabelColor: Colors.white70,
          labelColor: Colors.green,

        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    ///初始化时创建控制器
    ///通过 with SingleTickerProviderStateMixin 实现动画效果。

    _tabController =
        new TabController(vsync: ScrollableState(), length: tabs.length);
  }

  ///整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
