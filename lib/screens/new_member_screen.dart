import 'package:MedAlert/db/database_helper.dart';
import 'package:MedAlert/model/member.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

class NewMemberScreen extends StatefulWidget {
  static const routeName = 'new_member';
  @override
  _NewMemberScreenState createState() => _NewMemberScreenState();
}

class _NewMemberScreenState extends State<NewMemberScreen> {
  TextEditingController memberName = TextEditingController();
  TextEditingController memberEmail = TextEditingController();
  TextEditingController memberAge = TextEditingController();
  TextEditingController memberWeight = TextEditingController();

  Future addNewMember() async {
    // print(memberName.text);
    // print(memberEmail.text);
    // print(memberAge.text);
    // print(memberWeight.text);

    final mbr = Member(
        name: memberName.text,
        email: memberEmail.text,
        memberAge: int.parse(memberAge.text),
        weight: int.parse(memberWeight.text),
        me : false
        );

    await MedicineDatabase.instance.createMember(mbr);
    Navigator.pop(context);
  }


  


  Widget buildMedicineName(controller, label, keyboardType) => TextFormField(
        onEditingComplete: () {
          FocusScope.of(context).nextFocus();
        },
        autofocus: false,
        controller: controller,
        maxLines: 1,
        keyboardType: keyboardType,
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10.0),
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 15,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide:
                BorderSide(color: Colors.black, style: BorderStyle.solid),
          ),
          hintText: label,
          hintStyle: TextStyle(color: Colors.white70),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Can not be empty!';
          }
          return null;
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Member"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 30),
          child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      child: Icon(Icons.add_photo_alternate_rounded),
                      radius: 50,
                    )
                  ],
                ),
                SizedBox(height: 20),
                buildMedicineName(
                    memberName, "Member name", TextInputType.text),
                SizedBox(height: 20),
                buildMedicineName(
                    memberEmail, "Email", TextInputType.emailAddress),
                SizedBox(height: 20),
                buildMedicineName(memberAge, "Age", TextInputType.number),
                SizedBox(height: 20),
                buildMedicineName(memberWeight, "Weight", TextInputType.number),
                SizedBox(height: 20),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0XFF008bb0)),
                      ),
                      onPressed: () {
                        addNewMember();
                      },
                      child: Text('ADD')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
