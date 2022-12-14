import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasfat_frontend/clients.dart';
import 'package:wasfat_frontend/models/category_model.dart';
import 'package:wasfat_frontend/models/ingredient_model.dart';
import 'package:wasfat_frontend/models/recipe_model.dart';

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
        var recipeJson = recipesJsonList[i] as Map<String, dynamic>;
        // print(recipeJson);
        var recipe = Recipe.fromMap(recipeJson);
        if (recipe.image == '' || recipe.image == null) {
          Dio client = Dio();
          client.options.headers['X-RapidAPI-Key'] =
              '2ff233efbcmshe222fd614bca32cp1484a1jsn9e25764449e7';
          client.options.headers['X-RapidAPI-Host'] =
              'bing-image-search1.p.rapidapi.com';

          var imageResponse = await client.get(
              'https://bing-image-search1.p.rapidapi.com/images/search?q=${recipe.title}');

          var imagesJsonList = imageResponse.data as Map;

          recipe.image = imagesJsonList['value'][2]['contentUrl'];
        }

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

  Future<String?> addRecipe({
    required int profile,
    required String title,
    required Category category,
    required int prepTime,
    required int cookTime,
    required String method,
    required List<Ingredient> ingredients,
    required File image,
  }) async {
    try {
      var pref = await SharedPreferences.getInstance();
      var token = pref.getString('token');
      if (token == null || token.isEmpty || JwtDecoder.isExpired(token)) {
        pref.remove("token");
        return 'Your session is expired, please login again!';
      }
      var tokenMap = JwtDecoder.decode(token);
      profile = tokenMap['user_id'];

      var response = await Client.dio.post('/recipes/add/',
          data: FormData.fromMap({
            'profile': profile,
            'title': title,
            'category': category.id,
            'prepTime': prepTime,
            'cookTime': cookTime,
            'method': method,
            'ingredients': ingredients.map((e) => e.id).toList(),
            'image': await MultipartFile.fromFile(image.path),
          }));

      loadRecipes();

      return null;
    } on DioError catch (e) {
      print(e);

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

  void deleteRecipe(int id) async {
    await Client.dio.delete('${id}');
    loadRecipes();
  }
}
