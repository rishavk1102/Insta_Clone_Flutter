import 'dart:async';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

import './models/user.dart';
import './models/post_data.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase().reference();
  final StorageReference _storage = FirebaseStorage.instance.ref();

  Future<User> registerUserUsingEmainAndPassword(
      String email, String password, String firstName, String lastName) async {
    FirebaseUser user;
    User userObj;
    try {
      user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ));

      print('User with $email created!');
    } catch (e) {
      print(e.toString());
    } finally {
      if (user != null) {
        //User Cerested
        userObj = User(
          id: user.uid,
          email: email,
          userName: '',
          firstName: firstName,
          lastName: lastName,
          imageUrl: 'default',
          website: '',
        );
        _database.child('Users').child(user.uid).set(userObj.UserToMap());
        print('User created and data added to DB');
      } else {
        Fluttertoast.showToast(
          msg: 'Some error occured, please try again!',
          toastLength: Toast.LENGTH_LONG,
        );
      }
    }
    return userObj;
  }

  Future<FirebaseUser> loginWithEmailAndPassword(
      String email, String password) async {
    FirebaseUser user;
    try {
      user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e.toString());
    } finally {
      if (user != null) {
        print('Login Successful!');
      } else {
        print('Login Unsuccessful!');
      }
    }

    return user;
  }

  Future<FirebaseUser> getCurrentUser() async {
    return await _auth.currentUser();
  }

  Future<void> updateUserInfo(User user) async {
    await _database.child('Users').child(user.id).set(user.UserToMap());
    return;
  }

  Future<String> updateProfileImage(String uid, Future<File> imageFile) async {
    try {
      StorageUploadTask uploadTask =
          _storage.child('ProfilePictures').child('$uid.jpg').putFile(
                await imageFile,
                StorageMetadata(contentType: 'image/jpeg'),
              );
      String downloadUri =
          await (await uploadTask.onComplete).ref.getDownloadURL();

      print(downloadUri);

      await _database
          .child('Users')
          .child(uid)
          .update({'imageUrl': downloadUri});

      return downloadUri;
    } catch (error) {
      print('Error : $error');
    }
  }

  Future<User> getCurrentUserData() async {
    User user;
    await getCurrentUser().then((FirebaseUser currentUser) async {
      await _database
          .child('Users')
          .child(currentUser.uid)
          .once()
          .then((DataSnapshot snapshot) async {
        user = User.MapToUser(snapshot);
      });
    });
    return user;
  }

  Future<List<String>> uploadPostImage(
      String uid, List<String> selecetedImages) async {
    List<String> downloadUrls = [];
    try {
      for (var i = 0; i < selecetedImages.length; i++) {
        StorageUploadTask uploadTask = _storage
            .child('PostPictures')
            .child('$uid')
            .child(
                '$uid@${DateFormat('kk:mm:ss:EEE:d:MMM').format(DateTime.now())}:postNo-$i')
            .putFile(
              File(selecetedImages[i]),
              StorageMetadata(contentType: 'image/jpeg'),
            );

        String downloadUrl =
            await (await uploadTask.onComplete).ref.getDownloadURL();
        print(downloadUrl);
        downloadUrls.add(downloadUrl);
      }
    } catch (error) {
      print('Error : $error');
    }
    return downloadUrls;
  }

  Future<PostData> uploadPostdata(
      String uid, String caption, List<String> selecetedImages) async {
    PostData postData;
    await uploadPostImage(uid, selecetedImages)
        .then((List<String> downloadUrls) async {
      DatabaseReference postRef = _database.child('Posts').child('$uid').push();
      print(postRef.key);
      postData = PostData(
        caption: caption,
        gallery: downloadUrls,
        postId: postRef.key,
        postTime: DateFormat('kk:mm:ss:EEE:d:MMM').format(DateTime.now()),
        totalComment: 0,
        totalLike: 0,
      );

      await postRef.set(postData.PostDataToMap());
    });
    return postData;
  }
}
