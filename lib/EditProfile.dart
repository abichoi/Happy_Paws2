import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'Homepage.dart';
import 'authentication.dart';
import 'ProfileDetail.dart';

//edit pet profile details

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late String returnURL;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  File? _photo;
  final ImagePicker _picker = ImagePicker();
  final _db = FirebaseFirestore.instance;
  static final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _species = TextEditingController();
  String _sex = 'F';
  final _breed = TextEditingController();
  final _color = TextEditingController();
  final _dob = TextEditingController();
  final _vet = TextEditingController();
  var _imgchanged = false;
  var _sexchanged = false;
  String _initialdob = 'empty';
  String _formatteddob = '';
  final List<String> _dropdownlistValueSex = ['F', 'M'];
  String _showvalue = 'F';
  String _docid = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Edit Pet Profile"),
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
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: FutureBuilder<QuerySnapshot>(
                future: _db
                    .collection("user")
                    .doc(userId)
                    .collection('Pet_Profile')
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    DocumentSnapshot _pet = snapshot.data!.docs[petindex];
                    _docid = snapshot.data!.docs[petindex].reference.id;
                    if (_initialdob == 'empty') {
                      _initialdob = _pet.get("dob");
                      _dob.text = _pet.get("dob");
                    }
                    returnURL = _pet.get("img");

                    return Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                child: _imgchanged == true
                                    ? _photo == null
                                        ? const Text('No Image')
                                        : Image.file(_photo!)
                                    : Image.network(_pet.get("img"),
                                        width: 300, height: 150)
                                ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton.icon(
                                    onPressed: () => imgFromCamera(),
                                    icon: const Icon(Icons.camera),
                                    label: const Text('camera')),
                                ElevatedButton.icon(
                                    onPressed: () => imgFromGallery(),
                                    icon: const Icon(Icons.library_add),
                                    label: const Text('Gallery')),
                              ],
                            ),
                            TextFormField(
                              initialValue: _pet.get("name"),
                              decoration: const InputDecoration(
                                hintText: 'Enter the Name',
                                labelText: 'Name',
                                labelStyle: TextStyle(fontSize: 18),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the name';
                                } else {
                                  _name.text = value;
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              initialValue: _pet.get("species"),
                              decoration: const InputDecoration(
                                hintText: 'Enter the species',
                                labelText: 'Species',
                                labelStyle: TextStyle(fontSize: 18),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the species';
                                } else {
                                  _species.text = value;
                                }
                                return null;
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                              child: Text('Sex',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black54)),
                            ),
                            Container(
                              height: 40.0,
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF2F3F5),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black12)),
                              child: DropdownButton<String>(
                                value: _sexchanged == true
                                    ? _showvalue
                                    : _pet.get("sex"),
                                icon:
                                    const Icon(Icons.arrow_drop_down_outlined),
                                elevation: 16,
                                style: const TextStyle(color: Colors.black),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)),
                                dropdownColor: const Color(0xFFF2F3F5),
                                iconEnabledColor: const Color(0xFFB8C1CC),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _sexchanged = true;
                                    _showvalue = newValue!;
                                    _sex = _showvalue;
                                  });
                                },
                                items: _dropdownlistValueSex
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                            TextFormField(
                              initialValue: _pet.get("breed"),
                              decoration: const InputDecoration(
                                hintText: 'Enter the breed',
                                labelText: 'Breed',
                                labelStyle: TextStyle(fontSize: 18),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the address';
                                } else {
                                  _breed.text = value;
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              initialValue: _pet.get("color"),
                              decoration: const InputDecoration(
                                hintText: 'Enter the color',
                                labelText: 'Color',
                                labelStyle: TextStyle(fontSize: 18),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the email';
                                }
                                {
                                  _color.text = value;
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              key: Key(_initialdob),
                              initialValue: _initialdob,
                              decoration: const InputDecoration(
                                hintText:
                                    'Please enter the Date of Birth (yyyy-mm-dd)',
                                labelText: 'Date of Birth',
                                labelStyle: TextStyle(fontSize: 18),
                              ),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101));

                                if (pickedDate != null) {
                                  _formatteddob = DateFormat('yyyy-MM-dd')
                                      .format(pickedDate);
                                  setState(() {
                                    _dob.text = _formatteddob;
                                    _initialdob = _formatteddob;
                                  });
                                } else {
                                  // print("Date of Birth is not selected");
                                }
                              },
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the Date of Birth (yyyy-mm-dd)';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              initialValue: _pet.get("vet"),
                              decoration: const InputDecoration(
                                hintText: 'Enter the Veterinarian',
                                labelText: 'Veterinarian',
                                labelStyle: TextStyle(fontSize: 18),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the Veterinarian';
                                } else {
                                  _vet.text = value;
                                }
                                return null;
                              },
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16.0),
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection("user")
                                              .doc(userId)
                                              .collection('Pet_Profile')
                                              .doc(_docid)
                                              .delete();
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomePage()),
                                            (Route<dynamic> route) => false,
                                          );
                                        },
                                        icon: const Icon(Icons.delete_outline),
                                        label: const Text('Delete'),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          savePetProfile();
                                        }
                                      },
                                      child: const Text('Submit'),
                                    ),
                                  ),
                                ])
                          ],
                        ),
                      ),
                    );
                  }
                })));
  }

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        _imgchanged = true;
        uploadFile();
      } else {
        // print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        _imgchanged = true;
        uploadFile();
      } else {
        // print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = path.basename(_photo!.path);
    const destination = 'user-images';

    try {
      final reference = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child(fileName);
      await reference.putFile(_photo!);
      await reference.getDownloadURL().then((fileURL) {
        returnURL = fileURL;
      });
    } catch (e) {
      // print('error');
    }
  }
//save pet profile details to firestore
  void savePetProfile() {
    String name = _name.text;
    String species = _species.text;
    String sex = _sex;
    String breed = _breed.text;
    String color = _color.text;
    String dob = _dob.text;
    String vet = _vet.text;

    FirebaseFirestore.instance
        .collection("user")
        .doc(userId)
        .collection('Pet_Profile')
        .doc(petdocid)
        .update({'name': name});
    FirebaseFirestore.instance
        .collection("user")
        .doc(userId)
        .collection('Pet_Profile')
        .doc(petdocid)
        .update({'species': species});
    FirebaseFirestore.instance
        .collection("user")
        .doc(userId)
        .collection('Pet_Profile')
        .doc(petdocid)
        .update({'sex': sex});
    FirebaseFirestore.instance
        .collection("user")
        .doc(userId)
        .collection('Pet_Profile')
        .doc(petdocid)
        .update({'breed': breed});
    FirebaseFirestore.instance
        .collection("user")
        .doc(userId)
        .collection('Pet_Profile')
        .doc(petdocid)
        .update({'color': color});
    FirebaseFirestore.instance
        .collection("user")
        .doc(userId)
        .collection('Pet_Profile')
        .doc(petdocid)
        .update({'dob': dob});
    FirebaseFirestore.instance
        .collection("user")
        .doc(userId)
        .collection('Pet_Profile')
        .doc(petdocid)
        .update({'vet': vet});
    FirebaseFirestore.instance
        .collection("user")
        .doc(userId)
        .collection('Pet_Profile')
        .doc(petdocid)
        .update({'img': returnURL});

    Navigator.pop(context, true);
  }
}
