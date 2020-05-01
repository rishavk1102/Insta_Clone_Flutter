import 'package:flutter/material.dart';

import '../utils/ui_image.dart';

class FriendSuggestion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(
          top: BorderSide(color: Colors.grey[200]),
          bottom: BorderSide(color: Colors.grey[200]),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          header(),
          Container(
            height: 240.0,
            child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 12.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(right: 6.0),
                  width: 150.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    fit: StackFit.expand,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          SizedBox(height: 16.0),
                          userImage(),
                          SizedBox(height: 16.0),
                          userName(),
                          SizedBox(height: 2.0),
                          userAction(),
                          Expanded(child: SizedBox()),
                          button(),
                          SizedBox(height: 16.0),
                        ],
                      ),
                      close(),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget header() => Container(
        margin: EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Text(
              'Suggested for You',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(child: SizedBox()),
            Text(
              'See All',
              style: TextStyle(
                color: Colors.black26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );

  Widget userImage() => Container(
        height: 80.0,
        width: 80.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
          border: Border.all(
            color: Colors.black45,
            width: 0.5,
          ),
          image: DecorationImage(
            image: AssetImage(UiImage.child),
            fit: BoxFit.cover,
          ),
        ),
      );

  Widget userName() => Text(
        'Sneha Kumari',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      );

  Widget userAction() => Text(
        'Follows You',
        style: TextStyle(
          color: Colors.black87,
        ),
      );

  Widget button() => Container(
        width: double.infinity,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Follow Back',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

  Widget close() => Positioned(
        right: 6.0,
        top: 6.0,
        child: Icon(
          Icons.close,
          color: Colors.black26,
          size: 20.0,
        ),
      );
}
