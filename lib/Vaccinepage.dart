import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'Homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ProfileDetail.dart';
import 'AddVaccine.dart';
import 'MedRecPage.dart';
import 'NotePage.dart';
import 'authentication.dart';

//Vaccine Page: show vaccine records

class VaccinePage extends StatefulWidget {
  const VaccinePage({Key? key}) : super(key: key);


  @override
  _VaccinePageState createState() => _VaccinePageState();
}

class _VaccinePageState extends State<VaccinePage> {
  final _db = FirebaseFirestore.instance;
  static const TextStyle leftdetailstyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);
  static const TextStyle rightdetailstyle = TextStyle(
      fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Vaccine"),
            elevation: 0,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF4F60FF), Color(0xFF24DEEA)],
                ),
              ),
            )),
        body: StreamBuilder<QuerySnapshot>(
          stream: _db
              .collection("user")
              .doc(userId)
              .collection('Pet_Profile')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              DocumentSnapshot _pet = snapshot.data!.docs[petindex];
              return ListView(children: [
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.network(
                      _pet.get("img"),
                      width: 300,
                      height: 150,
                    )),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.add),
                          iconSize: 80,
                          tooltip: 'Add Vaccine Record',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => AddVaccinePage()),
                            );
                          },
                        ),
                        const Text('Add Vaccine Record')
                      ]),
                      Column(children: <Widget>[
                        IconButton(
                          icon: const Icon(Boxicons.bx_file),
                          iconSize: 80,
                          tooltip: 'Add or Edit Medical Record',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const MedRecPage()),
                            );
                          },
                        ),
                        const Text('Medical Record')
                      ]),
                      Column(children: <Widget>[
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
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: petvaccinelist.length,
                  itemBuilder: (context, _index) {
                    var _vaccineitem = petvaccinelist[_index];
                    return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 3,
                        shadowColor: Colors.black,
                        child: ListTile(
                            title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(_vaccineitem["title"],
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold)),
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline),
                                    iconSize: 30,
                                    tooltip: 'Delete this vaccine record',
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection("user")
                                          .doc(userId)
                                          .collection('Pet_Profile')
                                          .doc(petdocid)
                                          .update({
                                        'Vaccine': FieldValue.arrayRemove(
                                            [petvaccinelist[_index]])
                                      });
                                    },
                                  ),
                                ]),
                            subtitle: Row(children: <Widget>[
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const <Widget>[
                                    Text(
                                      'Date',
                                      style: leftdetailstyle,
                                    ),
                                    Text(
                                      'Expire',
                                      style: leftdetailstyle,
                                    ),
                                    Text(
                                      'Vet',
                                      style: leftdetailstyle,
                                    )
                                  ]),
                              const Text("           "),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      _vaccineitem["date"],
                                      style: rightdetailstyle,
                                    ),
                                    Text(
                                      _vaccineitem["expire"],
                                      style: rightdetailstyle,
                                    ),
                                    Text(
                                      _vaccineitem["vet"],
                                      style: rightdetailstyle,
                                    )
                                  ])
                            ])));
                  },
                )
              ]);
            }
          },
        ));
  }
}
