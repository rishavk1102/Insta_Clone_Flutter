import 'package:firebase_database/firebase_database.dart';

class User {
  String id;
  String email;
  String userName;
  String firstName;
  String lastName;
  String bio;
  String imageUrl;
  String website;
  int followers;
  int following;
  int posts;

  User({
    this.id,
    this.email,
    this.userName,
    this.firstName,
    this.lastName,
    this.bio = '',
    this.imageUrl,
    this.website,
    this.followers = 0,
    this.following = 0,
    this.posts = 0,
  });

  Map<String, dynamic> UserToMap() {
    return <String, dynamic>{
      'id': this.id,
      'email': this.email,
      'userName': this.userName,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'bio': this.bio,
      'imageUrl': this.imageUrl,
      'website': this.website,
      'followers': this.followers,
      'following': this.following,
      'posts': this.posts,
    };
  }

  User.MapToUser(DataSnapshot map) {
    this.id = map.value['id'];
    this.email = map.value['email'];
    this.userName = map.value['userName'];
    this.firstName = map.value['firstName'];
    this.lastName = map.value['lastName'];
    this.bio = map.value['bio'];
    this.imageUrl = map.value['imageUrl'];
    this.website = map.value['website'];
    this.followers = map.value['followers'];
    this.following = map.value['following'];
    this.posts = map.value['posts'];
  }
}
