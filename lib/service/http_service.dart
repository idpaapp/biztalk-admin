import 'dart:async';
import 'package:biztalk_panel_admin/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

enum RequestType { post, get, put, delete ,patch}

final AuthController _authController = Get.put(AuthController());

class HttpServices {
  //==============================main httpServices
  static Future<dynamic> request(RequestType requestType,
      String url, {
        Map<String, String>? additionalHeaders,
        Map<String, dynamic>? body,
        bool defaultHeaders = true,
        bool needAuth = true,
      }) async {
    print( _authController.fetchToken());
    print( "******************* token ***************");
    try {
      Map<String, String> headers = {};
      if (needAuth) {
        headers['Authorization'] = 'Bearer ' + _authController.fetchToken();
      }
      if (defaultHeaders) {
        headers['Content-Type'] = 'application/json; charset=UTF-8';
    }
    if (additionalHeaders != null) headers.addAll(additionalHeaders);
    http.Response response;

    switch (requestType) {
    case RequestType.post:
    response = await http
        .post(Uri.parse(url),
    headers: headers, body: convert.jsonEncode(body))
        .timeout(const Duration(seconds: 15), onTimeout: () {
    throw TimeoutException("connection time out try agian");
    });
    break;
    case RequestType.put:
    response = await http
        .put(Uri.parse(url),
    headers: headers, body: convert.jsonEncode(body))
        .timeout(const Duration(seconds: 15), onTimeout: () {
    throw TimeoutException("connection time out try agian");
    });
    break;

      case RequestType.patch:
        response = await http
            .patch(Uri.parse(url),
            headers: headers, body: convert.jsonEncode(body))
            .timeout(const Duration(seconds: 30), onTimeout: () {
          throw TimeoutException("connection time out try again");
        });
    break;

    case RequestType.get:
    response = await http
        .get(Uri.parse(url), headers: headers)
        .timeout(const Duration(seconds: 10), onTimeout: () {
    throw TimeoutException("connection time out try agian");
    });
    break;
    case RequestType.delete:
    response = await http
        .delete(Uri.parse(url), headers: headers,body:convert.jsonEncode(body) )
        .timeout(const Duration(seconds: 10), onTimeout: () {
    throw TimeoutException("connection time out try agian");
    });
    break;
    }
    if (response.statusCode == 200) {
    return convert.jsonDecode(response.body);
    } else {
    return convert.jsonDecode(response.body);
    }
    } on TimeoutException catch (_) {
    throw Exception("Response Error");
    }
  }
}
