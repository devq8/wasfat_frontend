import 'package:wasfat_frontend/models/category_model.dart';
import 'package:wasfat_frontend/models/ingredient_model.dart';

class Recipe {
  int id;
  String title;
  Category category;
  int? prepTime;
  int? cookTime;
  int? servings;
  Ingredient? ingredients;
  String? method;
  String? image;

  Recipe({
    required this.id,
    required this.title,
    required this.category,
    this.prepTime,
    this.cookTime,
    this.servings,
    this.ingredients,
    this.method,
    this.image,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      category: Category.fromJson(json['category']),
      prepTime: json['prepTime'],
      cookTime: json['cookTime'],
      servings: json['servings'],
      // ingredients: Ingredient.fromJson(json['ingredients']),
      method: json['method'],
      image: json['image'],
    );
  }
}
