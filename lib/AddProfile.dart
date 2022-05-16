import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'authentication.dart';

//add pet profile

class AddProfilePage extends StatefulWidget {
  const AddProfilePage({Key? key}) : super(key: key);

  @override
  State<AddProfilePage> createState() => _AddProfilePageState();
}

class _AddProfilePageState extends State<AddProfilePage> {
  late String returnURL;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  File? _photo;
  final ImagePicker _picker = ImagePicker();
  String _formattedDate = '';
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _species = TextEditingController();
  String _sex = 'F';
  final _breed = TextEditingController();
  final _color = TextEditingController();
  final _dob = TextEditingController();
  final _vet = TextEditingController();
  final List<String> _dropdownlistValueSex = ['F', 'M'];
  String _showvalue = 'F';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Add Pet Profile"),
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
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        child: _photo == null
                            ? const Text('Please select an image',
                                style:
                                    TextStyle(fontSize: 25, color: Colors.red))
                            : Image.file(_photo!)),
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
                      controller: _name,
                      decoration: const InputDecoration(
                        hintText: 'Enter the Name',
                        labelText: 'Name',
                        labelStyle: TextStyle(fontSize: 18),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the name';
                        }
                        return null;
                      },
                    ),

                    TextFormField(
                      controller: _species,
                      decoration: const InputDecoration(
                        hintText: 'Enter the species',
                        labelText: 'Species',
                        labelStyle: TextStyle(fontSize: 18),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the species';
                        }
                        return null;
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                      child: Text('Sex',
                          style:
                              TextStyle(fontSize: 18, color: Colors.black54)),
                    ),
                    Container(
                      height: 40.0,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      decoration: BoxDecoration(
                          color: const Color(0xFFF2F3F5),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black12)),
                      child: DropdownButton<String>(
                        value: _showvalue,
                        icon: const Icon(Icons.arrow_drop_down_outlined),
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                        dropdownColor: const Color(0xFFF2F3F5),
                        iconEnabledColor: const Color(0xFFB8C1CC),
                        onChanged: (String? newValue) {
                          setState(() {
                            _showvalue = newValue!;
                            _sex = _showvalue;
                          });
                        },
                        items: _dropdownlistValueSex
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),

                    TextFormField(
                      controller: _breed,
                      decoration: const InputDecoration(
                        hintText: 'Enter the breed',
                        labelText: 'Breed',
                        labelStyle: TextStyle(fontSize: 18),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the address';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _color,
                      decoration: const InputDecoration(
                        hintText: 'Enter the color',
                        labelText: 'Color',
                        labelStyle: TextStyle(fontSize: 18),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the email';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _dob,
                      decoration: const InputDecoration(
                        hintText: 'Enter the date of birth (dd/mm/yyyy)',
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
                          _formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            _dob.text =
                                _formattedDate;
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the date of birth (dd/mm/yyyy)';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _vet,
                      decoration: const InputDecoration(
                        hintText: 'Enter the Veterinarian',
                        labelText: 'Veterinarian',
                        labelStyle: TextStyle(fontSize: 18),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Veterinarian';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _savePetProfile();
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
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
      print('File Uploaded');
      await reference.getDownloadURL().then((fileURL) {
        returnURL = fileURL;
      });
    } catch (e) {
      // print('error');
    }
  }
//save the pet profile detail to firestore
  void _savePetProfile() {
    String name = _name.text;
    String species = _species.text;
    String sex = _sex;
    String breed = _breed.text;
    String color = _color.text;
    String dob = _dob.text;
    String vet = _vet.text;
    List vaccinelist = [];
    List medreclist = [];
    List notelist = [];

    Map<String, dynamic> _petprofile = {
      'name': name,
      'species': species,
      'sex': sex,
      'breed': breed,
      'color': color,
      'dob': dob,
      'vet': vet,
      'img': returnURL,
      "Vaccine": FieldValue.arrayUnion(vaccinelist),
      "MedRec": FieldValue.arrayUnion(medreclist),
      "Note": FieldValue.arrayUnion(notelist),
    };

    FirebaseFirestore.instance
        .collection("user")
        .doc(userId)
        .collection('Pet_Profile')
        .add(_petprofile);
    Navigator.pop(context, true);
  }
}
