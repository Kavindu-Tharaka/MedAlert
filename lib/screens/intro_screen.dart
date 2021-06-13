import  '../screens/home_screen.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 80, bottom: 15, right: 10, left: 10),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'assets\\images\\WelcomeScreanImage.png',
                  fit: BoxFit.contain,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: "Name",
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 3, color: Colors.green),
                              borderRadius: BorderRadius.circular(15),
                            )),
                      ),
                      // Checkbox(),
                      SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.symmetric(
                                        horizontal: 45, vertical: 10)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        side: BorderSide(color: Colors.blue)))),
                            onPressed: () =>  Navigator.of(context).pushNamed(HomeScreen.routeName),
                            child: Text('Get Started'),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
