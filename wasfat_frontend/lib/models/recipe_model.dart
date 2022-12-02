class Recipe {
  int id;
  String title;
  String? category;
  int? prepTime;
  int? cookTime;
  int? servings;
  String? method;
  String? image;

  Recipe({
    required this.id,
    required this.title,
    this.category,
    this.prepTime,
    this.cookTime,
    this.servings,
    this.method,
    this.image,
  });
}
