// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
// import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
// import 'package:firebase_core/firebase_core.dart';
// import 'dropdownsex.dart';
// import 'datepicker.dart';

class AddProfileFormWidget extends StatefulWidget {
  const AddProfileFormWidget({Key? key}) : super(key: key);

  @override
  State<AddProfileFormWidget> createState() => AddProfileFormWidgetState();
}


class AddProfileFormWidgetState extends State<AddProfileFormWidget> {
  // late DatabaseReference _ref;
  // late String _uploadedFileURL;
  late String returnURL;
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  File? _photo;
  // late Future<PickedPhoto?> _photo = Future.value(null);
  final ImagePicker _picker = ImagePicker();

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
  // void initState() {
  //   super.initState();
  //   // _ref = FirebaseDatabase.instance.reference().child('PetProfile');
  // }

  Widget build(BuildContext context) {
    //form widget
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                child: _photo == null ? const Text('No Image Showing') : Image.file(_photo!)
            ),
            // FutureBuilder<_photo?>(
            //   future: _photo,
            //   builder: (context, snap) {
            //     if (snap.hasData) {
            //       return Container(
            //         child: Image.file(
            //           File(snap.data!.path),
            //           fit: BoxFit.contain,
            //         ),
            //         color: Colors.blue,
            //       );
            //     }
            //     return Container(
            //       height: 200.0,
            //       color: Colors.blue,
            //     );
            //   },
            // ),
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
            // TextFormField(
            //   controller: _sex,
            //   decoration: const InputDecoration(
            //     hintText: 'Enter the sex',
            //     labelText: 'Species',
            //     labelStyle:TextStyle(fontSize: 18),
            //   ),
            //   validator: (String? value) {
            //     if (value == null || value.isEmpty) {
            //       return 'Please enter the sex (F/M)';
            //     }
            //     return null;
            //   },
            // ),
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
                value: _showvalue,
                icon: const Icon(Icons.arrow_drop_down_outlined),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
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
    );
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
        .collection('Pet_Profile')
        .add(_petprofile);
  }

}


class AddProfilePage extends StatelessWidget{
  const AddProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Add Pet Profile"),
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
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: AddProfileFormWidget(),
      ),
    );
  }
}