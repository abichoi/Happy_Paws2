import 'package:flutter/material.dart';
import 'AddContact.dart';
import 'AddProfile.dart';
import 'ProfileDetail.dart';
import 'EditContact.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'authentication.dart';
import 'UserPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


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
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                FontAwesomeIcons.solidCircleUser,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserPage()));
              },
            )
          ],
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
                  // color: Colors.blueGrey,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                                Row (
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
                          ),
                            Expanded(
                              child: _ContactList(),
                            ),
                      ]
                  ),
                )
            ),
            )]
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
      stream: _db.collection("user").doc(userId).collection('Pet_Profile').snapshots(),
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                elevation: 3,
                shadowColor: Colors.black,
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
                        Image.network(_pet.get("img"), height: 200),
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

var contactindex = 0;
class _ContactList extends StatelessWidget {
  final _db = FirebaseFirestore.instance;
  List<String> catagorylist = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: _db.collection("user").doc(userId).collection('Contact').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Align(
                    alignment: Alignment.topCenter,
                    child : SizedBox(
                    width: 330.0,
                    child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, _index) {
                    DocumentSnapshot _contact = snapshot.data!.docs[_index];
                    String _docid = snapshot.data!.docs[_index].reference.id;

                    if (_contact.get('selectedGroomer') == 'true') {
                      catagorylist.add('Groomer');
                    } else{
                      catagorylist.remove('Groomer');
                    }
                    if (_contact.get('selectedBoarding') == 'true') {
                      catagorylist.add('Pet Boarding');
                    } else{
                      catagorylist.remove('Pet Boarding');
                    }
                    if (_contact.get('selectedSitter') == 'true') {
                      catagorylist.add('Pet-Sitter');
                    } else{
                      catagorylist.remove('Pet-Sitter');
                    }
                    if (_contact.get('selectedVet') == 'true') {
                      catagorylist.add('Vet');
                    }else{
                      catagorylist.remove('Vet');
                    }
                    if (_contact.get('selectedOther') == 'true') {
                      catagorylist.add('Others');
                    }else{
                      catagorylist.remove('Others');
                    }
                    catagorylist = catagorylist.toSet().toList();
                    String stringList = catagorylist.join(", ");
                    return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                        elevation: 3,
                        shadowColor: Colors.black,
                            child: ListTile(
                            title: Row (
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:[
                                  Text(_contact.get('name')),
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline),
                                    tooltip: 'Delete this item',
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection("user").doc(userId)
                                          .collection('Contact').doc(_docid)
                                          .delete();
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.mode_edit_outline_outlined ),
                                    iconSize: 30,
                                    tooltip: 'Edit Pet Profile',
                                    onPressed: () {
                                      contactindex =_index;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (_) => EditContactPage()),
                                      );
                                    },
                                  ),
                                ]
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Catagory: ' + stringList),
                              Text('Phone: ' + _contact.get('phone')),
                              Text('Address: ' + _contact.get('address')),
                              Text('Email: ' + _contact.get('email')),
                    ],
                    ),
                    ));
                    },
                )));
              }
            })
    );
  }
  }



