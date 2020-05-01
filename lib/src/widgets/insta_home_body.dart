import 'package:flutter/material.dart';

import '../utils/ui_image.dart';
import './story.dart';
import './post.dart';
import './friend_suggestion.dart';

class InstaHomeBody extends StatefulWidget {
  @override
  _InstaHomeBodyState createState() => _InstaHomeBodyState();
}

class _InstaHomeBodyState extends State<InstaHomeBody> {
  var listContent = UiImage.postList;

  @override
  Widget build(BuildContext context) {
    listContent.insert(0, []);
    listContent.insert(2, []);

    return RefreshIndicator(
      child: ListView.builder(
        itemCount: listContent.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Story();
          } else if (index == 2) {
            return FriendSuggestion();
          } else {
            return Post(UiImage.postList[index]);
          }
        },
      ),
      onRefresh: () async {},
    );
  }
}
