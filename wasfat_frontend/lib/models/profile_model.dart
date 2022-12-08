import 'package:image_picker/image_picker.dart';

class Profile {
  int id;
  String username;
  XFile? image;

  Profile({
    required this.id,
    required this.username,
    this.image,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      username: json['username'],
      image: json['image'] ??
          'https://st4.depositphotos.com/4329009/19956/v/600/depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar.jpg',
    );
  }
}
