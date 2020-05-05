import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> registerUserUsingEmainAndPassword(
      String email, String password, String firstName, String lastName) async {
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ));

    assert(user != null);
    assert(await user.getIdToken() != null);

    print('User with $email created!');
    return user;
  }
}
