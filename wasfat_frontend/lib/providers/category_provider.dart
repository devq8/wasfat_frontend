import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wasfat_frontend/clients.dart';
import 'package:wasfat_frontend/models/category_model.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> categories = [];
  bool isLoading = false;

  CategoryProvider() {
    loadCategories();
  }

  Future<String?> loadCategories() async {
    print('Process of loading list of categories is started ... ');
    isLoading = true;
    notifyListeners();
    categories.clear();

    try {
      var response = await Client.dio.get('/categories/');
      var categoriesJsonList = response.data as List;

      print(
          'There\'s ${categoriesJsonList.length} number of categories in the database!');

      for (int i = 0; i < categoriesJsonList.length; i++) {
        var categoriesJson = categoriesJsonList[i] as Map<String, dynamic>;
        var category = Category.fromJson(categoriesJson);
        categories.add(category);
      }
      print(
          'You have ${categories.length} categories in your database and the list has been created successfully!');

      isLoading = false;
      notifyListeners();

      return null;
    } on DioError catch (e) {
      print(e.response!.data);

      if (e.response != null &&
          e.response!.data != null &&
          e.response!.data is Map) {
        var map = e.response!.data as Map;

        isLoading = false;
        notifyListeners();

        return map.values.first;
      }
    } catch (e) {
      print(e);

      isLoading = false;
      notifyListeners();

      return '$e';
    }
    isLoading = false;
    notifyListeners();
    return 'Unknown error';
  }

  Future<void> addCategory({
    required String title,
    required File image,
  }) async {
    var response = await Client.dio.post("/categories/add/",
        data: FormData.fromMap({
          "title": title,
          "image": await MultipartFile.fromFile(image.path),
        }));

    loadCategories();
  }

  Future<void> editCategory({
    required int id,
    required String title,
    required File image,
  }) async {
    var response = await Client.dio.put("/categories/${id}/edit/",
        data: FormData.fromMap({
          "title": title,
          "image": await MultipartFile.fromFile(image.path),
        }));

    loadCategories();
  }
}
