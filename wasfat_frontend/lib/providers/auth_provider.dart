import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasfat_frontend/clients.dart';

class AuthProvider extends ChangeNotifier {
  String? username;

  Future<String?> signup(
      {required String username, required String password}) async {
    try {
      var response = await Client.dio.post('/auth/signup/', data: {
        'username': username,
        'password': password,
      });

      var token = response.data['token'];

      Client.dio.options.headers[HttpHeaders.authorizationHeader] =
          'Bearer $token';

      this.username = username;

      var pref = await SharedPreferences.getInstance();
      await pref.setString('token', token);

      return null;
    } on DioError catch (e) {
      print(e.response!.data);

      if (e.response != null &&
          e.response!.data != null &&
          e.response!.data is Map) {
        var map = e.response!.data as Map;
        return map.values.first.first;
      }
    } catch (e) {
      print(e);
      return "$e";
    }
    return "unknown error";
  }

  Future<bool> signin(
      {required String username, required String password}) async {
    try {
      var response = await Client.dio.post('/auth/signin/', data: {
        'username': username,
        'password': password,
      });

      var token = response.data['token'];

      Client.dio.options.headers[HttpHeaders.authorizationHeader] =
          'Bearer $token';

      this.username = username;

      var pref = await SharedPreferences.getInstance();
      await pref.setString('token', token);

      return true;
    } on DioError catch (e) {
      print(e.response!.data);
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> hasToken() async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');

    if (token == null || token.isEmpty || JwtDecoder.isExpired(token)) {
      pref.remove("token");
      return false;
    }

    var tokenMap = JwtDecoder.decode(token);
    username = tokenMap['username'];

    return true;
  }
}
