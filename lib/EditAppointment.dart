import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'Appointmentpage.dart';
import 'authentication.dart';

class EditAppointmentPage extends StatefulWidget {
  const EditAppointmentPage({Key? key}) : super(key: key);

  @override
  State<EditAppointmentPage> createState() => _EditAppointmentPageState();
}


class _EditAppointmentPageState extends State<EditAppointmentPage> {
  final _db = FirebaseFirestore.instance;
  String _docid = '';
  String _initialstartdate = 'empty';
  String _initialenddate = 'empty';
  String _initialstarttime = 'empty';
  String _initialendtime = 'empty';
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
  String _formattedEndTime = '';
  late DateTime pickedstartDate;
  late DateTime pickedendDate;
  late DateTime pickedstartTime;
  late DateTime pickedendTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Edit Appointment"),
            elevation: 0,
            flexibleSpace: Container(
              decoration:  const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.yellow,Colors.orange],
                ),
              ),
            )
        ),
        body: Padding(
            padding: EdgeInsets.all(20.0),
            child: FutureBuilder<QuerySnapshot>(
                future: _db.collection("user").doc(userId).collection('Appointment').get(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    DocumentSnapshot _appointment = snapshot.data!.docs[appointmentindex];
                    _docid = snapshot.data!.docs[appointmentindex].reference.id;
                    _pet.text = _appointment.get("pet");
                    _location.text = _appointment.get("location");
                    if (_initialstartdate == 'empty') {
                      _initialstartdate = _appointment.get("startdate");
                      pickedstartDate = DateTime.parse(_appointment.get("startdate"));
                      _startdate.text = _appointment.get("startdate");
                    }
                    if (_initialenddate == 'empty') {
                      _initialenddate = _appointment.get("enddate");
                      pickedendDate = DateTime.parse(_appointment.get("enddate"));
                      _enddate.text = _appointment.get("enddate");
                    }
                    if (_initialstarttime == 'empty') {
                      _initialstarttime = _appointment.get("starttime");
                      _starttime.text = _appointment.get("starttime");
                      pickedstartTime = DateTime(pickedstartDate.year, pickedstartDate.month, pickedstartDate.day, int.parse(_initialstarttime.split(":")[0]), int.parse(_initialstarttime.split(":")[1]));
                    }
                    if (_initialendtime == 'empty') {
                      _initialendtime = _appointment.get("endtime");
                      _endtime.text = _appointment.get("endtime");
                      pickedendTime = DateTime(pickedendDate.year, pickedendDate.month, pickedendDate.day, int.parse(_initialendtime.split(":")[0]), int.parse(_initialendtime.split(":")[1]));

                    }
                    if (kDebugMode) {
                      print("start date");
                      print(_appointment.get("startdate"));

                    }
                    return Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  TextFormField(
                                    initialValue: _appointment.get("title"),
                                    style: const TextStyle(fontSize: 30),
                                    decoration: const InputDecoration(
                                      hintText: 'Title',
                                      // labelText: 'Title',
                                      // labelStyle: TextStyle(fontSize: 18),
                                      ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the title';
                                      } else {_title.text = value;}
                                      return null;
                                      },
                                  ),
                                  TextFormField(
                                    initialValue: _initialstartdate,
                                    decoration: const InputDecoration(
                                      hintText: 'Please enter the start date (yyyy-mm-dd)',
                                      labelText: 'Start Date',
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
                                        print("pickedstartDate");
                                        print(pickedstartDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                        _formattedStartDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                        print(_formattedStartDate); //formatted date output using intl package =>  2021-03-16
                                        //you can implement different kind of Date Format here according to your requirement

                                        setState(() {
                                          _startdate.text = _formattedStartDate;
                                          _initialstartdate = _formattedStartDate; //set output date to TextField value.
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
                                  initialValue: _initialstarttime,
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
                                    MaterialLocalizations localizations = MaterialLocalizations.of(context);
                                    if (pickedTime != null) {
                                      pickedstartTime = DateTime(pickedstartDate.year, pickedstartDate.month, pickedstartDate.day, pickedTime.hour, pickedTime.minute);
                                      String formattedTime = localizations.formatTimeOfDay(pickedTime,
                                          alwaysUse24HourFormat: true);
                                      _formattedStartTime = formattedTime;
                                      if (_formattedStartTime != null) {
                                        setState(() {
                                          _starttime.text = _formattedStartTime;
                                          _initialstarttime = _formattedStartTime;
                                        });
                                      }else{
                                        print("Start Time is not selected");
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
                                  initialValue: _initialenddate,
                                  decoration: const InputDecoration(
                                    hintText: 'Please enter the end date (yyyy-mm-dd)',
                                    labelText: 'End Date',
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
                                      pickedendDate = pickedDate;
                                      print("pickedendDate");
                                      print(pickedendDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                      _formattedEndDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                      print(_formattedEndDate); //formatted date output using intl package =>  2021-03-16
                                      //you can implement different kind of Date Format here according to your requirement

                                      setState(() {
                                        _enddate.text = _formattedEndDate;
                                        _initialenddate = _formattedEndDate; //set output date to TextField value.
                                      });
                                    }else{
                                      print("End date is not selected");
                                    }
                                  },
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the end date (yyyy-mm-dd)';
                                    } else if (pickedstartDate.isAfter(pickedendDate)){
                                      return 'The end date has to be after the start date';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  initialValue: _initialendtime,
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
                                    MaterialLocalizations localizations = MaterialLocalizations.of(context);
                                    if (pickedTime != null) {
                                      pickedendTime = DateTime(pickedendDate.year, pickedendDate.month, pickedendDate.day, pickedTime.hour, pickedTime.minute);
                                      String formattedTime = localizations.formatTimeOfDay(pickedTime,
                                          alwaysUse24HourFormat: true);
                                      _formattedEndTime = formattedTime;
                                      if (formattedTime != null) {
                                        setState(() {
                                          _endtime.text = _formattedEndTime;
                                          _initialendtime = _formattedEndTime;
                                        });
                                      }else{
                                        print("End Time is not selected");
                                      }
                                    }
                                  },
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the end time';
                                    } else if (pickedstartTime.isAfter(pickedendTime)){
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
                              ]
                          )
                      )
            );}})
        )
    );
  }
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

    FirebaseFirestore.instance.collection("user").doc(userId).collection('Appointment').doc(_docid).set(_appointment);
    Navigator.pop(context,true);
  }

}


