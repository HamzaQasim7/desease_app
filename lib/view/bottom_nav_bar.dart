import 'package:flutter/material.dart';
import 'package:test_app/resources/app_colors.dart';
import 'package:test_app/view/home_view/home_view.dart';

class NavigationBarView extends StatefulWidget {
  const NavigationBarView({super.key});

  @override
  _NavigationBarViewState createState() => _NavigationBarViewState();
}

class _NavigationBarViewState extends State<NavigationBarView > {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    Text('Report Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Option Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('More Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.pureBlackColor,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.task),
                label: 'Report',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.health_and_safety),
              label: 'Second\nOption',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              label: 'More',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          unselectedItemColor: AppColors.whiteColor,
          selectedItemColor: AppColors.primaryColor,
          iconSize: 25,
          onTap: _onItemTapped,

      ),
    );
  }
}