import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'Appointmentpage.dart';
import 'Homepage.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'Shoppage.dart';
import 'Storagepage.dart';
import 'ToDoPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//the bottom navigation bar

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
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style3,
    );
  }
}

List<Widget> _buildScreens() {
  return [HomePage(), ToDoPage(), AppointmentPage(), StoragePage(), ShopPage()];
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
      icon: const Icon(FontAwesomeIcons.listCheck),
      title: ("To-Do"),
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
