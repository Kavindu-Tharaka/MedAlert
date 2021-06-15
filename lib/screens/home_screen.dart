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
        actions: [
          Image.asset(
            'assets\\images\\MedAlert_Logo.png',
            height: 20,
          ),
        ],
      ),
      drawer: AppDrawer(),
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
            // Container(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: <Widget>[
            //       Container(
            //         margin: EdgeInsets.symmetric(vertical: 40),
            //         child: Column(
            //           children: <Widget>[
            //             CircleAvatar(
            //               radius: 50,
            //               backgroundColor: Colors.white,
            //               child: Image.asset('assets\\images\\jona.png'),
            //             ),
            //             Container(
            //               margin: EdgeInsets.symmetric(vertical: 15),
            //               child: Text("Ashley"),
            //             )
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('My Members',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.black54,fontSize: 28.0,)),
                  Divider(
                    thickness: 2,
                  ),
                  SizedBox(height: 25,),
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
