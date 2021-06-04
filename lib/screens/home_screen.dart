import 'package:MedAlert/widgets/member.dart';
import 'package:MedAlert/widgets/member_list.dart';
import 'package:flutter/material.dart';
import '../widgets/drawer.dart';
import './tabs_screen.dart';
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
        title: Text("Test 1"),
      ),
      drawer: AppDrawer(),
      floatingActionButton:  FloatingActionButton(
        onPressed: () {
           Navigator.of(context).pushNamed(NewMemberScreen.routeName);
        },
        child: const Icon(Icons.navigation),
        backgroundColor: Colors.green,
      ),
      body: (Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 45),
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: Image.asset('assets\\images\\jona.png'),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        child: Text("Ashley"),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[Text("Kavindu's Part Here")],
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Members'),
                  Divider(
                    thickness: 2,
                  ),
                  MemberList(),
                 
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
