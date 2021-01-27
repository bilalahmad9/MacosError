import 'package:aidols/API/auth.dart';
import 'package:aidols/Extra/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splashscreen/splashscreen.dart';
import 'UI/profile.dart';
import 'UI/login_screen.dart';
import 'Extra/transition_route_observer.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor:
          SystemUiOverlayStyle.dark.systemNavigationBarColor,
    ),
  );
  runApp(AfterSplash());
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      theme: ThemeData(
        // primaryColor: Color.fromRGBO(48, 127, 226, 1),
        primaryColor: Colors.grey[800],
        textTheme: TextTheme(
          display2: GoogleFonts.righteous(color: Colors.white, fontSize: 45),
          button: GoogleFonts.righteous(),
          caption: GoogleFonts.righteous(
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            color: Color.fromRGBO(48, 127, 226, 1),
          ),
          display4: GoogleFonts.righteous(),
          display3: GoogleFonts.righteous(),
          display1: GoogleFonts.righteous(),
          headline: GoogleFonts.righteous(),
          title: GoogleFonts.righteous(),
          subhead: GoogleFonts.righteous(),
          body2: GoogleFonts.righteous(),
          body1: GoogleFonts.righteous(),
          subtitle: GoogleFonts.righteous(),
          overline: GoogleFonts.righteous(),
        ),
      ),
      home: MyApp(),
      navigatorObservers: [TransitionRouteObserver()],
      routes: {
        MyApp.routeName: (context) => MyApp(),
        LoginScreen.routeName: (context) => LoginScreen(),
        ProfilePage.routeName: (context) => ProfilePage(),
      },
    );
  }
}

class MyApp extends StatefulWidget {
  static const routeName = '/app';
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Constants.loginTime).then(
      (_) async {
        Accounts.checkUser().then(
          (value) => !value
              ? Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen(),
                  ),
                )
              : Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => ProfilePage(),
                  ),
                ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 20,
      title: new Text(
        'Welcome To Aidols',
        style: GoogleFonts.righteous(fontSize: 20.0, color: Colors.white),
      ),
      image: new Image.asset('assets/images/logo.png'),
      backgroundColor: Colors.grey[800],
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      loaderColor: Color.fromRGBO(48, 127, 226, 1),
    );
  }
}
