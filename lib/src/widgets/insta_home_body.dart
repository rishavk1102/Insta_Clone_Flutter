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
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: ListView.builder(
        itemCount: UiImage.postList.length + 2,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Story();
          } else if (index == 2) {
            return FriendSuggestion();
          } else {
            return Post(index - 1, UiImage.postList[index - 1]);
          }
        },
      ),
      onRefresh: () async {},
    );
  }
}
