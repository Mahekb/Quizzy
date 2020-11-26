import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/api/quizApi.dart';
import 'package:quizzy/const/Theme.dart';
import 'package:quizzy/notifier/authNotifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';
// import 'package:settings_ui/pages/settings.dart';

class SettingsUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Setting UI",
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final auth = FirebaseAuth.instance;
  _clearUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('logined', false);
  }

  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: q_PrimaryColor,
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "https://image.flaticon.com/icons/png/512/64/64572.png",
                            ))),
                  ),
                  // Positioned(
                  //     bottom: 0,
                  //     right: 0,
                  //     child: Container(
                  //       height: 40,
                  //       width: 40,
                  //       decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         border: Border.all(
                  //           width: 4,
                  //           color: Theme.of(context).scaffoldBackgroundColor,
                  //         ),
                  //         color: Colors.lightBlue,
                  //       ),
                  //       child: Icon(
                  //         Icons.edit,
                  //         color: Colors.white,
                  //       ),
                  //     )),
                ],
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(5, 30, 0, 0),
              child: Text('Email-id',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Text(
              authNotifier.user.email,
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
              onTap: () {
                signout(authNotifier);

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => Login(),
                ));
                _clearUser();
              },
              child: Container(
                color: q_PrimaryColor,
                padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "LOG OUT",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: FlatButton(
            //         child: Text('Logout',
            //             style: TextStyle(
            //               fontSize: 50,
            //               fontWeight: FontWeight.bold,
            //             )),
            //         onPressed: () {
            //           auth.signOut();
            // Navigator.of(context).pushReplacement(MaterialPageRoute(
            //   builder: (context) => Login(),
            // ));
            //         },
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
