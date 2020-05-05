class User {
  String id;
  String email;
  String firstName;
  String lastName;
  String bio;
  String imageUrl;
  int followers;
  int following;
  int posts;

  User({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.bio = '',
    this.imageUrl,
    this.followers = 0,
    this.following = 0,
    this.posts = 0,
  });

  Map<String, dynamic> UserToMap() {
    return <String, dynamic>{
      'id': this.id,
      'email': this.email,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'bio': this.bio,
      'imageUrl': this.imageUrl,
      'followers': this.followers,
      'following': this.following,
      'posts': this.posts,
    };
  }

  void MapToUser(Map<String, dynamic> map) {
    this.id = map['id'];
    this.email = map['email'];
    this.firstName = map['firstName'];
    this.lastName = map['lastName'];
    this.bio = map['bio'];
    this.imageUrl = map['imageUrl'];
    this.followers = map['followers'];
    this.following = map['following'];
    this.posts = map['posts'];
  }
}
