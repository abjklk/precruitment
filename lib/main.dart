//hello
import 'package:flutter/material.dart';
// import 'package:precruitment/views/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:precruitment/helper/authenticate.dart';
import 'package:precruitment/helper/helperfunctions.dart';
// import 'package:precruitment/views/chatRoomsScreen.dart';
import 'package:precruitment/views/home.dart';
// import 'package:precruitment/views/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn = false;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        if (value != null) {
          userIsLoggedIn = value;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(userIsLoggedIn);
    return MaterialApp(
      title: 'Precruitment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: userIsLoggedIn ? Home() : Authenticate(),
    );
  }
}

// class IamBlank extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
