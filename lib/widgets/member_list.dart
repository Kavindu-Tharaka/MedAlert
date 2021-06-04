import 'package:flutter/material.dart';
import '../widgets/member.dart';
import '../screens/tabs_screen.dart';
import '../screens/new_member_screen.dart';

class MemberList extends StatefulWidget {
  @override
  _MemberListState createState() => _MemberListState();
}

class _MemberListState extends State<MemberList> {
  final memberList = [
    {'id': '1', 'name': 'Saman', 'age': '30', 'weight': '24'},
    {'id': '1', 'name': 'Saman', 'age': '30', 'weight': '24'},
    {'id': '1', 'name': 'Saman', 'age': '30', 'weight': '24'},
    {'id': '1', 'name': 'Saman', 'age': '30', 'weight': '24'},
    {'id': '1', 'name': 'Saman', 'age': '30', 'weight': '24'},
    {'id': '1', 'name': 'Saman', 'age': '30', 'weight': '24'},
    {'id': '1', 'name': 'Saman', 'age': '30', 'weight': '24'},
    {'id': '1', 'name': 'Saman', 'age': '30', 'weight': '24'},
    {'id': '1', 'name': 'Saman', 'age': '30', 'weight': '24'},
    
  ];
 

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 120.0,
              child: ListView(
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: memberList.map((member) => MemberProfile()).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
