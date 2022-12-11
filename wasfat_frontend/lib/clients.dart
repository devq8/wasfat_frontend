import 'package:dio/dio.dart';

class Client {
  static final String serverUrl = "https://devq8.pythonanywhere.com";
  static final Dio dio = Dio(BaseOptions(baseUrl: serverUrl));
}
