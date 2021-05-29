import 'package:flutter/material.dart';
import '../widgets/drawer.dart';
import './tabs_screen.dart';

class HomeScreen extends StatefulWidget {
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
            children: <Widget>[
              Text("Kavindu's Part Here")
            ],
          ),
          SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Members'),
                Divider(
                  thickness: 2,
                ),
                InkWell(
                  onTap: () =>  Navigator.of(context).pushNamed(TabsScreen.routeName),
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Image.asset('assets\\images\\jona.png'),
                      ),
                      Text(
                        "Ashely Doe",
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
