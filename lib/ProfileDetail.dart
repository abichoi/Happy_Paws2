// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/foundation.dart';
import 'Homepage.dart';
import 'dart:io';
// import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'EditProfile.dart';
import 'Vaccinepage.dart';

class ProfileDetailPage extends StatefulWidget {
  @override
  _ProfileDetailPageState createState() => _ProfileDetailPageState();
}
String petdocid = '';
List petvaccinelist = [];

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  final _db = FirebaseFirestore.instance;
  static const TextStyle leftdetailstyle =
  TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  static const TextStyle rightdetailstyle =
  TextStyle(fontSize: 20, fontWeight: FontWeight.normal);


    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
              title: const Text("Pet Profile"),
              elevation: 0,
              flexibleSpace: Container(
                decoration:  const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF4F60FF), Color(0xFF24DEEA)],
                  ),
                ),
              )
          ),
          body:
                StreamBuilder<QuerySnapshot>(
                    stream: _db.collection('Pet_Profile').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        DocumentSnapshot _pet = snapshot.data!.docs[petindex];
                        petdocid = snapshot.data!.docs[petindex].reference.id;
                        petvaccinelist = _pet.get("Vaccine");
                        print("petvaccinelist");
                        print(petvaccinelist);
                        print(petvaccinelist.length);
                        print(petvaccinelist[0]);
                        print(petvaccinelist[0]["enddate"]);
                        // petvaccinelist.forEach((element) {
                        //   print("printlist");
                        //   print(element);
                        //   print(element["enddate"]);
                        // });
                        return ListView(
                                    children: [
                                      Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Image.network(
                                            _pet.get("img"),
                                            width: 300,
                                            height: 150,
                                          )
                                      ),
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children:<Widget>[
                                            Column(
                                                children: <Widget>[
                                                  IconButton(
                                                    icon: const Icon(Icons.vaccines_outlined),
                                                    iconSize: 80,
                                                    tooltip: 'Add or Edit Vaccine Record',
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (_) => VaccinePage()),
                                                      );
                                                    },
                                                  ),
                                                  const Text('Vaccine Record')
                                                ]),
                                            Column(
                                                children: <Widget>[
                                                  IconButton(
                                                    icon: const Icon(Boxicons.bx_file),
                                                    iconSize: 80,
                                                    tooltip: 'Add or Edit Medical Record',
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (_) => HomePage()),
                                                      );
                                                      },
                                                  ),
                                                  const Text('Medical Record')
                                                ]),
                                            Column(
                                                children: <Widget>[
                                                  IconButton(
                                                    icon: const Icon(Icons.sticky_note_2_outlined),
                                                    iconSize: 80,
                                                    tooltip: 'Add or Edit Notes',
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (_) => HomePage()),
                                                      );
                                                    },
                                                  ),
                                                  const Text('Notes')
                                                ])
                                          ]),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton(
                                          icon: const Icon(Icons.mode_edit_outline_outlined ),
                                          iconSize: 30,
                                          tooltip: 'Edit Pet Profile',
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (_) => EditProfilePage()),
                                            );
                                            },
                                        ),
                                      ),

                                      const Divider(
                                        color: Colors.black,
                                      ),
                                      Row(
                                          children:<Widget>[
                                            const Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Text('Name',style: leftdetailstyle,)
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(left: 93.0),
                                                child: Text(_pet.get("name"),style: rightdetailstyle,)
                                            ),
                                          ]),
                                      const Divider(
                                        color: Colors.black,
                                      ),
                                      Row(
                                          children:<Widget>[
                                            const Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Text('Species',style: leftdetailstyle,)
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(left: 75.0),
                                                child: Text(_pet.get("species"),style: rightdetailstyle,)
                                            ),
                                          ]),
                                      const Divider(
                                        color: Colors.black,
                                      ),
                                      Row(
                                          children:<Widget>[
                                            const Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Text('Breed',style: leftdetailstyle,)
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(left: 95.0),
                                                child: Text(_pet.get("breed"),style: rightdetailstyle,)
                                            ),
                                          ]),
                                      const Divider(
                                        color: Colors.black,
                                      ),
                                      Row(
                                          children:<Widget>[
                                            const Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Text('Sex',style: leftdetailstyle,)
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(left: 117.0),
                                                child: Text(_pet.get("sex"),style: rightdetailstyle,)
                                            ),
                                          ]),
                                      const Divider(
                                        color: Colors.black,
                                      ),
                                      Row(
                                          children:<Widget>[
                                            const Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Text('Color',style: leftdetailstyle,)
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(left: 100.0),
                                                child: Text(_pet.get("color"),style: rightdetailstyle,)
                                            ),
                                          ]),
                                      const Divider(
                                        color: Colors.black,
                                      ),
                                      Row(
                                          children:<Widget>[
                                            const Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Text('Date of Birth',style: leftdetailstyle,)
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(left: 33.0),
                                                child: Text(_pet.get("dob"),style: rightdetailstyle,)
                                            ),
                                          ]),
                                      const Divider(
                                        color: Colors.black,
                                      ),
                                      Row(
                                          children:<Widget>[
                                            const Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Text('Veterinarian',style: leftdetailstyle,)
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(left: 40.0),
                                                child: Text(_pet.get("vet"),style: rightdetailstyle,)
                                            ),
                                          ]),
                                      const Divider(
                                        color: Colors.black,
                                      ),

                                    ]
                                );



                      }
                      },
                    )

          );

    }
}



