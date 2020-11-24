import 'package:flutter/material.dart';
import 'package:quizzy/const/Theme.dart';
import 'package:quizzy/screens/AddQuizScreen.dart';
import 'package:quizzy/screens/SignUpScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime now = new DateTime.now();

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  TextStyle noStyle = TextStyle(
    fontSize: 35,
    fontWeight: FontWeight.bold,
    color: q_green,
  );

  TextStyle titleStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: q_PrimaryColor,
        title: Text(
          "Quizzy",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
            ),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dns,
            ),
            label: 'Quizes',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: q_PrimaryColor,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //add quizes
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddQuizScreen()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: q_PrimaryColor,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 5.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Image.asset(
                      "assets/images/quiz1.png",
                      height: 90.0,
                    ),
                    Text("See Tests"),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      "assets/images/quiz2.png",
                      height: 90.0,
                    ),
                    Text("Take Tests"),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      "assets/images/quiz3.png",
                      height: 90.0,
                    ),
                    Text("Get Result"),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 25.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Result",
                  style: titleStyle,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        7.0,
                      ), //
                    ),
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.,
                    children: [
                      Expanded(
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: q_PrimaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(80)),
                              ),
                            ),
                            Text(
                              "100%",
                              style: titleStyle,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              now.day.toString() +
                                  "-" +
                                  now.month.toString() +
                                  "-" +
                                  now.year.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "fwkue\nerufheur\nkefhwi",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25.0,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text(
                        "Total",
                        style: titleStyle,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "77",
                        style: noStyle,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text(
                        "Completed",
                        style: titleStyle,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "07",
                        style: noStyle,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text(
                        "Ongoing",
                        style: titleStyle,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "01",
                        style: noStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25.0,
            ),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                    decoration: BoxDecoration(
                      color: Colors.grey[350],
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          7.0,
                        ), //
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Done Quizes",
                          style: titleStyle,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Icon(
                          Icons.assignment_turned_in,
                          size: 40,
                          color: q_PrimaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                    decoration: BoxDecoration(
                      color: Colors.grey[350],
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          7.0,
                        ), //
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Incoming Quizes",
                          style: titleStyle,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Icon(
                          Icons.calendar_today,
                          size: 40,
                          color: q_PrimaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
