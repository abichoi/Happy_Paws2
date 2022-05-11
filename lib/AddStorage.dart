import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'authentication.dart';

class AddStoragePage extends StatefulWidget {
  const AddStoragePage({Key? key}) : super(key: key);

  @override
  State<AddStoragePage> createState() => _AddStorageState();
}


class _AddStorageState extends State<AddStoragePage> {
  // late DatabaseReference _ref;
  // late String _uploadedFileURL;
  late String returnURL;
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  File? _photo;
  // late Future<PickedPhoto?> _photo = Future.value(null);
  final ImagePicker _picker = ImagePicker();
  String _formattedDate = '';
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  int _quantity = 0;
  int _threshold = 0;
  bool _quantityalert = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Add Storage"),
            elevation: 0,
            flexibleSpace: Container(
              decoration:  const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.pink,Colors.deepPurple],
                ),
              ),
            )
        ),
        body: Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        child: _photo == null ? const Text('No Image Showing') : Image.file(_photo!)
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
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text("Quantity"),
                          Row(
                            children: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xFF979797),
                                  fixedSize: const Size(30, 30),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  padding: const EdgeInsets.all(0),
                                  minimumSize: const Size(0, 0),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: (){
                                  if(_quantity != 0) {
                                    setState(() {
                                      _quantity--;
                                    });
                                  }
                                  },
                                child: const Icon(Icons.remove),
                              ),
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: Text(_quantity.toString()),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xFF979797),
                                  fixedSize: const Size(30, 30),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  padding: const EdgeInsets.all(0),
                                  minimumSize: const Size(0, 0),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _quantity++;
                                  });
                                  },
                                child: const Icon(Icons.add),
                              ),


                        ],
                    )]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text("Quantity Alert"),
                          Switch(
                            value: _quantityalert,
                            onChanged: (value) {
                              setState(() {
                                _quantityalert = value;
                                print(_quantityalert);
                              });
                            },
                            activeTrackColor: Colors.lightGreenAccent,
                            activeColor: Colors.green,
                          ),

                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text("Quantity Alert Threshold"),
                          Row(
                            children: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xFF979797),
                                  fixedSize: const Size(30, 30),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  padding: const EdgeInsets.all(0),
                                  minimumSize: const Size(0, 0),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: (){
                                  if(_threshold != 0) {
                                    setState(() {
                                      _threshold--;
                                    });
                                  }
                                },
                                child: const Icon(Icons.remove),
                              ),
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: Text(_threshold.toString()),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xFF979797),
                                  fixedSize: const Size(30, 30),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  padding: const EdgeInsets.all(0),
                                  minimumSize: const Size(0, 0),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _threshold++;
                                  });
                                },
                                child: const Icon(Icons.add),
                              ),


                            ],
                          )]),

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
            ))
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


  void _savePetProfile() {
    String name = _name.text;
    String quantity = _quantity.toString();
    String quantityalert = _quantityalert.toString();
    String threshold = _threshold.toString();

    Map<String, String> _storage = {
      'name': name,
      'quantity': quantity,
      'quantityalert': quantityalert,
      'threshold': threshold,
      'img': returnURL
    };

    FirebaseFirestore.instance.collection("user").doc(userId).collection('Storage').add(_storage);
    Navigator.pop(context,true);
  }

}