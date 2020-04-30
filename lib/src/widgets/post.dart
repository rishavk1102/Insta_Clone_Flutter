import 'package:flutter/material.dart';

import '../custom_icons/custom_icons.dart';
import '../utils/ui_image.dart';
import '../widgets/circle_image.dart';

class Post extends StatelessWidget {
  final int index;

  int likedCount = -1;

  final String caption =
      '''Styling text in Flutter #something, Styling text in Flutter. #Another, #nepal, Styling text in Flutter. #ktm, #love, #newExperiance Styling text in Flutter. Styling text in Flutter. Styling text in Flutter.''';

  Post(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        userInfoRow(),
        gallery(),
        SizedBox(height: 8.0),
        actions(),
        SizedBox(height: 10.0),
        likeCounts(),
        SizedBox(height: 8.0),
        galleryCaptions(),
        SizedBox(height: 4.0),
        comments(),
        SizedBox(height: 4.0),
        addComment(),
        uploadTime(),
        SizedBox(
          height: 24.0,
        ),
      ],
    );
  }

  Widget userInfoRow() => Row(
        children: <Widget>[
          CircleImage(
            UiImage.child,
            imageSize: 36.0,
            whiteMargin: 2.0,
            imageMargin: 6.0,
          ),
          Text('_rishavl1102_'),
          Expanded(
            child: SizedBox(),
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      );

  Widget gallery() => Container(
        constraints: BoxConstraints(
          maxHeight: 400.0,
          minHeight: 200.0,
          maxWidth: double.infinity,
          minWidth: double.infinity,
        ),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey[200],
              width: 1.0,
            ),
          ),
        ),
        child: Image.asset(UiImage.storiesList[index]),
      );

  Widget actions() => Row(
        children: <Widget>[
          SizedBox(width: 12.0),
          Icon(CustomIcons.like_lineal),
          SizedBox(width: 16.0),
          Icon(CustomIcons.comment),
          SizedBox(width: 16.0),
          Transform.rotate(
            angle: 0.4,
            child: Icon(CustomIcons.paper_plane),
          ),
          Expanded(child: SizedBox()),
          Icon(CustomIcons.bookmark_lineal),
          SizedBox(width: 10.0),
        ],
      );

  Widget likeCounts() => Row(
        children: <Widget>[
          SizedBox(width: 12.0),
          Stack(
            fit: StackFit.loose,
            textDirection: TextDirection.rtl,
            children: <Widget>[
              ...UiImage.storiesList.take(3).map((image) {
                if (likedCount == 2)
                  likedCount = 0;
                else
                  likedCount++;

                return Container(
                  height: 22.0,
                  width: 22.0,
                  margin: EdgeInsets.only(right: likedCount * 14.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      style: BorderStyle.solid,
                      width: 2.0,
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(image),
                    ),
                  ),
                );
              }),
            ],
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'Liked by ',
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  TextSpan(
                    text: '_rishavk1102_ ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'and ',
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  TextSpan(
                    text: '76,324 others ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      );

  Widget galleryCaptions() => Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 16.0),
        child: RichText(
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            style: TextStyle(
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                text: '_rishavk1102_',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ..._processCaption(
                caption,
                '#',
                TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ),
      );

  Widget comments() => Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Text(
          'View all 40 comments',
          style: TextStyle(color: Colors.black45),
        ),
      );

  Widget addComment() => Row(
        children: <Widget>[
          CircleImage(
            UiImage.child,
            imageSize: 30.0,
            whiteMargin: 2.0,
            imageMargin: 6.0,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Add a comment...',
                border: InputBorder.none,
              ),
            ),
          ),
          Text(
            '🤗',
            style: TextStyle(fontSize: 14.0),
          ),
          SizedBox(width: 10.0),
          Text(
            '😘',
            style: TextStyle(fontSize: 14.0),
          ),
          SizedBox(width: 10.0),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Icon(
              Icons.add_circle_outline,
              size: 15.0,
              color: Colors.black26,
            ),
          ),
          SizedBox(width: 12.0),
        ],
      );

  Widget uploadTime() => Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Text(
          '1 hour ago ',
          style: TextStyle(
            color: Colors.black45,
          ),
        ),
      );

  List<TextSpan> _processCaption(
      String caption, String matcher, TextStyle style) {
    List<TextSpan> spans = [];

    caption.split(' ').forEach((text) {
      if (text.toString().contains(matcher)) {
        spans.add(TextSpan(
          text: text + ' ',
          style: style,
        ));
      } else {
        spans.add(TextSpan(text: text + ' '));
      }
    });

    return spans;
  }
}
