import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'authentication.dart';

//add to do

class addToDoPage extends StatefulWidget {
  const addToDoPage({Key? key}) : super(key: key);

  @override
  State<addToDoPage> createState() => _addToDoPageState();
}

class _addToDoPageState extends State<addToDoPage> {
  final _formKey = GlobalKey<FormState>();
  final _item = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Add To-Do"),
            elevation: 0,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF92FF4F), Color(0xFF00D1FF)],
                ),
              ),
            )),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _item,
                    decoration: const InputDecoration(
                        hintText: 'Enter the item', labelText: 'item'),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the item';
                      }
                      return null;
                    },
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF92FF4F),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _saveToDo();
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      )),
                ],
              ),
            )));
  }
//save to do item detail to firestore
  void _saveToDo() {
    String item = _item.text;

    Map<String, String> _todo = {
      'item': item,
      'selected': 'false',
    };

    FirebaseFirestore.instance
        .collection("user")
        .doc(userId)
        .collection('ToDo')
        .add(_todo);
    Navigator.pop(context, true);
  }
}
