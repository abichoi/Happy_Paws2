import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class addcontactpage extends StatefulWidget {
  const addcontactpage({Key? key}) : super(key: key);

  @override
  State<addcontactpage> createState() => _addcontactpageState();
}


class _addcontactpageState extends State<addcontactpage> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _choosen = [];
  final List<String> _data= [];
  bool _selectedGroomer = false;
  bool _selectedBoarding = false;
  bool _selectedSitter = false;
  bool _selectedVet = false;
  bool _selectedOther = false;
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();
  final _email = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Add Contact"),
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
    child: Form(
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
                      setState(() {
                        _selectedGroomer = !_selectedGroomer;
                        if (_selectedGroomer){
                          _choosen.add('Groomer');
                        } else {
                          _choosen.removeWhere((item) => item == 'Groomer');
                        }
                      });
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
                      setState(() {
    _selectedBoarding = !_selectedBoarding;
                        if (_selectedBoarding){
                          _choosen.add('Pet Boarding');
                        } else {
                          _choosen.removeWhere((item) => item == 'Pet Boarding');
                        }
                      });
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
                      setState(() {
    _selectedSitter = !_selectedSitter;
                        if (_selectedSitter){
                          _choosen.add('Pet Sitter');
                        } else {
                          _choosen.removeWhere((item) => item == 'Pet Sitter');
                        }
                      });
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
                      setState(() {
    _selectedVet = !_selectedVet;
                        if (_selectedVet){
                          _choosen.add('Vet');
                        } else {
                          _choosen.removeWhere((item) => item == 'Vet');
                        }
                      });
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
                      setState(() {
    _selectedOther = !_selectedOther;
                        if (_selectedOther){
                          _choosen.add('Others');
                        } else {
                          _choosen.removeWhere((item) => item == 'Others');
                        }
                      });
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _saveContact();
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    )));
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
        .collection('Contact')
        .add(_contact);
  }




}