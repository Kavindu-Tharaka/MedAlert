import 'package:MedAlert/db/database_helper.dart';
import 'package:flutter/material.dart';
import '../screens/tabs_screen.dart';
import '../model/member.dart';

class MemberProfile extends StatefulWidget {
  final Member member;
  MemberProfile(this.member);

  @override
  _MemberProfileState createState() => _MemberProfileState();
}

class _MemberProfileState extends State<MemberProfile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(TabsScreen.routeName, arguments: widget.member),
      onLongPress: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Delete Member'),
          content:
              Text("Do you want to delete this member ${widget.member.name}"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async => {
                await MedicineDatabase.instance.deleteMember(widget.member.id),
                Navigator.pop(context, "Delete")
              },
              child: const Text('Delete'),
            ),
          ],
        ),
      ),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 45,
            backgroundColor: Colors.white,
            child: Image.network(
                'https://ui-avatars.com/api/?size=128&rounded=true&background=random&name=' +
                    widget.member.name),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            widget.member.name,
            style: TextStyle(fontSize: 14),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          )
        ],
      ),
    );
  }
}
