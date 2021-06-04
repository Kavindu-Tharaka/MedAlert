import 'package:flutter/material.dart';
import '../screens/tabs_screen.dart';

class MemberProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(TabsScreen.routeName),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 45,
            backgroundColor: Colors.white,
            child: Image.asset('assets\\images\\jona.png'),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            "Ashely Doess",
            style: TextStyle(fontSize: 10),
          )
        ],
      ),
    );
  }
}
