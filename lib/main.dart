
import 'package:fireapp/screens/viewcontact.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'screens/home.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'contact',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const IntroScreen(),
    );
  }
}

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SplashScreen(
        // useLoader: true,
        // Padding: EdgeInsets.all(0),
         loadingText: const Text(""),
        navigateAfterSeconds:HomePage(),
        seconds: 5,
        title: const Text(
          'Welcome To my contact !',
          style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        image: Image.asset('images/logo.png', fit: BoxFit.scaleDown),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader:  const TextStyle(),
        photoSize: 100.0,
        onClick: () => print("flutter"),
        loaderColor: Colors.red);
  }
}















//======================================================================================================


// import 'signinpage.dart'
// import 'package:flutter/material.dart';
// import 'signuppage.dart';
// import 'homepage.dart';
// import 'package:firebase_core/firebase_core.dart';
//
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//
//   runApp(MyApp());
// }
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'firebase app',
//       theme: ThemeData(
//
//         primarySwatch: Colors.blue,
//       ),
//       home:  SigninPage(),
//       routes: <String ,WidgetBuilder>{
//         "/SigninPage" : (BuildContext context) =>  SigninPage(),
//          "/SignupPage" : (BuildContext context) => SignupPage(),
//
//       },
//     );
//   }
// }
//
