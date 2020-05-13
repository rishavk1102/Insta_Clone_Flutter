import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';

import '../firebase-services.dart';
import '../models/user.dart';
import './select_location.dart';
import '../models/post_data.dart';
import '../models/place.dart';

class PostEdit extends StatefulWidget {
  static const routeName = '/post-edit';

  @override
  _PostEditState createState() => _PostEditState();
}

class _PostEditState extends State<PostEdit> {
  User currentUser;
  Place place;
  List<String> selectedImages = [];
  FirebaseServices _firebaseServices = FirebaseServices();

  var captionController = TextEditingController();

  @override
  void dispose() {
    captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _firebaseServices
        .getCurrentUserData()
        .then((value) => this.currentUser = value);

    selectedImages = ModalRoute.of(context).settings.arguments as List<String>;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 8.0,
        title: Text('Post Description'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'SHARE',
              style: TextStyle(color: Colors.blueAccent),
            ),
            onPressed: () async {
              print('SHARE button pressed');
              await _firebaseServices
                  .uploadPostdata(
                currentUser.id,
                captionController.text,
                selectedImages,
              )
                  .then((PostData currentPost) {
                print(currentPost.postId);
              });
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          caption(),
          Divider(height: 0.1),
          SizedBox(height: 10),
          tagPeople(),
          SizedBox(height: 10),
          Divider(height: 0.1),
          SizedBox(height: 10),
          addLocation(),
          SizedBox(height: 10),
          Divider(height: 0.1),
        ],
      ),
    );
  }

  Widget caption() => Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(currentUser.imageUrl),
            ),
          ),
          Expanded(
            child: TextField(
              controller: captionController,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
              decoration: InputDecoration(hintText: 'Caption'),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 80.0,
              width: 80.0,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Image.file(
                File(selectedImages[0]),
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      );

  Widget tagPeople() => Container(
        //TODO - ADD FUNCTIONALITY
        width: double.infinity,
        padding: const EdgeInsets.all(10.0),
        child: Text(
          'Tag People',
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ),
      );

  Widget addLocation() => GestureDetector(
        onTap: () async {
          place = (await Navigator.of(context)
              .pushNamed(SelectLocation.routeName)) as Place;

          if (place != null) {
            print(place.title);
            setState(() {});
          }
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          child: (place != null)
              ? Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: Colors.blue[800],
                      size: 40.0,
                    ),
                    SizedBox(width: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          place.title,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.blue[900], fontSize: 20.0),
                        ),
                        Text(
                          place.subTitle,
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                      ],
                    ),
                  ],
                )
              : Text(
                  'Add Location',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
        ),
      );
}
