import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Homepage.dart';

class EditContactPage extends StatefulWidget {
  const EditContactPage({Key? key}) : super(key: key);

  @override
  State<EditContactPage> createState() => _EditContactPageState();
}


class _EditContactPageState extends State<EditContactPage> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _choosen = [];
  final List<String> _data= [];
  final _db = FirebaseFirestore.instance;
  bool _selectedGroomer = false;
  bool _selectedBoarding = false;
  bool _selectedSitter = false;
  bool _selectedVet = false;
  bool _selectedOther = false;
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();
  final _email = TextEditingController();
  String _docid = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Edit Contact"),
            elevation: 0,
            flexibleSpace: Container(
              decoration:  const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFBC4FFF), Color(0xFF2438EA)],
                ),
              ),
            )
        ),
        body: Padding(
            padding: EdgeInsets.all(20.0),
            child: StreamBuilder<QuerySnapshot>(
                stream: _db.collection('Contact').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    DocumentSnapshot _contact = snapshot.data!.docs[contactindex];
                    _docid = snapshot.data!.docs[contactindex].reference.id;
                    _name.text =_contact.get("name");
                    _phone.text = _contact.get("phone");
                    _address.text = _contact.get("address");
                    _email.text = _contact.get("email");
                    _selectedGroomer = _contact.get("selectedGroomer") == 'true' ? true : false;
                    _selectedBoarding = _contact.get("selectedBoarding") == 'true' ? true : false;
                    _selectedSitter = _contact.get("selectedSitter") == 'true' ? true : false;
                    _selectedVet = _contact.get("selectedVet") == 'true' ? true : false;
                    _selectedOther = _contact.get("selectedOther") == 'true' ? true : false;


                    return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _name,
                    decoration: const InputDecoration(
                        hintText: 'Enter the Name',
                        labelText: 'Name'
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the name';
                      }
                      return null;
                    },
                  ),
                  Container(
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(0,10,0,0),
                      child: Text('Category', style: TextStyle(fontSize:15, color: Colors.black54)),
                    ),
                  ),
                  Wrap(
                      spacing: 20,
                      children: [
                        FilterChip(
                            label: const Text('Groomer'),
                            selected: _selectedGroomer,
                            showCheckmark: false,
                            labelStyle: TextStyle(
                              color: _selectedGroomer ? Colors.white : Colors.black,
                            ),
                            selectedColor: Colors.deepPurpleAccent,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.black26, width: 1),borderRadius: BorderRadius.circular(20),),
                            onSelected: (bool selected1) {
                                _selectedGroomer = !_selectedGroomer;
                                log(_selectedGroomer.toString());
                            }),
                        FilterChip(
                            label: const Text('Pet Boarding'),
                            selected: _selectedBoarding,
                            showCheckmark: false,
                            labelStyle: TextStyle(
                              color: _selectedBoarding ? Colors.white : Colors.black,
                            ),
                            selectedColor: Colors.deepPurpleAccent,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.black26, width: 1),borderRadius: BorderRadius.circular(20),),
                            onSelected: (bool selected2) {
                                _selectedBoarding = !_selectedBoarding;
                            }),
                        FilterChip(
                            label: const Text('Pet Sitter'),
                            selected: _selectedSitter,
                            showCheckmark: false,
                            labelStyle: TextStyle(
                              color: _selectedSitter ? Colors.white : Colors.black,
                            ),
                            selectedColor: Colors.deepPurpleAccent,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.black26, width: 1),borderRadius: BorderRadius.circular(20),),
                            onSelected: (bool selected3) {
                                _selectedSitter = !_selectedSitter;
                            }),
                        FilterChip(
                            label: const Text('Vet'),
                            selected: _selectedVet,
                            showCheckmark: false,
                            labelStyle: TextStyle(
                              color: _selectedVet ? Colors.white : Colors.black,
                            ),
                            selectedColor: Colors.deepPurpleAccent,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.black26, width: 1),borderRadius: BorderRadius.circular(20),),
                            onSelected: (bool selected4) {
                                _selectedVet = !_selectedVet;
                            }),
                        FilterChip(
                            label: const Text('Others'),
                            selected: _selectedOther,
                            showCheckmark: false,
                            labelStyle: TextStyle(
                              color: _selectedOther ? Colors.white : Colors.black,
                            ),
                            selectedColor: Colors.deepPurpleAccent,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.black26, width: 1),borderRadius: BorderRadius.circular(20),),
                            onSelected: (bool selected5) {
                                _selectedOther = !_selectedOther;
                            }),
                      ]),
                  TextFormField(
                    controller: _phone,
                    decoration: const InputDecoration(
                        hintText: 'Enter the phone number',
                        labelText: 'Phone'
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the phone number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _address,
                    decoration: const InputDecoration(
                        hintText: 'Enter the address',
                        labelText: 'Address'
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the address';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(
                        hintText: 'Enter the email',
                        labelText: 'Email'
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the email';
                      }
                      return null;
                    },
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.deepPurpleAccent,
                              ),
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('Contact').doc(_docid).delete();
                                Navigator.pop(context,true);
                              },
                              icon: const Icon(Icons.delete_outline),
                              label: const Text('Delete'),
                            )),
                        Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurpleAccent,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _saveContact();
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                      ]
                      )
                  ]),
                    );
            }})));
  }

  void _saveContact() {
    String name = _name.text;
    String phone = _phone.text;
    String address = _address.text;
    String email = _email.text;
    String selectedGroomer = _selectedGroomer ? 'true' : 'false';
    String selectedBoarding = _selectedBoarding ? 'true' : 'false';
    String selectedSitter = _selectedSitter ? 'true' : 'false';
    String selectedVet = _selectedVet ? 'true' : 'false';
    String selectedOther = _selectedOther ? 'true' : 'false';


    Map<String, String> _contact = {
      'name': name,
      'phone': phone,
      'address': address,
      'email': email,
      'selectedGroomer': selectedGroomer,
      'selectedBoarding': selectedBoarding,
      'selectedSitter': selectedSitter,
      'selectedVet': selectedVet,
      'selectedOther': selectedOther
    };

    FirebaseFirestore.instance
        .collection('Contact').doc(_docid).set(_contact);
    Navigator.pop(context,true);
  }




}