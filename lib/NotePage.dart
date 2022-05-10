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
import 'ProfileDetail.dart';
import 'AddMecRec.dart';
import 'Vaccinepage.dart';
import 'MedRecPage.dart';
import 'AddNote.dart';

class NotePage extends StatefulWidget {
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final _db = FirebaseFirestore.instance;
  static const TextStyle rightdetailstyle =
  TextStyle(fontSize:18,fontWeight: FontWeight.normal, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Note"),
            elevation: 0,
            flexibleSpace: Container(
              decoration:  const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFAA24EA), Color(0xFFFFA34F)],
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
                                  tooltip: 'Vaccine Record',
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
                                  tooltip: 'Add Medical Record',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => MedRecPage()),
                                    );
                                  },
                                ),
                                const Text('Medical Record')
                              ]),
                          Column(
                              children: <Widget>[
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  iconSize: 80,
                                  tooltip: 'Add Notes',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => AddNotePage()),
                                    );
                                  },
                                ),
                                const Text('Add Notes')
                              ])
                        ]),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: petnotelist.length,
                      itemBuilder: (context, _index) {
                        var _noteitem = petnotelist[_index];
                        return Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                            elevation: 3,
                            shadowColor: Colors.black,
                            child: ListTile(
                                title: Row (
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:[
                                      Text(_noteitem["date"], style: const TextStyle(fontSize:25, fontWeight: FontWeight.bold)),
                                      IconButton(
                                        icon: const Icon(Icons.delete_outline ),
                                        iconSize: 30,
                                        tooltip: 'Delete this record',
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection('Pet_Profile').doc(petdocid).update({'Note':FieldValue.arrayRemove([petnotelist[_index]])});
                                        },
                                      ),
                                    ]
                                ),
                                subtitle:
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(_noteitem["note"],style: rightdetailstyle,),

                                    ]
                                )

                            ));
                      },
                    )
                  ]
              );
            }
          },
        )

    );

  }
}



