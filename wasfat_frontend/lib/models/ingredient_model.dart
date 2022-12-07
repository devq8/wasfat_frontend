class Ingredient {
  int id;
  String title;
  String? image;

  Ingredient({
    required this.id,
    required this.title,
    this.image,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'],
      title: json['title'],
    );
  }
}
