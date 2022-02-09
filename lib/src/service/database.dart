import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tiffin_wala_customer/src/constants/api_url.dart' as endpoint;

class Database {
  Dio dio = Dio();

  Database() {
    BaseOptions options = BaseOptions(
        baseUrl: endpoint.base,
        receiveDataWhenStatusError: true,
        connectTimeout: 5 * 1000, // 60 seconds
        receiveTimeout: 5 * 1000 // 60 seconds
        );

    dio = Dio(options);
  }

  timeoutSettings(int x){
    BaseOptions options = BaseOptions(
        baseUrl: endpoint.base,
        receiveDataWhenStatusError: true,
        connectTimeout: x * 1000, // 60 seconds
        receiveTimeout: x * 1000 // 60 seconds
        );

    dio = Dio(options);
  }

  Future register(Map<String, dynamic> map) async {
    try {
      timeoutSettings(5);
      dynamic response =
          await dio.post(endpoint.base + endpoint.signup, data: map);
      print(response.data);
      if (response.statusCode != 200) {
        return null;
      }
      return response.data;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        print(e.type);
        Map<String, dynamic> map = {'Timeout': 'true'};
        return map;
      }
      print(e.toString());
      return null;
    }
  }

  Future login(String email, String pass) async {
    try {
      timeoutSettings(5);
      print(endpoint.base + endpoint.signup + email + '/' + pass);
      dynamic response = await dio.get(endpoint.base +
          endpoint.signup +
          '?email=' +
          email +
          '&password=' +
          pass);
      print(response.data);
      if (response.statusCode != 200) {
        return null;
      }
      return response.data;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        print(e.type);
        Map<String, dynamic> map = {'Timeout': 'true'};
        return map;
      }
      print(e.toString());
      return null;
    }
  }

  Future registerGoogle(Map<String, dynamic> map) async {
    try {
      timeoutSettings(5);
      dynamic response =
          await dio.post(endpoint.base + endpoint.signup, data: map);
      print(response.data);
      if (response.statusCode != 200) {
        return null;
      }
      return response.data;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        print(e.type);
        Map<String, dynamic> map = {'Timeout': 'true'};
        return map;
      }
      print(e.toString());
      return null;
    }
  }

  Future loginGoogle(String? token) async {
    try {
      timeoutSettings(5);
      dynamic response = await dio.get(
          endpoint.base + endpoint.signup + '?google_auth_token=' + token!);
      print(response.data);
      if (response.statusCode != 200) {
        return null;
      }
      return response.data;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        print(e.type);
        Map<String, dynamic> map = {'Timeout': 'true'};
        return map;
      }
      print(e.toString());
      return null;
    }
  }

  Future forget(String emailOrPhone) async {
    try {
      timeoutSettings(5);
      dynamic response = await dio.get(
          endpoint.base + endpoint.signup + endpoint.forget + emailOrPhone);
      print(response.data);
      if (response.statusCode != 200) {
        return null;
      }
      return response.data;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        print(e.type);
        Map<String, dynamic> map = {'Timeout': 'true'};
        return map;
      }
      print(e.toString());
      return null;
    }
  }

  Future verify(Map<String, dynamic> map) async {
    try {
      timeoutSettings(15);
      print(endpoint.base + endpoint.signup + endpoint.verify);
      dynamic response = await dio.get(
          endpoint.base + endpoint.signup + endpoint.verify, queryParameters: map);
      print(response.data);
      if (response.statusCode != 200) {
        return null;
      }
      return response.data;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        print(e.type);
        Map<String, dynamic> map = {'Timeout': 'true'};
        return map;
      }
      print(e.toString());
      return null;
    }
  }
}
