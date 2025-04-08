import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../services/local_store_config.dart';


class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await HiveService.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
    debugPrint("Bearer token => $token");
  }
}

// class LogInToken {
//   static Future<void> saveToken(String newToken) async {
//     var box = await Hive.openBox('myBox');
//     await box.put('logInToken', newToken);
// // token.value = newToken;
//     print("Get  Token  in Hive  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
//   }
//
//   static Future<void> removeToken() async {
//     var box = await Hive.openBox('myBox');
//     Log.i(box.isEmpty);
//     await box.delete('logInToken');
// // token.value = '';
//     print("Remove Token from Hive  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
//   }
// }
