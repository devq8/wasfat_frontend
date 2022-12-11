// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Ingredient {
  int id;
  String title;
  String? image;

  Ingredient({
    required this.id,
    required this.title,
    this.image,
  });

  // factory Ingredient.fromJson(Map<String, dynamic> json) {
  //   return Ingredient(
  //     id: json['id'],
  //     title: json['title'],
  //   );
  // }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'image': image,
    };
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      id: map['id'] as int,
      title: map['title'] as String,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ingredient.fromJson(String source) =>
      Ingredient.fromMap(json.decode(source) as Map<String, dynamic>);
}
