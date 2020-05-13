import 'package:firebase_database/firebase_database.dart';

class PostData {
  String postId;
  List<String> gallery;
  int totalLike;
  int totalComment;
  String postTime;
  String caption;

  PostData({
    this.postId,
    this.gallery,
    this.totalLike,
    this.totalComment,
    this.postTime,
    this.caption,
  });

  Map<String, dynamic> PostDataToMap() {
    Map<String, String> urls = {};
    for (var i = 0 ; i < gallery.length ; i++) 
      urls['post${i+1}'] = gallery[i];
    
    return <String, dynamic>{
      'postId': this.postId,
      'gallery': urls,
      'totalLike': this.totalLike,
      'totalComment': this.totalComment,
      'postTime': this.postTime,
      'caption': this.caption,
    };
  }

  PostData MapToPostData(DataSnapshot map) {
    this.postId = map.value['postId'];
    this.gallery = map.value['gallery'] as List<String>;
    this.totalLike = map.value['totalLike'];
    this.totalComment = map.value['totalComment'];
    this.postTime = map.value['postTime'];
    this.caption = map.value['caption'];
  }
}
