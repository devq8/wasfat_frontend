import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wasfat_frontend/clients.dart';
import 'package:wasfat_frontend/models/ingredient_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class IngredientProvider extends ChangeNotifier {
  List<Ingredient> ingredients = [];
  bool isLoading = false;

  IngredientProvider() {
    loadIngredients();
  }

  Future<String?> loadIngredients({int? category_id}) async {
    print('Process of loading list of ingredients is started ... ');
    isLoading = true;
    notifyListeners();
    ingredients.clear();

    Response response;

    try {
      if (category_id != null) {
        response = await Client.dio.get('/ingredients/?category=$category_id');
      }

      response = await Client.dio.get('/ingredients/');

      var ingredientsJsonList = response.data as List;
      Dio client = Dio();

      client.options.headers['X-RapidAPI-Key'] =
          '2ff233efbcmshe222fd614bca32cp1484a1jsn9e25764449e7';
      client.options.headers['X-RapidAPI-Host'] =
          'bing-image-search1.p.rapidapi.com';
      print(
          'There\'s ${ingredientsJsonList.length} number of ingredients in the database!');
      // print(DotEnv().env['XRapidAPIKey']);

      for (int i = 0; i < ingredientsJsonList.length; i++) {
        var ingredientsJson = ingredientsJsonList[i] as Map<String, dynamic>;
        var ingredient = Ingredient.fromJson(ingredientsJson);
        var imageResponse = await client.get(
            'https://bing-image-search1.p.rapidapi.com/images/search?q=${ingredient.title}');

        var imagesJsonList = imageResponse.data as Map;

        ingredient.image = imagesJsonList['value'][2]['contentUrl'];
        ingredients.add(ingredient);
      }
      print(
          'You have ${ingredients.length} ingredients in your database and the list has been created successfully!');

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
}
