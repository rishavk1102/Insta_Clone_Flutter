import 'dart:io';

import 'package:flutter/material.dart';

import '../firebase-services.dart';
import '../models/user.dart';
import './select_location.dart';

class PostEdit extends StatefulWidget {
  static const routeName = '/post-edit';

  @override
  _PostEditState createState() => _PostEditState();
}

class _PostEditState extends State<PostEdit> {
  User currentUser;
  List<String> selectedImages = [];

  var captionController = TextEditingController();

  @override
  void dispose() {
    captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseServices()
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
            onPressed: () => print('SHARE button pressed'),
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
              onEditingComplete: () => print('Editing complete'),
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
        onTap: () => Navigator.of(context).pushNamed(SelectLocation.routeName),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          child: Text(
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
