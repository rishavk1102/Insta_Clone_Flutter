import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../custom_icons/custom_icons.dart';
import '../utils/ui_image.dart';
import '../widgets/circle_image.dart';
import './stories.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  int likedCount = 0;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: ListView.builder(
        itemCount: UiImage.storiesList.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Stories();
          } else {
            return post(index);
          }
        },
      ),
      onRefresh: () async {},
    );
  }

  Widget post(int index) {
    return Column(
      children: <Widget>[
        Row(
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
        ),
        Container(
          constraints: BoxConstraints(
            maxHeight: 2400.0,
            minHeight: 200.0,
            maxWidth: double.infinity,
            minWidth: double.infinity,
          ),
          decoration: BoxDecoration(color: Colors.grey[200]),
          child: Image.asset(UiImage.storiesList[index]),
        ),
        SizedBox(
          height: 8.0,
        ),
        Row(
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
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          children: <Widget>[
            SizedBox(width: 12.0),
            Stack(
              textDirection: TextDirection.rtl,
              children: <Widget>[
                ...UiImage.storiesList.take(3).map((image) {
                  return Container(
                    height: 22.0,
                    width: 22.0,
                    margin: EdgeInsets.only(right: ++likedCount * 14.0),
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
        ),
        Text('Data'),
        Text('Data'),
        Row(),
        Text('Data'),
      ],
    );
  }
}
