import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class InstaLoginAndRegister extends StatelessWidget {
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
            decoration: InputDecoration(
              hintText: 'Phone Number or email',
              fillColor: Colors.grey[100],
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              hintText: 'First Name',
              fillColor: Colors.grey[100],
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              hintText: 'Last Name',
              fillColor: Colors.grey[100],
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              hintText: 'Password',
              fillColor: Colors.grey[100],
              filled: true,
              focusedBorder: InputBorder.none,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () => print('Log in button clicked'),
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
                'Sign Up',
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
                  text: 'Alredy a user? ',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                TextSpan(
                  text: 'Log In',
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
