import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/ui_image.dart';

class Stories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: ListView.builder(
        itemCount: UiImage.storiesList.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(top: 4.0),
        itemBuilder: (BuildContext context, int index) {
          return story(index);
        },
      ),
    );
  }

  Widget story(int index) {
    return Column(
      children: <Widget>[
        index == 0 ? createStory() : storyContent(index),
        Expanded(
          child: Text(index == 0 ? 'Your Story' : 'Name'),
        ),
      ],
    );
  }

  Widget createStory() {
    return Stack(
      children: <Widget>[
        Container(
          height: 90.0,
          width: 90.0,
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(UiImage.storiesList[0]),
            ),
          ),
        )
      ],
    );
  }

  Widget storyContent(int index) {
    return Container(
      height: 90.0,
      width: 90.0,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: SweepGradient(
          colors: [
            Colors.cyan,
            Colors.red,
            Colors.amber,
            Colors.grey,
            Colors.green,
          ],
        ),
      ),
      child: Container(
        margin: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: FittedBox(
          child: Container(
            margin: EdgeInsets.all(4.0),
            height: 90.0,
            width: 90.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(UiImage.storiesList[index]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
