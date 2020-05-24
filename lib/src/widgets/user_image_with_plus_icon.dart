import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../utils/ui_image.dart';

class UserImageWithPlusIcon extends StatelessWidget {
  String url;

  UserImageWithPlusIcon({this.url});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: (url == null)
              ? Image.asset(UiImage.man2)
              : CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Stack(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/placeholder.png',
                        fit: BoxFit.cover,
                      ),
                      Center(child: CircularProgressIndicator()),
                    ],
                  ),
                  imageBuilder:
                      (BuildContext context, ImageProvider imageProvider) =>
                          Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
        ),
        Positioned(
          bottom: 0.0,
          right: 0.0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Container(
              height: 24.0,
              width: 24.0,
              margin: EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 20.0,
              ),
            ),
          ),
        )
      ],
    );
  }
}
