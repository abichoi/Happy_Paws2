// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'AddContact.dart';
import 'AddProfile.dart';
import 'ProfileDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  final title1_Home = const Text('Pet Profiles', style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),);
  final title2_Home = const Text('Contact', style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),);
  final margin = const EdgeInsets.only(bottom: 10.0, right: 10.0, left: 10.0);
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
        body:  Column(
          children: <Widget>[
            Container(
              // width: width,
              height: height/3,
              // color: Colors.green,
              child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row (
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: < Widget> [
                              const Text('Pet Profile', style: TextStyle(fontSize: 30.0, fontWeight:FontWeight.bold  ),),
                              IconButton(
                                icon: const Icon(Icons.add),
                                color: Colors.black,
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AddProfilePage()),);
                                  },
                                tooltip: 'Add Pet Profile',),
                            ]
                        ),
                        Expanded(
                          child: _PetProfileList(),
                        ),
                      ]
                  ),

            ),
            Expanded(
                child: Container(
                  width: width,
                  color: Colors.blueGrey,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row (
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: < Widget> [
                            const Text('Contact', style: TextStyle(fontSize: 30.0, fontWeight:FontWeight.bold  ),),
                            IconButton(
                              icon: const Icon(Icons.add),
                              color: Colors.black,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const addcontactpage()),
                                );
                              },
                              tooltip: 'Add Pet Profile',),
                          ]
                      )
                  ),
                )
            ),
          ]
      )
    );
  }
}
var petindex = 0;

  class _PetProfileList extends StatelessWidget {
  final _db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: StreamBuilder<QuerySnapshot>(
      stream: _db.collection('Pet_Profile').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, _index) {
              DocumentSnapshot _pet = snapshot.data!.docs[_index];
              return Card(
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    petindex = _index;
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfileDetailPage()));
                  },
                  child: Container(
                    width: 150,
                    child: Column(
                      children:<Widget>[
                        Image.network(_pet.get("img")),
                        Text(_pet.get("name")),
                      ]
                    ),
                  ),
                ),

              );
            },
          );
        }},
    ),
  );}
}



