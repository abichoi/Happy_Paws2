import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ProfileDetail.dart';

class AddNotePage extends StatefulWidget {
  @override
  State<AddNotePage> createState() => _AddNotePageState();
}


class _AddNotePageState extends State<AddNotePage> {
  final _date = TextEditingController();
  final _note = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _formatteddate = '';
  late DateTime pickedstartDate;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Add Medical Record"),
          elevation: 0,
          flexibleSpace: Container(
            decoration:  const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFAA24EA), Color(0xFFFFA34F)],
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[

                        TextFormField(
                          controller: _date,
                          decoration: const InputDecoration(
                            hintText: 'Please enter the  date (yyyy-mm-dd)',
                            labelText: 'Date',
                            labelStyle: TextStyle(fontSize: 18),
                          ),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101)
                            );

                            if(pickedDate != null ){
                              pickedstartDate = pickedDate;
                              print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                              _formatteddate = DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(_formatteddate); //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement

                              setState(() {
                                _date.text = _formatteddate; //set output date to TextField value.
                              });
                            }else{
                              print("Date is not selected");
                            }
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the date (yyyy-mm-dd)';
                            }
                            return null;
                          },
                        ),
                        const Text("  "),
                        TextFormField(
                          minLines: 6,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: _note,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Please enter the problem',
                            labelText: 'Problem',
                            labelStyle: TextStyle(fontSize: 18),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter the problem";
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child:
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF24DEEA),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _saveAppointment();
                              }
                            },
                            child: const Text('Submit'),
                          ),
                        ),
                      ]
                  )
              )
          )
      ),
    );
  }
  void _saveAppointment() {
    String date = _date.text;
    String note = _note.text;

    petnotelist.add({
      'date': date,
      'note': note,
    });



    FirebaseFirestore.instance
        .collection('Pet_Profile').doc(petdocid).update({'Note':FieldValue.arrayUnion(petnotelist)});
    Navigator.pop(context,true);
  }

}


