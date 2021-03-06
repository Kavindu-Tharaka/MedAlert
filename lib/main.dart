import 'package:MedAlert/screens/medicine_update_page.dart';
import 'package:flutter/material.dart';
import './screens/new_member_screen.dart';
import './screens/home_screen.dart';
import './screens/tabs_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';
import './screens/intro_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Flutter',
      theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Color(0XFF008bb0),
          canvasColor: Colors.white,
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              title: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold))),
      home: AnimatedSplashScreen(
        splash: Image.asset(
          'assets\\images\\WelcomeScreanImage.png',
          fit: BoxFit.contain,
          height: double.infinity,
          width: double.infinity,
        ),
        nextScreen: Splash(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.white,
        duration: 3500,
      ),
      routes: {
        HomeScreen.routeName: (ctx) => HomeScreen(),
        TabsScreen.routeName: (ctx) => TabsScreen(),
        NewMemberScreen.routeName: (ctx) => NewMemberScreen(),
        MedicineUpdatePage.routeName: (ctx) => MedicineUpdatePage()
      },
    );
  }
}

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => IntroScreen()));

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => IntroScreen()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: Image.asset(
          'assets\\images\\splash.gif',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
