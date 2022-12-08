import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasfat_frontend/clients.dart';
import 'package:wasfat_frontend/models/category_model.dart';
import 'package:wasfat_frontend/models/recipe_model.dart';
import 'package:wasfat_frontend/pages/add_recipe.dart';

class RecipeProvider extends ChangeNotifier {
  List<Recipe> recipes = [];
  bool isLoading = false;

  RecipeProvider() {
    loadRecipes();
  }

  Future<void> loadRecipes() async {
    print('Loading list of recipes is started ... ');
    isLoading = true;
    notifyListeners();
    recipes.clear();

    try {
      print('trying to connect to backend ...');
      var response = await Client.dio.get('/recipes/');
      print('Establish the link');
      var recipesJsonList = response.data as List;
      print('Get the list');
      print(
          'There\'s ${recipesJsonList.length} number of recipes in the database!');
      for (int i = 0; i < recipesJsonList.length; i++) {
        var recipeJson = recipesJsonList[i] as Map;
        var recipe = Recipe(
          id: recipeJson['id'],
          title: recipeJson['title'],
          category: Category.fromJson(recipeJson['category']),
          prepTime: recipeJson['prepTime'],
          cookTime: recipeJson['cookTime'],
          servings: recipeJson['servings'],
          method: recipeJson['method'],
          image: recipeJson['image'],
        );

        recipes.add(recipe);
      }
      print(
          'You have ${recipes.length} recipes in your database and the list has been created successfully!');
    } on DioError catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }

  // Future<void> editRecipe({
  //   required int id,
  //   required String title,
  //   required Category category,
  //   required String ingredients,
  //   required String prepTime,
  //   required String cookTime,
  //   required String method,
  //   required File image,
  // }) async {
  //   var response = await Client.dio.put('${id}',
  //       data: FormData.fromMap({
  //         'category': category,
  //         'title': title,
  //         'ingredients': ingredients,
  //         'prepTime': prepTime,
  //         'cookTime': cookTime,
  //         'method': method,
  //         'image': await MultipartFile.fromFile(image.path),
  //       }));

  //   loadRecipes();
  // }

  // Future<void> patchRecipe({
  //   required Recipe recipe,
  //   String? title,
  //   String? ingredients,
  //   String? prepTime,
  //   String? cookTime,
  //   String? method,
  //   File? image,
  // }) async {
  //   var response = await Client.dio.patch('${recipe.id}',
  //       data: FormData.fromMap({
  //         if (title != null) 'title': title,
  //         if (ingredients != null) 'ingredients': ingredients,
  //         if (prepTime != null) 'prepTime': prepTime,
  //         if (cookTime != null) 'cookTime': cookTime,
  //         if (method != null) 'method': method,
  //         if (image != null) 'image': await MultipartFile.fromFile(image.path),
  //       }));

  //   loadRecipes();
  // }

  Future<void> addRecipe({
    int? profile,
    required String title,
    Category? category,
    required int prepTime,
    required int cookTime,
    required String method,
    required File image,
  }) async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    if (token == null || token.isEmpty || JwtDecoder.isExpired(token)) {
      pref.remove("token");
      return;
    }
    var tokenMap = JwtDecoder.decode(token);
    profile = tokenMap['user_id'];

    var response = await Client.dio.post('/recipes/add/',
        data: FormData.fromMap({
          'profile': profile,
          'title': title,
          'category': category,
          'prepTime': prepTime,
          'cookTime': cookTime,
          'method': method,
          'image': await MultipartFile.fromFile(image.path),
        }));

    loadRecipes();
  }

  void deleteRecipe(int id) async {
    await Client.dio.delete('${id}');
    loadRecipes();
  }
}
