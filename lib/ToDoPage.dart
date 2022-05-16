import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'authentication.dart';
import 'AddToDo.dart';

//to do page

class ToDoPage extends StatefulWidget {
  const ToDoPage({Key? key}) : super(key: key);

  @override
  _ToDoPageState createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("To-Do"),
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
          child: StreamBuilder<QuerySnapshot>(
            stream: _db
                .collection("user")
                .doc(userId)
                .collection('ToDo')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                        width: 330.0,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, _index) {
                            DocumentSnapshot _todoitem =
                                snapshot.data!.docs[_index];
                            String _docid =
                                snapshot.data!.docs[_index].reference.id;
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 3,
                              shadowColor: Colors.black,
                              child: CheckboxListTile(
                                secondary: IconButton(
                                  icon: const Icon(Icons.delete_outline),
                                  tooltip: 'Delete this item',
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection("user")
                                        .doc(userId)
                                        .collection('ToDo')
                                        .doc(_docid)
                                        .delete();
                                  },
                                ),
                                title: Text(_todoitem.get('item'),
                                    style: _todoitem.get('selected') == 'false'
                                        ? const TextStyle(
                                            fontWeight: FontWeight.bold)
                                        : const TextStyle(color: Colors.grey)),
                                value: _todoitem.get('selected') == 'false'
                                    ? false
                                    : true,
                                onChanged: (bool? value) {
                                  setState(() {
                                    FirebaseFirestore.instance
                                        .collection("user")
                                        .doc(userId)
                                        .collection('ToDo')
                                        .doc(_docid)
                                        .update({'selected': value.toString()});
                                  });
                                },
                              ),
                            );
                          },
                        )));
              }
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const addToDoPage()),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xFF92FF4F),
        tooltip: 'Add To-Do',
      ),
    );
  }
}
