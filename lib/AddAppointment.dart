import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'authentication.dart';

//add appointment

class AddAppointmentPage extends StatefulWidget {
  const AddAppointmentPage({Key? key}) : super(key: key);

  @override
  State<AddAppointmentPage> createState() => _AddAppointmentPageState();
}

class _AddAppointmentPageState extends State<AddAppointmentPage> {
  final _title = TextEditingController();
  final _startdate = TextEditingController();
  final _starttime = TextEditingController();
  final _enddate = TextEditingController();
  final _endtime = TextEditingController();
  final _pet = TextEditingController();
  final _location = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _formattedEndDate = '';
  String _formattedStartDate = '';
  String _formattedStartTime = '';
  late DateTime pickedstartDate;
  late DateTime pickedendDate;
  late DateTime pickedstartTime;
  late DateTime pickedendTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Add Appointment"),
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.yellow, Colors.orange],
              ),
            ),
          )),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                    TextFormField(
                      controller: _title,
                      style: const TextStyle(fontSize: 30),
                      decoration: const InputDecoration(
                        hintText: 'Title',
                        labelStyle: TextStyle(fontSize: 18),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the title';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _startdate,
                      decoration: const InputDecoration(
                        hintText: 'Please enter the start date (yyyy-mm-dd)',
                        labelText: 'Start Date',
                        labelStyle: TextStyle(fontSize: 18),
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          pickedstartDate = pickedDate;
                          _formattedStartDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            _startdate.text = _formattedStartDate;
                          });
                        } else {
                          // print("Start date is not selected");
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
                      controller: _starttime,
                      decoration: const InputDecoration(
                        hintText: 'Please enter the start time (HHmm)',
                        labelText: 'Start Time',
                        labelStyle: TextStyle(fontSize: 18),
                      ),
                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        MaterialLocalizations localizations =
                            MaterialLocalizations.of(context);
                        if (pickedTime != null) {
                          pickedstartTime = DateTime(
                              pickedstartDate.year,
                              pickedstartDate.month,
                              pickedstartDate.day,
                              pickedTime.hour,
                              pickedTime.minute);
                          String formattedTime = localizations.formatTimeOfDay(
                              pickedTime,
                              alwaysUse24HourFormat: true);
                          if (formattedTime != null) {
                            setState(() {
                              _formattedStartTime = formattedTime;
                              _starttime.text = _formattedStartTime;
                            });
                          } else {
                            // print("Start Time is not selected");
                          }
                        }
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the start time';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _enddate,
                      decoration: const InputDecoration(
                        hintText: 'Please enter the end date (yyyy-mm-dd)',
                        labelText: 'End Date',
                        labelStyle: TextStyle(fontSize: 18),
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          pickedendDate = pickedDate;
                          _formattedEndDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);

                          setState(() {
                            _enddate.text = _formattedEndDate;
                          });
                        } else {
                          // print("End date is not selected");
                        }
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the end date (yyyy-mm-dd)';
                        } else if (pickedstartDate.isAfter(pickedendDate)) {
                          return 'The end date has to be after the start date';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _endtime,
                      decoration: const InputDecoration(
                        hintText: 'Please enter the end time (HH:mm)',
                        labelText: 'End Time',
                        labelStyle: TextStyle(fontSize: 18),
                      ),
                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        MaterialLocalizations localizations =
                            MaterialLocalizations.of(context);
                        if (pickedTime != null) {
                          pickedendTime = DateTime(
                              pickedendDate.year,
                              pickedendDate.month,
                              pickedendDate.day,
                              pickedTime.hour,
                              pickedTime.minute);
                          String formattedTime = localizations.formatTimeOfDay(
                              pickedTime,
                              alwaysUse24HourFormat: true);
                          if (formattedTime != null) {
                            setState(() {
                              _formattedStartTime = formattedTime;
                              _endtime.text = _formattedStartTime;
                            });
                          } else {
                            // print("End Time is not selected");
                          }
                        }
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the end time';
                        } else if (pickedstartTime.isAfter(pickedendTime)) {
                          return 'The end time has to be after the start time';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _pet,
                      decoration: const InputDecoration(
                        hintText: "Enter the pet's name",
                        labelText: 'Pet',
                        labelStyle: TextStyle(fontSize: 18),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the pet's name";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _location,
                      decoration: const InputDecoration(
                        hintText: 'Enter the Location',
                        labelText: 'Location',
                        labelStyle: TextStyle(fontSize: 18),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the location';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _saveAppointment();
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ])))),
    );
  }

  //save the appointment details to firestore
  void _saveAppointment() {
    String title = _title.text;
    String startdate = _startdate.text;
    String starttime = _starttime.text;
    String enddate = _enddate.text;
    String endtime = _endtime.text;
    String pet = _pet.text;
    String location = _location.text;

    Map<String, String> _appointment = {
      'title': title,
      'startdate': startdate,
      'starttime': starttime,
      'enddate': enddate,
      'endtime': endtime,
      'pet': pet,
      'location': location,
    };

    FirebaseFirestore.instance
        .collection("user")
        .doc(userId)
        .collection('Appointment')
        .add(_appointment);
    Navigator.pop(context, true);
  }
}
