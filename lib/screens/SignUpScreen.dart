import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Register Here",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0.7,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 5.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: 'Email Address',
                ),
                onSaved: (String value) {},
                validator: (String value) {},
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  icon: Icon(Icons.security),
                  labelText: 'Password',
                ),
                onSaved: (String value) {},
                validator: (String value) {
                  return null;
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  icon: Icon(Icons.security),
                  labelText: 'Confirm Password',
                ),
                onSaved: (String value) {},
                validator: (String value) {
                  return null;
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                onPressed: () => null,
                child: Text(
                  'Sign Up',
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              RichText(
                text: TextSpan(
                  text: 'Already Have an Account ? ',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Login Here',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print("going to sign in screen");
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
