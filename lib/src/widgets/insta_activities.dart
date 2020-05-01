import 'package:flutter/material.dart';

import '../custom_icons/custom_icons.dart';
import '../utils/ui_image.dart';
import './story.dart';
import './post.dart';
import './friend_suggestion.dart';

class InstaActivities extends StatefulWidget {
  List<List<String>> listContent = UiImage.postList;

  InstaActivities() {
    listContent.insert(0, []);
    listContent.insert(2, []);
  }

  @override
  _InstaActivitiesState createState() => _InstaActivitiesState();
}

class _InstaActivitiesState extends State<InstaActivities> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(leading: leading(),
        title: title(),
        titleSpacing: 8.0,
        actions: actions(),
        ),
          body: RefreshIndicator(
        child: ListView.builder(
          itemCount: widget.listContent.length,
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
      ),
    );
  }

  Widget leading() => IconButton(
        icon: Icon(
          CustomIcons.photo_camera,
          size: 32.0,
          color: Colors.black,
        ),
        onPressed: () {},
      );

  Widget title() => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          'Instagram',
          style: TextStyle(
            fontFamily: 'BillaBong',
            fontSize: 32.0,
          ),
        ),
      );

  List<Widget> actions() => <Widget>[
        IconButton(
          icon: Icon(
            CustomIcons.igtv,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        Transform.rotate(
          angle: 0.4,
          child: IconButton(
            icon: Icon(
              CustomIcons.paper_plane,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ),
        SizedBox(width: 12.0),
      ];
}
