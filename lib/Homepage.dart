// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'AddContact.dart';
import 'AddProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class _HomePageWidget extends StatefulWidget {
  const _HomePageWidget({Key? key}) : super(key: key);

  @override
  State<_HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<_HomePageWidget>{
  final title1_Home = const Text('Pet Profiles', style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),);
  final title2_Home = const Text('Contact', style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),);
  final margin = const EdgeInsets.only(bottom: 10.0, right: 10.0, left: 10.0);
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
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
    );
  }
}

  class _PetProfileList extends StatelessWidget {
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: StreamBuilder<QuerySnapshot>(
      stream: db.collection('Pet_Profile').snapshots(),
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
            itemBuilder: (context, index) {
              DocumentSnapshot _pet = snapshot.data!.docs[index];
              return Card(
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    debugPrint('Card tapped.');
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



class HomePage extends StatelessWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomePageWidget(),
    );
  }
}