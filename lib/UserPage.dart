import 'package:flutter/material.dart';
import 'Login.dart';
import 'authentication.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}


class _UserPageState extends State<UserPage> {
  static const TextStyle leftdetailstyle =
  TextStyle(fontSize:18, fontWeight: FontWeight.bold, color: Colors.black);
  static const TextStyle rightdetailstyle =
  TextStyle(fontSize:18,fontWeight: FontWeight.normal, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Icon(
                FontAwesomeIcons.solidCircleUser,
                color: Colors.black,
                size: 100,
                )),
              const Text('Email:',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize:18,
                    fontWeight: FontWeight.bold,
                  color: Colors.black
              )),
              Text(useremail,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize:18,
                    fontWeight: FontWeight.normal,
                    color: Colors.black
                ),
            ),
              ElevatedButton(
                onPressed: () {
                    AuthenticationHelper().signOut();
                    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false,);
                      },
                child: const Text('Sign Out'),
              ),

            ]
        )
        )


    );

  }
}



