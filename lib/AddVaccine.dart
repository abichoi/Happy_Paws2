import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'ProfileDetail.dart';
import 'authentication.dart';

class AddVaccinePage extends StatefulWidget {
  @override
  State<AddVaccinePage> createState() => _AddVaccinePageState();
}


class _AddVaccinePageState extends State<AddVaccinePage> {
  final _vaccine = TextEditingController();
  final _date = TextEditingController();
  final _expire = TextEditingController();
  final _vet = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _formatteddate = '';
  String _formattedexpire = '';
  late DateTime pickedstartDate;
  late DateTime pickedexpire;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Add Vaccine"),
          elevation: 0,
          flexibleSpace: Container(
            decoration:  const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFBC4FFF),Color(0xFF24DEEA)],
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
                          controller: _vaccine,
                          style: const TextStyle(fontSize: 30),
                          decoration: const InputDecoration(
                            hintText: 'Vaccine',
                            labelStyle: TextStyle(fontSize: 18),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the vaccine';
                            }
                            return null;
                          },
                        ),
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
                              print("Start date is not selected");
                            }
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the start date (yyyy-mm-dd)';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _expire,
                          decoration: const InputDecoration(
                            hintText: 'Please enter the expire date (yyyy-mm-dd)',
                            labelText: 'Expire Date',
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
                              pickedexpire = pickedDate;
                              print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                              _formattedexpire = DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(_formattedexpire); //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement

                              setState(() {
                                _expire.text = _formattedexpire; //set output date to TextField value.
                              });
                            }else{
                              print("End date is not selected");
                            }
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the end date (yyyy-mm-dd)';
                            } else if (pickedstartDate.isAfter(pickedexpire)){
                              return 'The end date has to be after the start date';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _vet,
                          decoration: const InputDecoration(
                            hintText: "Enter the vet",
                            labelText: 'Vet',
                            labelStyle: TextStyle(fontSize: 18),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter the pet's name";
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
    String vaccine = _vaccine.text;
    String date = _date.text;
    String expire = _expire.text;
    String vet = _vet.text;

    petvaccinelist.add({
      'title': vaccine,
      'date': date,
      'expire': expire,
      'vet': vet,
    });



    FirebaseFirestore.instance
        .collection("user").doc(userId).collection('Pet_Profile').doc(petdocid).update({'Vaccine':FieldValue.arrayUnion(petvaccinelist)});
    Navigator.pop(context,true);
  }

}


