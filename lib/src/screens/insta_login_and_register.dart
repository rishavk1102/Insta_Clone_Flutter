import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../firebase-services.dart';

class InstaLoginAndRegister extends StatefulWidget {
  @override
  _InstaLoginAndRegisterState createState() => _InstaLoginAndRegisterState();
}

class _InstaLoginAndRegisterState extends State<InstaLoginAndRegister> {
  final firebaseServices = new FirebaseServices();

  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();

  bool register = true;

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            title(),
            SizedBox(height: 20.0),
            loginWithFacebook(),
            SizedBox(height: 20.0),
            divider(),
            SizedBox(height: 20.0),
            registerEmailAndPasswordInput(),
          ],
        ),
      ),
    );
  }

  Widget title() => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          'Instagram',
          style: TextStyle(
            fontFamily: 'BillaBong',
            fontSize: 60.0,
          ),
        ),
      );

  Widget loginWithFacebook() => SignInButton(
        Buttons.Facebook,
        text: 'Continue with Facebook',
        onPressed: () => print('continue with facebook'),
        padding: EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 15.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      );

  Widget divider() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 2.0,
            width: 120.0,
            color: Colors.grey[300],
          ),
          SizedBox(width: 20.0),
          Text(
            'OR',
            style: TextStyle(color: Colors.black54),
          ),
          SizedBox(width: 20.0),
          Container(
            height: 2.0,
            width: 120.0,
            color: Colors.grey[300],
          ),
        ],
      );

  Widget registerEmailAndPasswordInput() => Column(
        children: <Widget>[
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: 'Phone Number or email',
              fillColor: Colors.grey[100],
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 10),
          register
              ? TextField(
                  controller: firstNameController,
                  decoration: InputDecoration(
                    hintText: 'First Name',
                    fillColor: Colors.grey[100],
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                )
              : Container(
                  height: 0.0,
                  width: 0.0,
                ),
          SizedBox(height: 10),
          register
              ? TextField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                    hintText: 'Last Name',
                    fillColor: Colors.grey[100],
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                )
              : Container(
                  height: 0.0,
                  width: 0.0,
                ),
          SizedBox(height: 10),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              hintText: 'Password',
              fillColor: Colors.grey[100],
              filled: true,
              focusedBorder: InputBorder.none,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            keyboardType: TextInputType.visiblePassword,
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              print(
                  'Log in button clicked by ${firstNameController.text} ${lastNameController.text}');
              register
                  ? firebaseServices
                      .registerUserUsingEmainAndPassword(
                        emailController.text,
                        passwordController.text,
                        firstNameController.text,
                        lastNameController.text,
                      )
                      .then((FirebaseUser user) => print(user))
                  : firebaseServices
                      .loginWithEmailAndPassword(
                        emailController.text,
                        passwordController.text,
                      )
                      .then((FirebaseUser user) => print(user));
              emailController.text = '';
              firstNameController.text = '';
              lastNameController.text = '';
              passwordController.text = '';
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 145.0,
                vertical: 15.0,
              ),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                register ? 'Sign Up' : 'Log In',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: 'By signing up you agree to our\n',
                  style: TextStyle(color: Colors.grey),
                ),
                TextSpan(
                  text: 'Terms, Data policies ',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'and ',
                  style: TextStyle(color: Colors.grey),
                ),
                TextSpan(
                  text: 'Cookies\nPolicy',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: register ? 'Alredy a user? ' : 'New to Instagram! ',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                TextSpan(
                  text: register ? 'Log In' : 'Register',
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () {
                      print('Log In tapped!');
                      setState(() {
                        register = !register;
                      });
                    },
                  style: TextStyle(
                    color: Colors.blueGrey,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          )
        ],
      );
}
