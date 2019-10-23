import 'package:flutter/material.dart';

///支持顶部和顶部的TabBar控件
///配合AutomaticKeepAliveClientMixin可以keep住
class TabBarWidget extends StatefulWidget {
  ///底部模式type
  static const int BOTTOM_TAB = 1;

  ///顶部模式type
  static const int TOP_TAB = 2;

  final int type;

  final List<Widget> tabItems;

  final List<Widget> tabViews;

  final Color backgroundColor;

  final Color indicatorColor;

  final Widget title;

  final Widget drawer;

  final Widget floatingActionButton;

  final TarWidgetControl tarWidgetControl;

  final PageController topPageControl;

  final ValueChanged<int> onPageChanged;

  TabBarWidget({
    Key key,
    this.type,
    this.tabItems,
    this.tabViews,
    this.backgroundColor,
    this.indicatorColor,
    this.title,
    this.drawer,
    this.floatingActionButton,
    this.tarWidgetControl,
    this.topPageControl,
    this.onPageChanged,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    var state = new _TabBarState(
      type,
      tabViews,
      indicatorColor,
      backgroundColor,
      title,
      drawer,
      floatingActionButton,
      tarWidgetControl,
      topPageControl,
      onPageChanged,
    );

    return state;
  }
}

class _TabBarState extends State<TabBarWidget>
    with SingleTickerProviderStateMixin {
  final int _type;

  final List<Widget> _tabViews;

  final Color _indicatorColor;

  final Color _backgroundColor;

  final Widget _title;

  final Widget _drawer;

  final Widget _floatingActionButton;

  final TarWidgetControl _tarWidgetControl;

  final PageController _pageController;

  final ValueChanged<int> _onPageChanged;

  _TabBarState(
    this._type,
    this._tabViews,
    this._indicatorColor,
    this._backgroundColor,
    this._title,
    this._drawer,
    this._floatingActionButton,
    this._tarWidgetControl,
    this._pageController,
    this._onPageChanged,
  ) : super();

  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    if (this._type == TabBarWidget.TOP_TAB) {
      return new Scaffold(
        ///设置悬浮按键，不需要可以不设置
        floatingActionButton: _floatingActionButton,
        persistentFooterButtons:
            _tarWidgetControl == null ? [] : _tarWidgetControl.footerButton,

        ///标题栏
        appBar: new AppBar(
          backgroundColor: _backgroundColor,
          title: _title,
          bottom: new TabBar(
            controller: _tabController,
            tabs: widget.tabItems,
            indicatorColor: _indicatorColor,
          ),
        ),

        body: new PageView(
          ///必须有的控制器，与tabBar的控制器同步
          controller: _pageController,

          ///每一个 tab 对应的页面主体，是一个List<Widget>
          children: _tabViews,

          onPageChanged: (index) {
            ///页面触摸作用滑动回调，用于同步tab选中状态
            _tabController.animateTo(index);
            _onPageChanged?.call(index);
          },
        ),
      );
    }
    return new Scaffold(
      ///设置侧边滑出 drawer，不需要可以不设置
      drawer: _drawer,
      appBar: new AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: _title,
      ),

      body: new TabBarView(controller: _tabController, children: _tabViews),
      bottomNavigationBar: new Material(
        //为了适配主题风格，包一层Material实现风格套用
        color: Theme.of(context).primaryColor,
        child: new TabBar(
          //TabBar导航标签，底部导航放到Scaffold的bottomNavigationBar中
          controller: _tabController, //配置控制器
          tabs: widget.tabItems,
          indicatorColor: _indicatorColor, //tab标签的下划线颜色
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
        new TabController(vsync: this, length: widget.tabItems.length);
  }

  ///整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class TarWidgetControl {
  List<Widget> footerButton = [];
}
