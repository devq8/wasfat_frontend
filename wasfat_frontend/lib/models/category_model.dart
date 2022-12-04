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
      image: json['image'] ?? "dummy image",
    );
  }
}

// void main() {
//   var c = Category(id: 0, title: "title");

//   Category.createKuwait()
// }
