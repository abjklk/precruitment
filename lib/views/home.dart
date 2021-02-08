import 'package:flutter/material.dart';
import 'package:precruitment/helper/authenticate.dart';
import 'package:precruitment/helper/helperfunctions.dart';
import 'package:precruitment/services/auth.dart';
import 'package:precruitment/views/alumini_screen.dart';
import 'package:precruitment/views/chatRoomsScreen.dart';
import 'package:precruitment/views/offers.dart';
import 'package:precruitment/views/search.dart';
import 'package:precruitment/views/temp_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    Offers(),
    ChatRoom(),
    Text('profile'),
    TempScreen(),
  ];

  List<FloatingActionButton> _fabOptions = <FloatingActionButton>[
    FloatingActionButton(
      onPressed: null,
      child: Icon(Icons.add),
    ),
    FloatingActionButton(
      onPressed: null,
      child: Icon(Icons.search),
    ),
    FloatingActionButton(
      onPressed: null,
    ),
    FloatingActionButton(
      onPressed: null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        child: _fabOptions.elementAt(_currentIndex),
        onTap: () {
          if (_currentIndex == 0) {
            print("I pressed add offer");
          } else if (_currentIndex == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SearchScreen()));
          }
        },
      ),
      appBar: AppBar(
        title: Text("Precruitment"),
        actions: [
          GestureDetector(
            onTap: () {
              AuthMethods().signOut();
              HelperFunctions.saveUserLoggedInSharedPreference(false);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Authenticate(),
                ),
              );
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app)),
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_currentIndex),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _currentIndex,
      //   onTap: (value) {
      //     setState(() {
      //       _currentIndex = value;
      //     });
      //   },
      //   type: BottomNavigationBarType.fixed,

      //   backgroundColor: Colors.blue,
      //   selectedItemColor: Colors.white,
      //   unselectedItemColor: Colors.white.withOpacity(.60),
      //   // selectedFontSize: 15,
      //   // unselectedFontSize: 10,
      //   items: [
      //     BottomNavigationBarItem(
      //       label: "Offers",
      //       icon: Icon(Icons.notes),
      //     ),
      //     BottomNavigationBarItem(label: "Chat", icon: Icon(Icons.chat)),
      //     BottomNavigationBarItem(label: "Profile", icon: Icon(Icons.face)),
      //   ],
      // ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                child: Icon(Icons.face),
                onTap: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
              ),
              GestureDetector(
                child: Icon(Icons.ac_unit),
                onTap: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),
              GestureDetector(
                child: Icon(Icons.g_translate),
                onTap: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
              ),
              GestureDetector(
                child: Icon(Icons.pages),
                onTap: () {
                  setState(() {
                    _currentIndex = 3;
                  });
                },
              ),
            ],
          ),
        ),
        shape: CircularNotchedRectangle(),
        // color: Colors.blueGrey,
      ),
    );
  }
}
