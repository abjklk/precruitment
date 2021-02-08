import 'package:flutter/material.dart';
import 'package:precruitment/views/temp_screen.dart';

class OfferTile extends StatelessWidget {
  final String companyName;
  final String role;
  final String deadline;
  final String cgpa;

  OfferTile({this.companyName, this.role, this.deadline, this.cgpa});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              print("Clicked offer");
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 10.0),
              constraints: BoxConstraints.expand(),
              child: Container(
                margin: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 4.0),
                    //Company name
                    Text(
                      this.companyName,
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.w600),
                    ),
                    new Container(height: 10.0),
                    // Role
                    new Text(this.role),
                    new Container(
                        margin: new EdgeInsets.symmetric(vertical: 8.0),
                        height: 2.0,
                        width: 18.0,
                        color: new Color(0xff00c6ff)),
                    new Row(
                      children: <Widget>[
                        Icon(
                          Icons.access_alarm,
                          size: 14.0,
                        ),
                        new Container(width: 8.0),
                        // Deadline
                        new Text(this.deadline),
                        new Container(width: 24.0),
                        Icon(
                          Icons.score,
                          size: 14.0,
                        ),
                        new Container(width: 8.0),
                        // CGPA
                        new Text(this.cgpa),
                      ],
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                // color: new Color(0xFF333366),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8.0),
                // boxShadow: <BoxShadow>[
                //   new BoxShadow(
                //     color: Colors.black12,
                //     blurRadius: 10.0,
                //     offset: new Offset(0.0, 10.0),
                //   ),
                // ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16.0),
            alignment: FractionalOffset.centerLeft,
            child: Image.asset("assets/images/google.png"),
            height: 92.0,
            width: 92.0,
          )
        ],
      ),
    );
  }
}

class Offers extends StatefulWidget {
  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  Widget offersList() {
    return ListView(
      children: [
        OfferTile(
          cgpa: "10",
          companyName: "hubli",
          deadline: "123",
          role: "bb",
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return offersList();
  }
}
