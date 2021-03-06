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
        weight: int.parse(memberWeight.text));

    await MedicineDatabase.instance.createMember(mbr);

    memberName.text = "";
    memberEmail.text = "";
    memberWeight.text = "";
    memberAge.text = "";
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            Image.asset(
              'assets\\images\\MedAlert_Logo.png',
              height: 20,
            ),
          ],
        ),
        body: Builder(builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 30),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Add Member',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[850],
                          fontSize: 40,
                        )),
                    Divider(),
                    SizedBox(height: 20),
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
                    buildMedicineName(
                        memberWeight, "Weight", TextInputType.number),
                    SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            )),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0XFF008bb0)),
                          ),
                          onPressed: () {
                            addNewMember();
                            SnackBar snck = SnackBar(
                              content: Text('New Member Added'),
                            );
                            Scaffold.of(context).showSnackBar(snck);
                          },
                          child: Text('ADD')),
                    )
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
