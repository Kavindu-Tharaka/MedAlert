import 'package:MedAlert/db/database_helper.dart';
import 'package:MedAlert/model/member.dart';
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
      weight: int.parse(memberWeight.text)

    );

    await MedicineDatabase.instance.createMember(mbr);
    final r = await MedicineDatabase.instance.readAllMembers();
    r.map((e) => print(e));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Member"),
      ),
      body: Padding(
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
              TextFormField(
                decoration: InputDecoration(hintText: "Name"),
                controller: memberName,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Email Address"),
                controller: memberEmail,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Age"),
                controller: memberAge,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Weight"),
                controller: memberWeight,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(13)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side: BorderSide(color: Colors.red)))),
                    onPressed: addNewMember,
                    child: Text('Add Member'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
