import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class StoragePage extends StatefulWidget {
  @override
  State<StoragePage> createState() => _StoragePageState();
}


class _StoragePageState extends State<StoragePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Storage"),
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
        body: const Text('Storage')
    );
  }


}