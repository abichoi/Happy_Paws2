import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'AddAppointment.dart';

class AppointmentPage extends StatefulWidget {
  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}


class _AppointmentPageState extends State<AppointmentPage> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  final _db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Appointment"),
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
        body:Column (
            children: [ TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: DateTime.now(),
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay; // update `_focusedDay` here as well
                    });
                  },
                ),
              StreamBuilder<QuerySnapshot>(
                  stream: _db.collection('Appointment').snapshots(),
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
                                  DocumentSnapshot _appointment = snapshot.data!.docs[_index];
                                  return Card(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                                      elevation: 3,
                                      shadowColor: Colors.black,
                                      child: ListTile(
                                        title: Row (
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children:[
                                              Text(_appointment.get('title')),
                                              // IconButton(
                                              //   icon: const Icon(Icons.mode_edit_outline_outlined ),
                                              //   iconSize: 30,
                                              //   tooltip: 'Edit Pet Profile',
                                              //   onPressed: () {
                                              //     Navigator.push(
                                              //       context,
                                              //       MaterialPageRoute(builder: (_) => EditContactPage()),
                                              //     );
                                              //   },
                                              // ),
                                            ]
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Pet: ' + _appointment.get('pet')),
                                            Text('Start: ' + _appointment.get('startdate') + ' '+ _appointment.get('starttime') ),
                                            Text('End: ' +  _appointment.get('enddate') + ' '+ _appointment.get('endtime')),
                                            Text('Location: ' + _appointment.get('location')),
                                          ],
                                        ),
                                      ));
                                },
                              )));
                    }
                  }),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 16.0),
              //   child:

              // )
            ]
        ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddAppointmentPage()),
          );
        },
        child: const Icon(Icons.add),
        // color: Colors.white,
        backgroundColor: Colors.blue,
        tooltip: 'Add Appointment',
      ),


    );
  }


}