import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'AddAppointment.dart';
import 'EditAppointment.dart';
import 'authentication.dart';

//appointment page: show calendar, show appointments, add appointment

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

var appointmentindex = 0;

class _AppointmentPageState extends State<AppointmentPage> {
  DateTime _selectedDay = DateTime.now();
  String _formattedselectedDay = '';
  late DateTime _focusedDay;
  final _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Appointment"),
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
      body: Column(children: [
        TableCalendar(
          headerStyle: const HeaderStyle(formatButtonVisible: false),
          calendarStyle: const CalendarStyle(
            isTodayHighlighted: true,
            todayDecoration: BoxDecoration(
              color: Color(0xFFFDD835),
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
            weekendTextStyle: TextStyle(color: Colors.red),
          ),
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: _selectedDay,
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _formattedselectedDay =
                  DateFormat('yyyy-MM-dd').format(_selectedDay);
              _focusedDay = focusedDay;
            });
          },
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
        ),
        StreamBuilder<QuerySnapshot>(
            stream: _db
                .collection("user")
                .doc(userId)
                .collection('Appointment')
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
                            DocumentSnapshot _appointment =
                                snapshot.data!.docs[_index];
                            String _docid =
                                snapshot.data!.docs[_index].reference.id;
                            DateTime _startdate =
                                DateTime.parse(_appointment.get("startdate"));
                            DateTime _enddate =
                                DateTime.parse(_appointment.get("enddate"));
                            DateTime _selecteddate =
                                DateTime.parse(_formattedselectedDay);
                            return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 3,
                                shadowColor: Colors.black,
                                color: (_startdate == _selecteddate ||
                                        _enddate == _selecteddate ||
                                        (_startdate.isBefore(_selecteddate) &
                                            _enddate.isAfter(_selecteddate)))
                                    ? Colors.orange
                                    : Colors.white,
                                child: ListTile(
                                  title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            constraints: const BoxConstraints(
                                                minWidth: 180, maxWidth: 180),
                                            child: Text(
                                                _appointment.get('title'),
                                                style: TextStyle(
                                                    color: (_startdate ==
                                                                _selecteddate ||
                                                            _enddate ==
                                                                _selecteddate ||
                                                            (_startdate.isBefore(
                                                                    _selecteddate) &
                                                                _enddate.isAfter(
                                                                    _selecteddate)))
                                                        ? Colors.white
                                                        : Colors.black))),
                                        IconButton(
                                          icon:
                                              const Icon(Icons.delete_outline),
                                          color: (_startdate == _selecteddate ||
                                                  _enddate == _selecteddate ||
                                                  (_startdate.isBefore(
                                                          _selecteddate) &
                                                      _enddate.isAfter(
                                                          _selecteddate)))
                                              ? Colors.white
                                              : Colors.black,
                                          tooltip: 'Delete this item',
                                          onPressed: () {
                                            FirebaseFirestore.instance
                                                .collection("user")
                                                .doc(userId)
                                                .collection('Appointment')
                                                .doc(_docid)
                                                .delete();
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                              Icons.mode_edit_outline_outlined),
                                          color: (_startdate == _selecteddate ||
                                                  _enddate == _selecteddate ||
                                                  (_startdate.isBefore(
                                                          _selecteddate) &
                                                      _enddate.isAfter(
                                                          _selecteddate)))
                                              ? Colors.white
                                              : Colors.black,
                                          iconSize: 30,
                                          tooltip: 'Edit Appointment',
                                          onPressed: () {
                                            appointmentindex = _index;
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      const EditAppointmentPage()),
                                            );
                                          },
                                        ),
                                      ]),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Pet: ' + _appointment.get('pet'),
                                          style: TextStyle(
                                              color: (_startdate ==
                                                          _selecteddate ||
                                                      _enddate ==
                                                          _selecteddate ||
                                                      (_startdate.isBefore(
                                                              _selecteddate) &
                                                          _enddate.isAfter(
                                                              _selecteddate)))
                                                  ? Colors.white
                                                  : Colors.black)),
                                      Text(
                                          'Start: ' +
                                              _appointment.get('startdate') +
                                              ' ' +
                                              _appointment.get('starttime'),
                                          style: TextStyle(
                                              color: (_startdate ==
                                                          _selecteddate ||
                                                      _enddate ==
                                                          _selecteddate ||
                                                      (_startdate.isBefore(
                                                              _selecteddate) &
                                                          _enddate.isAfter(
                                                              _selecteddate)))
                                                  ? Colors.white
                                                  : Colors.black)),
                                      Text(
                                          'End: ' +
                                              _appointment.get('enddate') +
                                              ' ' +
                                              _appointment.get('endtime'),
                                          style: TextStyle(
                                              color: (_startdate ==
                                                          _selecteddate ||
                                                      _enddate ==
                                                          _selecteddate ||
                                                      (_startdate.isBefore(
                                                              _selecteddate) &
                                                          _enddate.isAfter(
                                                              _selecteddate)))
                                                  ? Colors.white
                                                  : Colors.black)),
                                      Text(
                                          'Location: ' +
                                              _appointment.get('location'),
                                          style: TextStyle(
                                              color: (_startdate ==
                                                          _selecteddate ||
                                                      _enddate ==
                                                          _selecteddate ||
                                                      (_startdate.isBefore(
                                                              _selecteddate) &
                                                          _enddate.isAfter(
                                                              _selecteddate)))
                                                  ? Colors.white
                                                  : Colors.black)),
                                    ],
                                  ),
                                ));
                          },
                        )));
              }
            }),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddAppointmentPage()),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.orange,
        tooltip: 'Add Appointment',
      ),
    );
  }
}
