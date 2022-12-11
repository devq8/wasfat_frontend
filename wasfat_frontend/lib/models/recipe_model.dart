// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:wasfat_frontend/models/category_model.dart';
import 'package:wasfat_frontend/models/ingredient_model.dart';

class Recipe {
  int id;
  String title;
  Category category;
  int? prepTime;
  int? cookTime;
  int? servings;
  List<Ingredient> ingredients;
  String? method;
  String? image;

  Recipe({
    required this.id,
    required this.title,
    required this.category,
    this.prepTime,
    this.cookTime,
    this.servings,
    required this.ingredients,
    this.method,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'category': category.toMap(),
      'prepTime': prepTime,
      'cookTime': cookTime,
      'servings': servings,
      'ingredients': ingredients.map((x) => x.toMap()).toList(),
      'method': method,
      'image': image,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'] as int,
      title: map['title'] as String,
      category: Category.fromMap(map['category'] as Map<String, dynamic>),
      prepTime: map['prepTime'] != null ? map['prepTime'] as int : null,
      cookTime: map['cookTime'] != null ? map['cookTime'] as int : null,
      servings: map['servings'] != null ? map['servings'] as int : null,
      ingredients: List<Ingredient>.from(
        (map['ingredients'] as List<dynamic>).map<Ingredient>(
          (x) => Ingredient.fromMap(x as Map<String, dynamic>),
        ),
      ),
      method: map['method'] != null ? map['method'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Recipe.fromJson(String source) =>
      Recipe.fromMap(json.decode(source) as Map<String, dynamic>);
}
