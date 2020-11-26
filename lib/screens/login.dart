// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:quizzy/models/User.dart';
// import 'package:quizzy/notifier/authNotifier.dart';

// import 'HomeScreen.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   String _email, _password;
//   final auth = FirebaseAuth.instance;
//   User _user = User();
//   @override
//   void initState() {
//     Future<FirebaseUser> user = FirebaseAuth.instance.currentUser();
//     // AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);

//     user.then((FirebaseUser _user) {
//       if (_user == null) {
//         print("User is null");
//       } else {
//         // authNotifier.currentUser(_user);
//         print("User is not null , uid: ${_user.uid} email: ${_user.email}");
//       }
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Quizzy'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.fromLTRB(5, 30, 0, 0),
//               child: Text('Welcome to ',
//                   style: TextStyle(
//                       fontSize: 50,
//                       fontWeight: FontWeight.bold,
//                       // foreground: Paint()..shader = linearGradient,
//                       fontStyle: FontStyle.italic)),
//             ),
//             Container(
//               width: 225,
//               height: 140,
//               decoration: BoxDecoration(
//                   border: Border.all(
//                       width: 8,
//                       color: Theme.of(context).scaffoldBackgroundColor),
//                   image: DecorationImage(
//                       fit: BoxFit.cover,
//                       image: NetworkImage(
//                         "https://cdn.ilovefreesoftware.com/wp-content/uploads/2016/03/quizzlyfeatured.png",
//                       ))),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: InputDecoration(hintText: 'Email'),
//                   onChanged: (value) {
//                     setState(() {
//                       _email = value.trim();
//                     });
//                   }),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 obscureText: true,
//                 decoration: InputDecoration(hintText: 'password'),
//                 onChanged: (value) {
//                   setState(() {
//                     _password = value.trim();
//                   });
//                 },
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 RaisedButton(
//                   color: Theme.of(context).accentColor,
//                   child: Text('Login'),
//                   onPressed: () async {
//                     AuthResult authResult =
//                         await auth.signInWithEmailAndPassword(
//                             email: _email, password: _password);
//                     if (authResult != null) {
//                       FirebaseUser firebaseUser = authResult.user;

//                       if (firebaseUser != null) {
//                         print("Log In: $firebaseUser");
//                         authNotifier.setUser(firebaseUser);
//                       }
//                     }
//                     Navigator.of(context).pushReplacement(MaterialPageRoute(
//                       builder: (context) => HomeScreen(),
//                     ));
//                   },
//                 ),
//                 RaisedButton(
//                   color: Theme.of(context).accentColor,
//                   child: Text('Signup'),
//                   onPressed: () async {
//                     AuthResult authResult =
//                         await auth.createUserWithEmailAndPassword(
//                             email: _email, password: _password);
//                     if (authResult != null) {
//                       await Firestore.instance
//                           .collection('users')
//                           .document(authResult.user.uid)
//                           .setData({}, merge: true).then((value) async {
//                         print("resgisterd succesfully");
//                         FirebaseUser currentUser =
//                             await FirebaseAuth.instance.currentUser();
//                         authNotifier.setUser(currentUser);
//                         Navigator.of(context).pushReplacement(MaterialPageRoute(
//                           builder: (context) => HomeScreen(),
//                         ));
//                       }).catchError((err) {
//                         String errorCode = err.toString();
//                         print("got error $err");
//                       });
//                     }
//                   },
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/api/quizApi.dart';
import 'package:quizzy/const/Theme.dart';
import 'package:quizzy/models/User.dart';
import 'package:quizzy/screens/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../notifier/authNotifier.dart';

enum AuthMode { Signup, Login }

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = new TextEditingController();
  AuthNotifier authNotifier;
  AuthMode _authMode = AuthMode.Login;
  bool load = false;

  User _user = User();

  @override
  void initState() {
    Future<FirebaseUser> user = FirebaseAuth.instance.currentUser();
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    initializeCurrentUser(authNotifier);
    user.then((FirebaseUser _user) async {
      if (_user == null) {
        print("User is null");
      } else {
        await Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => HomeScreen()));
        print("User is not null , uid: ${_user.uid} email: ${_user.email}");
      }
    });
    super.initState();
  }

  void _submitForm() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_authMode == AuthMode.Login) {
      setState(() {
        load = true;
      });
      String result = await login(_user, authNotifier);
      setState(() {
        load = false;
      });
      if (result.compareTo("True") == 0) {
        await prefs.setBool('logined', true);
        print("Intialize AuthNotifier");
        await initializeCurrentUser(authNotifier);

        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        var snackBar = new SnackBar(
            content: new Text(result), backgroundColor: Colors.red);

        Scaffold.of(_formKey.currentContext).showSnackBar(snackBar);
      }
    } else {
      setState(() {
        load = true;
      });
      String result = await signup(_user, authNotifier);
      setState(() {
        load = false;
      });
      if (result.compareTo("True") == 0) {
        var snackBar = new SnackBar(
            content: new Text("Registered Succesfully, Login Now"),
            backgroundColor: Colors.teal);
        Scaffold.of(_formKey.currentContext).showSnackBar(snackBar);
      } else {
        var snackBar = new SnackBar(
            content: new Text(result), backgroundColor: Colors.red);
        Scaffold.of(_formKey.currentContext).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    authNotifier = Provider.of<AuthNotifier>(context);
    print("Building login screen");
    if (authNotifier.user != null) {
      print("Authno Notifier");
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          _authMode == AuthMode.Login ? 'Login' : 'Register',
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 1.0,
          ),
        ),
        elevation: 0.5,
      ),
      body: Container(
        // constraints: BoxConstraints.expand(
        //   height: MediaQuery.of(context).size.height,
        // ),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        // decoration: BoxDecoration(color: Colors.black),
        child: Form(
          autovalidate: true,
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 30),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.blue[50],
                      filled: true,
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.blue[150],
                      ),
                      hintText: "Email",
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Email is required';
                      }

                      if (!RegExp(
                              r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }

                      return null;
                    },
                    onSaved: (String value) {
                      _user.email = value.trim();
                    },
                    autofocus: true,
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.blue[50],
                      filled: true,
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.blue[150],
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                    obscureText: true,
                    controller: _passwordController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Password is required';
                      }

                      if (value.length < 5 || value.length > 20) {
                        return 'Password must be betweem 5 and 20 characters';
                      }

                      return null;
                    },
                    onSaved: (String value) {
                      _user.password = value.trim();
                    },
                  ),
                ),
                _authMode == AuthMode.Signup
                    ? Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: Colors.blue[50],
                            filled: true,
                            prefixIcon: Icon(
                              Icons.enhanced_encryption,
                              color: Colors.blue[150],
                            ),
                            hintText: "Confirm Password",
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                          obscureText: true,
                          validator: (String value) {
                            if (_passwordController.text != value) {
                              return 'Passwords do not match';
                            }

                            return null;
                          },
                        ),
                      )
                    : Container(),
                SizedBox(height: 20),
                ButtonTheme(
                  minWidth: 260,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    color: q_PrimaryColor,
                    padding: EdgeInsets.all(10.0),
                    onPressed: () => _submitForm(),
                    child: load
                        ? Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: LinearProgressIndicator(
                                backgroundColor: Colors.white,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.red),
                              ),
                            ),
                          )
                        : Text(
                            _authMode == AuthMode.Login ? 'Login' : 'Signup',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                _authMode == AuthMode.Signup
                    ? Container()
                    : Text(
                        'or',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18.0,
                        ),
                      ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${_authMode == AuthMode.Login ? 'Don\'t Have Account? ' : 'Have Account? '}',
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                    GestureDetector(
                      child: Text(
                        '${_authMode == AuthMode.Login ? 'Register' : 'Login'} Here',
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      ),
                      onTap: () {
                        setState(() {
                          _authMode = _authMode == AuthMode.Login
                              ? AuthMode.Signup
                              : AuthMode.Login;
                        });
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
