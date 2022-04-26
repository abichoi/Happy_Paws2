// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
// import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class ProfiledetailWidget extends StatefulWidget {
  const AddProfileFormWidget({Key? key}) : super(key: key);

  @override
  State<AddProfileFormWidget> createState() => AddProfileFormWidgetState();
}