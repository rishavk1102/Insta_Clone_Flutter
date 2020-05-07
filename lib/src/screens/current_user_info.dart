import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../firebase-services.dart';
import '../models/user.dart';
import './insta_home.dart';

class CurrentUserInfo extends StatefulWidget {
  static const routeName = '/current-user-info';

  @override
  _CurrentUserInfoState createState() => _CurrentUserInfoState();
}

class _CurrentUserInfoState extends State<CurrentUserInfo> {
  Future<File> imageFile;

  User currentUser;

  final nameController = TextEditingController();
  final userNameController = TextEditingController();
  final websiteController = TextEditingController();
  final bioController = TextEditingController();
  /*
      While using image picker make sure to add permissions.
      1. In Xcode go to Runner/info.plist and follow link https://flutter-examples.com/flutter-select-pick-image-from-camera-gallery/
      2. In AndroidStudio goto AndroidManifest.xml and add the following lines :
        <uses-permission android:name="android.permission.CAMERA" />
        <uses-permission android:name="android.permission.FLASHLIGHT" />
        <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
        <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />  
   */
  pickImageFromSystem(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  @override
  Widget build(BuildContext context) {
    currentUser = ModalRoute.of(context).settings.arguments;

    nameController.text = currentUser.firstName + ' ' + currentUser.lastName;
    userNameController.text = currentUser.userName;
    websiteController.text = currentUser.website;
    bioController.text = currentUser.bio;

    return Scaffold(
      appBar: AppBar(
        leading: leading(),
        title: title(),
        actions: actions(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 12.0,
        ),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              profileImage(),
              SizedBox(height: 10.0),
              name(),
              SizedBox(height: 15.0),
              userName(),
              SizedBox(height: 15.0),
              website(),
              SizedBox(height: 15.0),
              bio(),
            ],
          ),
        ),
      ),
    );
  }

  Widget leading() => IconButton(
        icon: Icon(
          Icons.close,
          size: 32.0,
          color: Colors.black,
        ),
        onPressed: () {
          print('Close button pressed!');
          Navigator.of(context).pushReplacementNamed(InstaHome.routeName);
        },
      );

  Widget title() => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          'Edit Profile',
        ),
      );

  List<Widget> actions() => <Widget>[
        IconButton(
          icon: Icon(
            Icons.done,
            color: Colors.blueAccent,
            size: 32.0,
          ),
          onPressed: () {
            print('Done');
            currentUser.userName = userNameController.text;
            currentUser.website = websiteController.text;
            currentUser.bio = bioController.text;
            FirebaseServices().updateUserInfo(currentUser).then((_) {
              Navigator.of(context).popAndPushNamed(InstaHome.routeName);
            });
          },
        )
      ];

  Widget profileImage() => Column(
        children: <Widget>[
          showImage(),
          FlatButton(
            child: Text(
              'Change Photo',
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            onPressed: () => pickImageFromSystem(ImageSource.gallery),
          ),
        ],
      );

  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        return Container(
          width: 150.0,
          height: 150.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: (snapshot.connectionState == ConnectionState.done &&
                      snapshot.data != null)
                  ? FileImage(snapshot.data)
                  : AssetImage('assets/images/man.jpg'),
            ),
          ),
        );
      },
    );
  }

  Widget name() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Name',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          TextField(
            controller: nameController,
            enabled: false,
          ),
        ],
      );

  Widget userName() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Username',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          TextField(
            controller: userNameController, keyboardType: TextInputType.text,
          ),
        ],
      );

  Widget website() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Website',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          TextField(
            controller: websiteController,
            keyboardType: TextInputType.url,
          ),
        ],
      );

  Widget bio() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Bio',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          TextField(
            controller: bioController,
            keyboardType: TextInputType.text,
            maxLines: 6,
          ),
        ],
      );
}
