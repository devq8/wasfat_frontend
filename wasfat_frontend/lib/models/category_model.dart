// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Category {
  int id;
  String title;
  String image;

  Category({
    required this.id,
    required this.title,
    required this.image,
  });

  // Category.kuwait()
  //     : id = 0,
  //       title = "Kuwait";

  // factory Category.kuwait2() {
  //   return Category(id: 0, title: "Kuwaiti");
  // }

  // factory Category.fromJson(Map<String, dynamic> json) {
  //   return Category(
  //     id: json['id'],
  //     title: json['title'],
  //     image: json['image'] ??
  //         "https://t3.ftcdn.net/jpg/03/45/05/92/360_F_345059232_CPieT8RIWOUk4JqBkkWkIETYAkmz2b75.jpg",
  //   );
  // }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'image': image,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int,
      title: map['title'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);
}

// void main() {
//   var c = Category(id: 0, title: "title");

//   Category.createKuwait()
// }
