import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/widget/BoldText.dart';
import 'package:flutter_demo/widget/HomePage.dart';
import 'package:flutter_demo/widget/MainPage.dart';
import 'package:flutter_demo/widget/list.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
//      home: new HomePage(),//使用TabBar实现首页模块切换
        home:new MainPage(),//使用BottomNavigationBar实现模块切换
    );

//  return new Center(
//    child: BoldText("android"),
//  );
  }
}


