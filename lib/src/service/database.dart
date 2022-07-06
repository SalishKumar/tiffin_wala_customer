import 'package:tiffin_wala_customer/src/constants/data.dart' as data;
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

  timeoutSettings(int x) {
    BaseOptions options = BaseOptions(
        baseUrl: endpoint.base,
        receiveDataWhenStatusError: true,
        connectTimeout: x * 1000, // 60 seconds
        receiveTimeout: x * 1000 // 60 seconds
        );

    dio = Dio(options);
  }

  Future register(Map<String, dynamic> map, String id) async {
    try {
      map["device_id"] = id;
      print(map);
      timeoutSettings(15);
      dynamic response =
          await dio.post(endpoint.base + endpoint.signup, data: map);
      print("${response.data} **");
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

  Future login(String email, String pass, String id) async {
    try {
      Map<String, dynamic> map = {
        "device_id": id
      };
      print(map);
      timeoutSettings(15);
      // print(endpoint.base + endpoint.signup + email + '/' + pass);
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

  // Future registerGoogle(Map<String, dynamic> map) async {
  //   try {
  //     timeoutSettings(15);
  //     dynamic response =
  //         await dio.post(endpoint.base + endpoint.signup, data: map);
  //     print(response.data);
  //     if (response.statusCode != 200) {
  //       return null;
  //     }
  //     return response.data;
  //   } on DioError catch (e) {
  //     if (e.type == DioErrorType.connectTimeout ||
  //         e.type == DioErrorType.receiveTimeout) {
  //       print(e.type);
  //       Map<String, dynamic> map = {'Timeout': 'true'};
  //       return map;
  //     }
  //     print(e.toString());
  //     return null;
  //   }
  // }

  Future loginGoogle(String? token, String id) async {
    try {
      Map<String, dynamic> map = {
        "device_id": id
      };
      print(map);
      timeoutSettings(15);
      dynamic response = await dio.get(
          endpoint.base + endpoint.signup + '?google_auth_token=' + token!,
          queryParameters: map);
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

  Future loginToken(String? token, String id) async {
    try {
      Map<String, dynamic> map = {
        "device_id": id
      };
      print(map);
      timeoutSettings(15);
      dynamic response = await dio.get(
          endpoint.base + endpoint.signup + '?auth_token=' + token!,
          queryParameters: map);
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
      timeoutSettings(15);
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
          endpoint.base + endpoint.signup + endpoint.verify,
          queryParameters: map);
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

  Future address(Map<String, dynamic> map) async {
    try {
      timeoutSettings(15);
      map['customer_id'] = data.user.id;
      timeoutSettings(50);
      dynamic response =
          await dio.post(endpoint.base + endpoint.signup + endpoint.address,
              data: map,
              options: Options(
                headers: {
                  'Authorization': "token ${data.user.token}",
                },
                validateStatus: (_) => true,
                contentType: Headers.jsonContentType,
                responseType: ResponseType.json,
              ));
      print("Tis is reponse ${response.data}");
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

  Future editAddress(Map<String, dynamic> map) async {
    try {
      timeoutSettings(15);
      map['customer_id'] = data.user.id;
      dynamic response =
          await dio.put(endpoint.base + endpoint.signup + endpoint.address,
              data: map,
              options: Options(
                headers: {
                  'Authorization': "token ${data.user.token}",
                },
                validateStatus: (_) => true,
                contentType: Headers.jsonContentType,
                responseType: ResponseType.json,
              ));
      print("Tis is reponse ${response.data}");
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

  Future updteUser(map) async {
    try {
      timeoutSettings(15);
      dynamic response = await dio.put(endpoint.base + endpoint.signup,
          data: map,
          options: Options(
            headers: {
              'Authorization': "token ${data.user.token}",
            },
            validateStatus: (_) => true,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ));
      if (response.statusCode != 200) {
        return null;
      }
      print(1);
      response.data['Timeout'] = 'false';
      print(2);
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

  Future verifyForUpdate(Map<String, dynamic> map) async {
    try {
      timeoutSettings(15);
      print(endpoint.base + endpoint.signup + endpoint.verify);
      dynamic response = await dio.get(
          endpoint.base + endpoint.signup + endpoint.verify,
          queryParameters: map);
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

  Future home() async {
    try {
      timeoutSettings(15);
      dynamic response = await dio.get(
          endpoint.base + endpoint.signup + endpoint.vendor,
          options: Options(
            headers: {
              'Authorization': "token ${data.user.token}",
            },
            validateStatus: (_) => true,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ));
      print("This is home ${response.data}");
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

  Future getVouchers(Map<String, dynamic> map) async {
    try {
      timeoutSettings(15);
      dynamic response = await dio.get(
          endpoint.base + endpoint.signup + endpoint.voucher,
          queryParameters: map,
          options: Options(
            headers: {
              'Authorization': "token ${data.user.token}",
            },
            validateStatus: (_) => true,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ));
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

  Future validateVouchers(Map<String, dynamic> map) async {
    try {
      timeoutSettings(15);
      dynamic response = await dio.get(
          endpoint.base + endpoint.signup + endpoint.voucher + endpoint.validate,
          queryParameters: map,
          options: Options(
            headers: {
              'Authorization': "token ${data.user.token}",
            },
            validateStatus: (_) => true,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ));
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

  Future postOrder(Map<String, dynamic> map) async {
    try {
      print(map);
      timeoutSettings(15);
      dynamic response =
          await dio.post(endpoint.base + endpoint.signup + endpoint.order,
              data: map,
              options: Options(
                headers: {
                  'Authorization': "token ${data.user.token}",
                },
                validateStatus: (_) => true,
                contentType: Headers.jsonContentType,
                responseType: ResponseType.json,
              ));
      print("Tis is reponse ${response.data}");
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

  Future postSubscriptionOrder(Map<String, dynamic> map) async {
    try {
      print(map);
      timeoutSettings(15);
      dynamic response =
          await dio.post(endpoint.base + endpoint.signup + endpoint.subscription,
              data: map,
              options: Options(
                headers: {
                  'Authorization': "token ${data.user.token}",
                },
                validateStatus: (_) => true,
                contentType: Headers.jsonContentType,
                responseType: ResponseType.json,
              ));
      print("Tis is reponse ${response.data}");
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

  Future getOrders(Map<String, dynamic> map) async {
    try {
      print("\nPost Subscription Order = $map");
      timeoutSettings(30);
      dynamic response = await dio.get(
          endpoint.base + endpoint.signup + endpoint.order,
          queryParameters: map,
          options: Options(
            headers: {
              'Authorization': "token ${data.user.token}",
            },
            validateStatus: (_) => true,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ));
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

  Future getSubscriptionOrders(Map<String, dynamic> map) async {
    try {
      timeoutSettings(30);
      dynamic response = await dio.get(
          endpoint.base + endpoint.signup + endpoint.subscription,
          queryParameters: map,
          options: Options(
            headers: {
              'Authorization': "token ${data.user.token}",
            },
            validateStatus: (_) => true,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ));
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

  Future cancelOrders(Map<String, dynamic> map) async {
    try {
      timeoutSettings(15);
      dynamic response = await dio.put(endpoint.base + endpoint.signup + endpoint.order,
          data: map,
          options: Options(
            headers: {
              'Authorization': "token ${data.user.token}",
            },
            validateStatus: (_) => true,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ));
      if (response.statusCode != 200) {
        return null;
      }
      response.data['Timeout'] = 'false';
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

  Future subscriptionStatus(Map<String, dynamic> map) async {
    try {
      print("subs $map");
      timeoutSettings(15);
      dynamic response = await dio.put(endpoint.base + endpoint.signup + endpoint.subscription,
          data: map,
          options: Options(
            headers: {
              'Authorization': "token ${data.user.token}",
            },
            validateStatus: (_) => true,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ));
          print(response.data);
      if (response.statusCode != 200) {
        return null;
      }
      response.data['Timeout'] = 'false';
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

  Future reviewOrder(Map<String, dynamic> map) async {
    try {
      timeoutSettings(15);
      dynamic response =
          await dio.post(endpoint.base + endpoint.signup + endpoint.order + endpoint.review,
              data: map,
              options: Options(
                headers: {
                  'Authorization': "token ${data.user.token}",
                },
                validateStatus: (_) => true,
                contentType: Headers.jsonContentType,
                responseType: ResponseType.json,
              ));
      print("Tis is reponse ${response.data}");
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

  Future complainOrder(FormData formData) async {
    try {
      timeoutSettings(15);
      dynamic response =
          await dio.post(endpoint.base + endpoint.signup + endpoint.order + endpoint.complain,
              data: formData,
              options: Options(
                headers: {
                  'Authorization': "token ${data.user.token}",
                },
                validateStatus: (_) => true,
                contentType: Headers.jsonContentType,
                responseType: ResponseType.json,
              ));
      print("Tis is reponse ${response.data}");
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

  Future getComplains(Map<String, dynamic> map) async {
    try {
      timeoutSettings(15);
      dynamic response = await dio.get(
          endpoint.base + endpoint.signup + endpoint.order + endpoint.complain,
          queryParameters: map,
          options: Options(
            headers: {
              'Authorization': "token ${data.user.token}",
            },
            validateStatus: (_) => true,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ));
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

  Future satisfactionRating(Map<String, dynamic> map) async {
    try {
      timeoutSettings(15);
      dynamic response = await dio.put(endpoint.base + endpoint.signup + endpoint.order + endpoint.complain,
          data: map,
          options: Options(
            headers: {
              'Authorization': "token ${data.user.token}",
            },
            validateStatus: (_) => true,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ));
      if (response.statusCode != 200) {
        return null;
      }
      response.data['Timeout'] = 'false';
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
