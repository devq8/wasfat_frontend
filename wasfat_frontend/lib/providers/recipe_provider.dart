import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wasfat_frontend/clients.dart';
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
        var recipe = Recipe.fromJson(recipeJson);
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

  // Future<void> editRecipe({}) async {}

  // Future<void> deleteRecipe({}) async {}
}
