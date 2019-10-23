import 'dart:collection';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/entity/movie_entity.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:crypto/crypto.dart';

class HttpManager {
  static HttpManager instanc;
  Dio dio;
  BaseOptions baseOptions;

  static HttpManager getInstanc() {
    if (null == instanc) {
      instanc = new HttpManager();
    }
    return instanc;
  }

  HttpManager() {
    var random = randomNum();
    var now = new DateTime.now();
    String owinTs =
        ("" + now.millisecondsSinceEpoch.toString()).substring(0, 10);
    baseOptions = new BaseOptions(
      baseUrl: "https://api.douban.com/",
      connectTimeout: 10000,
      receiveTimeout: 10000,
//        headers: {
//          "Owin-RequestT": "android",
//          "Owin-Uid": "867140032456374",
//          "Owin-Rand": random,
////          "Owin-Sign": "7b97f404d466c8ca9a76d035e9d9d184",
//          "Owin-Sign": getSign(random, owinTs, "867140032456374",
//              "0842938C961647768B05FE3ED9E31CD5"),
//          "Owin-Ts": owinTs,
//          "Owin-MAC": "54:b1:21:9f:39:65",
//          "Owin-AppVersion": "2.6.0.10",
//          "Owin-City": "1",
//          "Owin-Version": "V1",
////          "Cookie":
////              "jjdc=jjui=PtndN9RFgcI=&jjcc=uw8DiP/8HOnlAjXEh9Z39ZInL8oHUI7a1D1VBNRe3APEjwXvIObzWQ==&jjmb=vYIN0Fj3ubWxgEoqFz8WQQ==&jjun=Bl3HJVqLnlI=; domain=.jjw.com; expires=Wed, 05-Sep-2029 02:04:32 GMT; path=/",
//          "User-Agent":
//              "Mozilla/5.0 (Linux; U; Android 9; zh-cn; VKY-AL00 Build/HUAWEIVKY-AL00) AppleWebKit/533.1 (KHTML, like Gecko) Version/5.0 Mobile Safari/533.1",
//          "Cache-Control": "no-cache",
//          "Connection":"Keep-Alive",
//          "Accept-Language":"zh-CN,zh;q=0.8"
//        },
      responseType: ResponseType.json,
//        contentType: ContentType.parse("application/x-www-form-urlencoded")
    );

    dio = new Dio(baseOptions);

    //必须才能抓到接口
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.findProxy = (Uri) {
        // 用1个开关设置是否开启代理
        return 'PROXY 192.168.1.43:8888';
      };
      //校验证书
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
//        if(cert.pem==PEM){
//          return true; //证书一致，则允许发送数据
//        }
        return true;
      };
    };
  }

  get(url, {parameters, Function success, Function error}) async {
    Response response;

    try {
      response = await dio.get(url, queryParameters: parameters);

      if (success != null) {
        success(response.toString());
      } else {
        if (error != null) {
          error("错误了！");
        }
      }

//      print("cx-- dio -subjectList" + subjectList);
    } on DioError catch (e) {
      formatError(error, e);
    }
  }

  post(url, {data, Function success, Function error}) async {
    Response response;
    try {
      response = await dio.post(url, queryParameters: data);
      if (success != null) {
        success(response.toString());
      } else {
        if (error != null) {
          error("错误了！");
        }
      }
    } on DioError catch (e) {
      formatError(error, e);
    }
  }

  /*
   * error统一处理
   */
  void formatError(Function errorCallback, DioError e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      // It occurs when url is opened timeout.
      print("cx-连接超时");
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      // It occurs when url is sent timeout.
      print("cx-请求超时");
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      //It occurs when receiving timeout
      print("cx-响应超时");
    } else if (e.type == DioErrorType.RESPONSE) {
      // When the server response, but with a incorrect status, such as 404, 503...
      print("cx-出现异常");
    } else if (e.type == DioErrorType.CANCEL) {
      // When the request is cancelled, dio will throw a error with this type.
      print("cx-请求取消");
    } else {
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      print("cx-未知错误");
    }

    if (errorCallback != null) {
      errorCallback(e.message);
    }
  }

  String randomNum() {
    String randString =
        "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int length = 32;
    String left = "";
    for (var i = 0; i < Random().nextInt(5) + 5; i++) {
      left = left + randString[Random().nextInt(randString.length)];
    }
    return left;
  }

  String getSign(String random, String s, String s1, String s2) {
    List<Map<String, String>> signList = <Map<String, String>>[];
    signList.add({"Owin-Rand": random});
    signList.add({"Owin-Ts": s});
    signList.add({"Owin-Uid": s1});
    signList.add({"SecurityKey": s2});
    String signStr = "";
    for (int i = 0; i < signList.length; i++) {
      signStr += signList[i].keys.first + "=" + signList[i].values.first + "&";
    }
    signStr.substring(0, signStr.length - 1);
    String md5signStr = md5.convert(utf8.encode(signStr)).toString();
    return md5signStr;
  }
}
