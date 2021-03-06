import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:precruitment/helper/helperfunctions.dart';
import 'package:precruitment/services/auth.dart';
import 'package:precruitment/services/database.dart';
import 'package:precruitment/views/home.dart';
import 'package:precruitment/widgets/dialogs.dart';
import 'package:precruitment/widgets/widget.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isLoading = false;
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formkey = GlobalKey<FormState>();
  final loadkey = GlobalKey<State>();

  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  QuerySnapshot snapshotUserInfo;

  signIn() {
    if (formkey.currentState.validate()) {
      Dialogs.showLoadingDialog(context, loadkey); //here

      HelperFunctions.saveUserEmailSharedPreference(
          emailTextEditingController.text);

      databaseMethods
          .getUserByEmail(emailTextEditingController.text)
          .then((val) {
        snapshotUserInfo = val;
        HelperFunctions.saveUserNameSharedPreference(
            snapshotUserInfo.docs[0].data()["name"]);
      });

      setState(() {
        isLoading = true;
      });

      authMethods
          .signInWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((value) {
        if (value != null) {
          Navigator.of(loadkey.currentContext, rootNavigator: true)
              .pop(); //here
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              // builder: (context) => ChatRoom(),
              builder: (context) => Home(),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                  .hasMatch(val)
                              ? null
                              : "Bad Email";
                        },
                        controller: emailTextEditingController,
                        decoration: InputDecoration(
                          hintText: "email",
                        ),
                      ),
                      TextFormField(
                        obscureText: true,
                        validator: (val) {
                          return val.length < 6 ? "Invalid Password" : null;
                        },
                        controller: passwordTextEditingController,
                        decoration: InputDecoration(
                          hintText: "password",
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text("Forgot Password?"),
                        ),
                      ),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          signIn();
                        },
                        child: RaisedButton(
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: null,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Dont have an account? "),
                          GestureDetector(
                            onTap: () {
                              widget.toggle();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                "Create An Account.",
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 150),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
