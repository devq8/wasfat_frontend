import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasfat_frontend/clients.dart';
import 'package:wasfat_frontend/util.dart';

class AuthProvider extends ChangeNotifier {
  String? username;
  String? profileImage;

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
    return "Unknown error!";
  }

  Future<String?> signin(
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
      // await pref.setString('username', username);
      // await SharedPrefUtils.saveStr('username', username);

      // var tokenMap = JwtDecoder.decode(token);
      // String? avatar = tokenMap["image"];
      // if (avatar == null || avatar.isEmpty) {
      //   await SharedPrefUtils.saveStr('avatar',
      //       'https://st4.depositphotos.com/4329009/19956/v/600/depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar.jpg');
      // } else {
      //   await SharedPrefUtils.saveStr('avatar', '${Client.serverUrl}$avatar');
      // }

      // print(await SharedPrefUtils.readPrefStr('avatar'));
      // print(await SharedPrefUtils.readPrefStr('username'));

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
      return '$e';
    }
    return 'Unknown error!';
  }

  Future<bool> hasToken() async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');

    if (token == null || token.isEmpty || JwtDecoder.isExpired(token)) {
      pref.remove("token");
      // await SharedPrefUtils.saveStr('avatar', '');
      // pref.remove("avatar");
      return false;
    }

    // var tokenMap = JwtDecoder.decode(token);
    // username = tokenMap['username'];

    return true;
  }
}
