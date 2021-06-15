import 'package:MedAlert/widgets/member_list.dart';
import 'package:flutter/material.dart';
import '../widgets/drawer.dart';
import './new_member_screen.dart';

class HomeScreen extends StatefulWidget {
  static final routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(null),
        actions: [
          Image.asset(
            'assets\\images\\MedAlert_Logo.png',
            height: 20,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(NewMemberScreen.routeName);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: (Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Members',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[850],
                        fontSize: 40,
                      )),
                  Divider(),
                  SizedBox(
                    height: 25,
                  ),
                  MemberList(),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
