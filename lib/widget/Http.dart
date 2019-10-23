import 'package:http/http.dart' as http;
import 'dart:async';

class Http {
  //get请求
  static Future<String> get(String url, {Map<String, String> params}) async {
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=$value" + "&");
      });
      String paramsStr = sb.toString();
      paramsStr = paramsStr.substring(0, paramsStr.length - 1);
      url += paramsStr;
    }
    http.Response res = await http.get(url);
    print("cx-----"+res.body);
//    if (res.statusCode == 200) {
//      return res.body;
//    } else {
//      return null;
//    }
  }

  //post请求
  static Future<String> post(String url, {Map<String, String> parmas}) async {
    http.Response res = await http.post(url);
    return res.body;
  }
}
