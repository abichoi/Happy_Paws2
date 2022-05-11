import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'Appointmentpage.dart';
import 'Homepage.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'Shoppage.dart';
import 'Storagepage.dart';

PersistentTabController _controller = PersistentTabController(initialIndex: 0);

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style3, // Choose the nav bar style with this property.
    );
  }
}

List<Widget> _buildScreens() {
  return [
    HomePage(),
    AppointmentPage(),
    StoragePage(),
    ShopPage()
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.home),
      title: ("Home"),
      activeColorPrimary: Colors.lightBlue,
      inactiveColorPrimary: Colors.black45,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.calendar_today_outlined),
      title: ("Appointment"),
      activeColorPrimary: Colors.lightBlue,
      inactiveColorPrimary: Colors.black45,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Boxicons.bxs_package),
      title: ("Storage"),
      activeColorPrimary: Colors.lightBlue,
      inactiveColorPrimary: Colors.black45,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.shopping_cart_outlined),
      title: ("Shop"),
      activeColorPrimary: Colors.lightBlue,
      inactiveColorPrimary: Colors.black45,
    ),
  ];
}


// class BottomNavWidget extends StatefulWidget {
//   const BottomNavWidget({Key? key}) : super(key: key);
//
//   @override
//   State<BottomNavWidget> createState() => _BottomNavWidgetState();
// }
// int _selectedIndex = 0;
//
// class _BottomNavWidgetState extends State<BottomNavWidget> {
//   static const TextStyle optionStyle =
//   TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
//   static const List<Widget> _widgetOptions = <Widget>[
//     Text('Home', style: optionStyle,),
//     Text('Appointment', style: optionStyle,),
//     Text('Storage',style: optionStyle,),
//     Text('Shop', style: optionStyle, ),
//   ];
//
//   final _PageOption = [
//     HomePage(),
//     const Text('Appointment', style: optionStyle,),
//     const Text('Storage',style: optionStyle,),
//     const Text('Shop', style: optionStyle, ),
//   ];
//
//   final _colorOptions = [
//     [Colors.white,Colors.white], //Home
//     [Colors.yellow,Colors.orange], //Appointment
//     [Colors.pink,Colors.deepPurple], //Storage
//     [Colors.greenAccent,Colors.indigoAccent], //Shop
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: _widgetOptions.elementAt(_selectedIndex),
//           elevation: 0,
//           flexibleSpace: Container(
//             decoration:  BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: _colorOptions.elementAt(_selectedIndex),
//               ),
//             ),
//           )
//       ),
//       body: Center(
//         child: _PageOption.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//             backgroundColor: Colors.white,
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.calendar_today_outlined),
//             label: 'Appointment',
//             backgroundColor: Colors.white,
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Boxicons.bxs_package),
//             label: 'Storage',
//             backgroundColor: Colors.white,
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.shopping_cart_outlined),
//             label: 'Shop',
//             backgroundColor: Colors.white,
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.lightBlue,
//         unselectedItemColor: Colors.black,
//         showUnselectedLabels: true,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }