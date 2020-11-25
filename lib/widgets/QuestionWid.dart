import 'package:flutter/material.dart';

class QuestionWid extends StatefulWidget {
  final dynamic data;
  QuestionWid({Key key, this.data}) : super(key: key);

  @override
  _QuestionWidState createState() => _QuestionWidState(data);
}

enum SingingCharacter { option1, option2, option3, option4 }

class _QuestionWidState extends State<QuestionWid> {
  _QuestionWidState(data);
  dynamic data;

  SingingCharacter _character = SingingCharacter.option1;

  @override
  Widget build(BuildContext context) {
    print("\n**********\n");
    print(data);
    print("\n**********\n");
    return Container(
      child: Column(
        children: [
          Text(
            data["questionWidStatement"],
            // style: titleStyle,
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text(
              data["optionList"][0],
            ),
            leading: Radio(
              value: SingingCharacter.option1,
              groupValue: _character,
              onChanged: (SingingCharacter value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text(
              data["optionList"][1],
            ),
            leading: Radio(
              value: SingingCharacter.option2,
              groupValue: _character,
              onChanged: (SingingCharacter value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text(
              data["optionList"][2],
            ),
            leading: Radio(
              value: SingingCharacter.option3,
              groupValue: _character,
              onChanged: (SingingCharacter value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text(
              data["optionList"][3],
            ),
            leading: Radio(
              value: SingingCharacter.option4,
              groupValue: _character,
              onChanged: (SingingCharacter value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
