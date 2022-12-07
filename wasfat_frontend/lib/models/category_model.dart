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

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['title'],
      image: json['image'] ??
          "https://t3.ftcdn.net/jpg/03/45/05/92/360_F_345059232_CPieT8RIWOUk4JqBkkWkIETYAkmz2b75.jpg",
    );
  }
}

// void main() {
//   var c = Category(id: 0, title: "title");

//   Category.createKuwait()
// }
