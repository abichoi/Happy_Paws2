import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'AddStorage.dart';
import 'EditStoage.dart';
import 'authentication.dart';

class StoragePage extends StatefulWidget {
  @override
  State<StoragePage> createState() => _StoragePageState();
}

var storageindex = 0;

class _StoragePageState extends State<StoragePage> {
  final _db = FirebaseFirestore.instance;
  int _quantity = 0;
  int _threshold = 0;
  bool _quantityalert = false;
  String _docid = '';
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
        body: StreamBuilder<QuerySnapshot>(
            stream: _db.collection("user").doc(userId).collection('Storage').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Align(
                    alignment: Alignment.topCenter,
                    child : SizedBox(
                        width: 330.0,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, _index) {
                            DocumentSnapshot _storage = snapshot.data!.docs[_index];
                            _docid = snapshot.data!.docs[storageindex].reference.id;
                            _quantity = int.parse(_storage.get("quantity"));
                            _threshold = int.parse(_storage.get("threshold"));
                            _quantityalert = _storage.get("quantityalert") == "true" ? true : false;
                            return Card(
                                shape: _quantityalert == true ? _quantity <= _threshold ? RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: const BorderSide(
                                    color: Colors.pink,
                                    width: 5.0,
                                  ),
                                ) :
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ) :
                                RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 3,
                                shadowColor: Colors.black,
                                child: ListTile(
                                  title: Row (
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children:[
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(_storage.get("img")),
                                              radius: 60,
                                            ),
                                          )
                                        ),
                                        const Expanded(
                                            flex: 1,
                                          child: Text(""),
                                        ),
                                  Expanded(
                                      flex: 5,
                                      child: Column(
                                        children: [
                                          Row (
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children:[
                                                Text(_storage.get('name'), style: const TextStyle(fontWeight: FontWeight.bold),),
                                                IconButton(
                                                  icon: const Icon(Icons.mode_edit_outline_outlined ),
                                                  iconSize: 30,
                                                  tooltip: 'Edit Storage',
                                                  onPressed: () {
                                                    storageindex =_index;
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (_) => EditStoragePage()),
                                                    );},
                                                ),
                                              ]),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
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
                                                      FirebaseFirestore.instance.collection("user").doc(userId).collection('Storage').doc(_docid).update({ "quantity": _quantity.toString()});

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
                                                    FirebaseFirestore.instance.collection("user").doc(userId).collection('Storage').doc(_docid).update({ "quantity": _quantity.toString()});
                                                  });
                                                },
                                                child: const Icon(Icons.add),
                                              ),
                                            ],
                                          )
                                        ]),
                                  ),
                            ]),
                                ));
                          },
                        )));
              }
            }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddStoragePage()),
          );
        },
        child: const Icon(Icons.add),
        // color: Colors.white,
        backgroundColor: Colors.deepPurple,
        tooltip: 'Add Storage',
      ),
    );
  }


}