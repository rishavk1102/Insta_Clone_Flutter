import 'package:flutter/material.dart';

import '../utils/ui_image.dart';
import './story.dart';
import './post.dart';

class InstaHomeBody extends StatefulWidget {
  @override
  _InstaHomeBodyState createState() => _InstaHomeBodyState();
}

class _InstaHomeBodyState extends State<InstaHomeBody> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: ListView.builder(
        itemCount: UiImage.storiesList.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Story();
          } else {
            return Post(index);
          }
        },
      ),
      onRefresh: () async {},
    );
  }
}
