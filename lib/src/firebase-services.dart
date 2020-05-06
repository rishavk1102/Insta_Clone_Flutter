import 'dart:async';
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import './models/user.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase().reference();

  Future<FirebaseUser> registerUserUsingEmainAndPassword(
      String email, String password, String firstName, String lastName) async {
    FirebaseUser user;
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
        User userObj = User(
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
    return user;
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
}
