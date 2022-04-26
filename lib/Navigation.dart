import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'Homepage.dart';


class BottomNavWidget extends StatefulWidget {
  const BottomNavWidget({Key? key}) : super(key: key);

  @override
  State<BottomNavWidget> createState() => _BottomNavWidgetState();
}
int _selectedIndex = 0;

class _BottomNavWidgetState extends State<BottomNavWidget> {
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home', style: optionStyle,),
    Text('Appointment', style: optionStyle,),
    Text('Storage',style: optionStyle,),
    Text('Shop', style: optionStyle, ),
  ];

  final _PageOption = [
    HomePage(),
    const Text('Appointment', style: optionStyle,),
    const Text('Storage',style: optionStyle,),
    const Text('Shop', style: optionStyle, ),
  ];

  final _colorOptions = [
    [Colors.white,Colors.white], //Home
    [Colors.yellow,Colors.orange], //Appointment
    [Colors.pink,Colors.deepPurple], //Storage
    [Colors.greenAccent,Colors.indigoAccent], //Shop
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: _widgetOptions.elementAt(_selectedIndex),
          elevation: 0,
          flexibleSpace: Container(
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: _colorOptions.elementAt(_selectedIndex),
              ),
            ),
          )
      ),
      body: Center(
        child: _PageOption.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Appointment',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Boxicons.bxs_package),
            label: 'Storage',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Shop',
            backgroundColor: Colors.white,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}