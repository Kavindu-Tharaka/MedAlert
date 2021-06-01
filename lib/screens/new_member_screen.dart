import "package:flutter/material.dart";

class NewMemberScreen extends StatefulWidget {
  static const routeName = 'new_member';
  @override
  _NewMemberScreenState createState() => _NewMemberScreenState();
}

class _NewMemberScreenState extends State<NewMemberScreen> {
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
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Email Address"),
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Age"),
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Weight"),
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(13)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side: BorderSide(color: Colors.red)))),
                    onPressed: () => print('hello world'),
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
