import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../model/response.dart';

class HttpServer extends GetConnect {
  final String _domain = env['DOMAIN_IP'] + env['PORT'];

  getRequest(route, {data}) async {
    return await get("$_domain$route", query: data)
        .then((value) => ResponseModel.fromMap(value.body))
        .catchError((err) {
      print('Error: ' + err.toString());
      return ResponseModel.fromMap({
        'message': "Unstable Network Connection",
        'status': false,
      });
    }).timeout(Duration(seconds: 60));
  }

  postRequest(route, {@required data}) async {
    return await post("$_domain$route", data)
        .then((value) => ResponseModel.fromMap(value.body))
        .timeout(Duration(seconds: 60))
        .catchError((err) {
      print(err);
      return ResponseModel.fromMap({
        'message': "Unstable Network Connection",
        'status': false,
      });
    });
  }

  putRequest(route, {@required data}) async {
    return await put("$_domain$route", data)
        .then((value) => ResponseModel.fromMap(value.body))
        .timeout(Duration(seconds: 60))
        .catchError((err) {
      print(err);
      return ResponseModel.fromMap({
        'message': "Unstable Network Connection",
        'status': false,
      });
    });
  }

  deleteRequest(route, {@required data}) async {
    return await delete("$_domain$route", query: data)
        .then((value) => ResponseModel.fromMap(value.body))
        .timeout(Duration(seconds: 60))
        .catchError((err) {
      print(err);
      return ResponseModel.fromMap({
        'message': "Unstable Network Connection",
        'status': false,
      });
    });
  }
}
