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

  Future<void> loadCategories() async {
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
        var categoriesJson = categoriesJsonList[i] as Map;
        var category = Category(
          id: categoriesJson['id'],
          title: categoriesJson['title'],
          image: categoriesJson['image'],
        );
        categories.add(category);
      }
      print(
          'You have ${categories.length} categories in your database and the list has been created successfully!');
    } on DioError catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }
}
