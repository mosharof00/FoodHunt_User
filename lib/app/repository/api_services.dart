import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../Helper/logger.dart';
import '../../Utils/global_snackbar.dart';
import '../models/checkout_model.dart';
import 'api_endpoints.dart';

abstract class IApiService {


  /// Payment
  Future<PaymentModel> payment({
    required String userId,
    required double totalAmount,
    required String restaurantName,
    required String restaurantImage,
    required String paymentMethod,
  });


}

class ApiServices implements IApiService {
  final Dio _dio;
  ApiServices()
      : _dio = Dio(BaseOptions(
          validateStatus: (statusCode) {
            if (statusCode == null) {
              return false;
            }
            if (statusCode == 422 ||
                statusCode == 400 ||
                statusCode == 401 ||
                statusCode == 409) {
              // your http status code
              return true;
            } else {
              return statusCode >= 200 && statusCode < 300;
            }
          },
        )) {
    // _dio.interceptors.add(AuthInterceptor());
  }



  /// Payment
  @override
  Future<PaymentModel> payment({
    required String userId,
    required double totalAmount,
    required String restaurantName,
    required String restaurantImage,
    required String paymentMethod,
  }) async {
    var data = json.encode({
      "userId":userId,
      "totalAmount": totalAmount,
      "restaurantName": restaurantName,
      "restaurantImage": restaurantImage,
      "paymentMethod": paymentMethod,
    });

    var headers = {
      'Content-Type': 'application/json'
    };
    return _handleRequest<PaymentModel>(
      () => _dio.post("http://192.168.68.103:3000/api/checkout",  options: Options(
        method: 'POST',
        headers: headers,
      ), data: data),
      (dynamic data) => PaymentModel.fromJson(data),
      'Payment',
    );
  }


}

//Handle API request and response with error handling
Future<T> _handleRequest<T>(Future<Response<dynamic>> Function() request,
    T Function(dynamic) mapper, String apiName) async {
  try {
    final response = await request();
    // Log.i('Print Status Code');
    // Log.i(response.statusCode);
    // Log.i(response.data);
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204 ||
        response.statusCode == 422 ||
        response.statusCode == 401 ||
        response.statusCode == 409 ||
        response.statusCode == 400) {
      debugPrint('Api Name: $apiName');
      return mapper(response.data);
    } else {
      Log.i('Api Exception Error ${response.toString()}');
      if (response.statusCode == 401) {
        Map<String, dynamic> responseData = response.data;
        String? message = responseData['message'];
        globalSnackBar(
            durationInSeconds: 2, title: "Warning!", message: message ?? "");
      }

      throw ApiException('Failed to load data: ${response.statusCode}',
          statusCode: response.statusCode!);
    }
  } catch (e, stacktrace) {
    Log.e('Error $apiName : ${e.toString()}');
    // Log.e('Stacktrace: $stacktrace');
    throw ApiException('Failed to load data: $e', statusCode: 500);
  }
}

// Custom exception class for API errors
class ApiException implements Exception {
  final String message;
  final int statusCode;

  ApiException(this.message, {this.statusCode = 500});
}
// class PaymentService {
//
//
//  static Future<PaymentModel?> checkout({
//     required String userId,
//     required double totalAmount,
//     required String restaurantName,
//     required String restaurantImage,
//     required String paymentMethod,
//   }) async {
//
//     final Dio dio = Dio();
//     try {
//       var headers = {
//         'Content-Type': 'application/json',
//       };
//
//       var data = json.encode({
//         "userId": userId,
//         "totalAmount": totalAmount,
//         "restaurantName": restaurantName,
//         "restaurantImage": restaurantImage,
//         "paymentMethod": paymentMethod
//       });
//
//       var response = await dio.post(
//         ApiEndPoint.payment,
//         options: Options(headers: headers),
//         data: data,
//       );
//
//       if (response.statusCode == 200) {
//         return PaymentModel.fromJson(response.data);
//       } else {
//         Log.e("Error: ${response.statusMessage}");
//         return null;
//       }
//     } catch (e) {
//       Log.e("Exception: $e");
//       return null;
//     }
//   }
// }