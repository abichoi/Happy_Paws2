// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'dart:developer';
// import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'Homepage.dart';
import 'ProfileDetail.dart';
// import 'package:firebase_core/firebase_core.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}


class _EditProfilePageState extends State<EditProfilePage> {
  // late DatabaseReference _ref;
  // late String _uploadedFileURL;
  late String returnURL;
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  File? _photo;
  // late Future<PickedPhoto?> _photo = Future.value(null);
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
  String _formattedDate = '';
  var _imgchanged = false;
  var _sexchanged = false;
  var _datechange = false;
  String _originaldate = '';
  String _changeddate = '';
  final List<String> _dropdownlistValueSex = ['F', 'M'];
  String _showvalue = 'F';
  String _docid = '';
  // String _initial_name = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Edit Pet Profile"),
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
        body: Padding(
            padding: EdgeInsets.all(20.0),
            child: StreamBuilder<QuerySnapshot>(
                stream: _db.collection('Pet_Profile').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    DocumentSnapshot _pet = snapshot.data!.docs[petindex];
                    _docid = snapshot.data!.docs[petindex].reference.id;
                    _originaldate = _pet.get("dob");
                    returnURL = _pet.get("img");


                    return Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                child: _imgchanged == true ? _photo == null ? const Text('No Image') : Image.file(_photo!) : Image.network(_pet.get("img"), width: 300,height: 150)
                                // _photo == null ? const Text('No Image') : Image.file(_photo!)
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
                              initialValue: _pet.get("species"),
                              decoration: const InputDecoration(
                                hintText: 'Enter the Name',
                                labelText: 'Name',
                                labelStyle: TextStyle(fontSize: 18),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the name';
                                } else {_name.text = value;}
                                return null;
                              },
                            ),


                            TextFormField(
                              initialValue: _pet.get("species"),
                              // controller: _species,
                              decoration: const InputDecoration(
                                hintText: 'Enter the species',
                                labelText: 'Species',
                                labelStyle: TextStyle(fontSize: 18),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the species';
                                } else {_species.text = value;}
                                return null;
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                              child: Text(
                                  'Sex', style: TextStyle(fontSize: 18, color: Colors.black54)),
                            ),
                            Container(
                              height: 40.0,
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF2F3F5),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black12)
                              ),
                              // child: const SexDropDownWidget(),
                              child: DropdownButton<String>(
                                value: _sexchanged == true ? _showvalue : _pet.get("sex"),
                                icon: const Icon(Icons.arrow_drop_down_outlined),
                                elevation: 16,
                                style: const TextStyle(color: Colors.black),
                                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
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
                                    .map<DropdownMenuItem<String>>((String value) {
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
                                } else {_breed.text = value;}
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
                                } {_color.text = value;}
                                return null;
                              },
                            ),
                            TextFormField(
                              initialValue: _pet.get("dob"),
                              decoration: const InputDecoration(
                                hintText: 'Enter the date of birth (yyyy-mm-dd)',
                                labelText: 'Date of Birth',
                                labelStyle: TextStyle(fontSize: 18),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the email';
                                } {_dob.text = value;}
                                return null;
                              },
                            ),
                            // TextFormField(
                            //   initialValue: _pet.get("dob"),
                            //   decoration: const InputDecoration(
                            //     hintText: 'Enter the date of birth (dd/mm/yyyy)',
                            //     labelText: 'Date of Birth',
                            //     labelStyle: TextStyle(fontSize: 18),
                            //   ),
                            //   onTap: () async {
                            //     DateTime? pickedDate = await showDatePicker(
                            //         context: context,
                            //         initialDate: DateTime.now(),
                            //         firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                            //         lastDate: DateTime(2101)
                            //     );
                            //
                            //     if(pickedDate != null ){
                            //       print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                            //       _formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                            //       print(_formattedDate); //formatted date output using intl package =>  2021-03-16
                            //       //you can implement different kind of Date Format here according to your requirement
                            //
                            //       setState(() {
                            //         _datechange = true;
                            //         _dob.text = _formattedDate; //set output date to TextField value.
                            //       });
                            //     }else{
                            //       print("Date is not selected");
                            //     }
                            //   },
                            //   validator: (String? value) {
                            //     if (value == null || value.isEmpty) {
                            //       return 'Please enter the date of birth (dd/mm/yyyy)';
                            //     } else {
                            //       _dob.text = _formattedDate;
                            //
                            //     }
                            //     return null;
                            //   },
                            // ),
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
                                } else {_vet.text = value;}
                                return null;
                              },
                            ),
                            // const Padding(
                            //   padding: EdgeInsets.fromLTRB(0,10,0,5),
                            //   child: Text('Date of Birth', style: TextStyle(fontSize:18, color: Colors.black54)),
                            // ),
                            // Container(height: 50, child: DatePicker(),),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    savePetProfile();
                                  }
                                },
                                child: const Text('Submit'),
                              ),
                            ),
                  ],
                ),
              ),
            );}}))
    );
  }

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        _imgchanged = true;
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
        _imgchanged = true;
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
        returnURL =  fileURL;
      });
    } catch (e) {
      print('error');
    }
  }


  void savePetProfile() {
    String name = _name.text;
    String species = _species.text;
    String sex = _sex;
    String breed = _breed.text;
    String color = _color.text;
    String dob = _dob.text;
    String vet = _vet.text;


    Map<String, String> _petprofile = {
      'name': name,
      'species': species,
      'sex': sex,
      'breed': breed,
      'color': color,
      'dob': dob,
      'vet': vet,
      'img': returnURL
    };

    FirebaseFirestore.instance
        .collection('Pet_Profile').doc(_docid).set(_petprofile);
  }

}