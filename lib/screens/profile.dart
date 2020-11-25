import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.lightBlue,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.lightBlue,
            ),
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => SettingsPage()));
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
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
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.lightBlue,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              // children: [
              Container(
                padding: EdgeInsets.fromLTRB(5, 30, 0, 0),
                child: Text('Email-id',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        // foreground: Paint()..shader = linearGradient,
                        fontStyle: FontStyle.italic)),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5, 60, 0, 0),
                child: Text(
                  '',
                ),
              ),

              //Saurabh iske badle databse se email id lena he
              buildTextField("", "samkit@gmail.com", false),

              // buildTextField("E-mail", "", false),
              // buildTextField("Password", "", true),
              SizedBox(
                height: 35,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5, 60, 0, 0),
                child: Text(
                  '',
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: FlatButton(
                      child: Text('Logout',
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          )),
                      onPressed: () {
                        auth.signOut();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}

// Row(
//               children: [
//                 Expanded(
//                   child: FlatButton(
//                     child: Text('Logout',
//                         style: TextStyle(
//                           fontSize: 50,
//                           fontWeight: FontWeight.bold,
//                         )),
//                     onPressed: () {
//                       auth.signOut();
//                       Navigator.of(context).pushReplacement(MaterialPageRoute(
//                         builder: (context) => LoginScreen(),
//                       ));
//                     },
//                   ),
//                 ),
//               ],
//             ),
