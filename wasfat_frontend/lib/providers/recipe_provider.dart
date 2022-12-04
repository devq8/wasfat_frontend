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
        var recipeJson = recipesJsonList[i] as Map;
        var recipe = Recipe(
          id: recipeJson['id'],
          title: recipeJson['title'],
          category: recipeJson['category'].toString(),
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

  // Future<void> editRecipe({}) async {}

  // Future<void> deleteRecipe({}) async {}
}
