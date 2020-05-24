import 'package:firebase_database/firebase_database.dart';

import './place.dart';

class PostData {
  String postId;
  List<String> gallery;
  int totalLike;
  int totalComment;
  String postTime;
  String caption;
  Place location;

  PostData({
    this.postId,
    this.gallery,
    this.totalLike,
    this.totalComment,
    this.postTime,
    this.caption,
    this.location,
  });

  Map<String, dynamic> PostDataToMap() {
    Map<String, String> urls = {};
    for (var i = 0; i < gallery.length; i++) urls['post${i + 1}'] = gallery[i];

    return <String, dynamic>{
      'postId': this.postId,
      'gallery': urls,
      'totalLike': this.totalLike,
      'totalComment': this.totalComment,
      'postTime': this.postTime,
      'caption': this.caption,
      'locationTitle': (this.location != null) ? this.location.title : '',
      'locationSubTitle': (this.location != null) ? this.location.subTitle : '',
    };
  }

  PostData.mapToPostData(Map<dynamic, dynamic> map) {
    gallery = [];

    this.postId = map['postId'];
    //this.gallery = map['gallery'] as List<String>;
    this.totalLike = map['totalLike'];
    this.totalComment = map['totalComment'];
    this.postTime = map['postTime'];
    this.caption = map['caption'];
    this.location = Place(
      title: map['locationTitle'],
      subTitle: map['locationSubTitle'],
    );
    map['gallery'].forEach((key, value) {
      this.gallery.add(value);
    });
  }
}
