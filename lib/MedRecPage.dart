import 'package:flutter/material.dart';
import 'Homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ProfileDetail.dart';
import 'AddMecRec.dart';
import 'Vaccinepage.dart';
import 'NotePage.dart';
import 'authentication.dart';

class MedRecPage extends StatefulWidget {
  @override
  _MedRecPageState createState() => _MedRecPageState();
}

class _MedRecPageState extends State<MedRecPage> {
  final _db = FirebaseFirestore.instance;
  static const TextStyle leftdetailstyle =
  TextStyle(fontSize:18, fontWeight: FontWeight.bold, color: Colors.black);
  static const TextStyle rightdetailstyle =
  TextStyle(fontSize:18,fontWeight: FontWeight.normal, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Mecdical Record"),
            elevation: 0,
            flexibleSpace: Container(
              decoration:  const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFFFA34F), Color(0xFF24EA73)],
                ),
              ),
            )
        ),
        body:
        StreamBuilder<QuerySnapshot>(
          stream: _db.collection("user").doc(userId).collection('Pet_Profile').snapshots(),
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
                                  icon: const Icon(Icons.add),
                                  iconSize: 80,
                                  tooltip: 'Add Medical Record',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => AddMedRecPage()),
                                    );
                                  },
                                ),
                                const Text('Add Medical Record')
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
                                      MaterialPageRoute(builder: (_) => NotePage()),
                                    );
                                  },
                                ),
                                const Text('Notes')
                              ])
                        ]),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: petmedreclist.length,
                      itemBuilder: (context, _index) {
                        var _medrecitem = petmedreclist[_index];
                        return Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                            elevation: 3,
                            shadowColor: Colors.black,
                            child: ListTile(
                                title: Row (
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:[
                                      Text(_medrecitem["date"], style: const TextStyle(fontSize:25, fontWeight: FontWeight.bold)),
                                      IconButton(
                                        icon: const Icon(Icons.delete_outline ),
                                        iconSize: 30,
                                        tooltip: 'Delete this record',
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection("user").doc(userId).collection('Pet_Profile').doc(petdocid).update({'MedRec':FieldValue.arrayRemove([petmedreclist[_index]])});
                                        },
                                      ),
                                    ]
                                ),
                                subtitle:
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Text('Problem',style: leftdetailstyle,),
                                      Text(_medrecitem["problem"],style: rightdetailstyle,),
                                      const Text('Diagnosis',style: leftdetailstyle,),
                                      Text(_medrecitem["diagnosis"],style: rightdetailstyle,),
                                      const Text('Action',style: leftdetailstyle,),
                                      Text(_medrecitem["action"],style: rightdetailstyle,),

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



