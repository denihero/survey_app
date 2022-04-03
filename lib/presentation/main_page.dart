import 'package:flutter/material.dart';

import 'screens/favourite_screen/favourite_screen.dart';
import 'screens/home_screen/home_screen.dart';
import 'screens/home_screen/widget/bottom_appbar.dart';
import 'screens/profile_screen/profile_screen.dart';



class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MainPage> {

  final _widgetOptions = <Widget>[
    const HomeScreen(),
    const FavouriteScreen(),
    const ProfileScreen()
  ];

  late int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(index: _selectedIndex, children: _widgetOptions),
        bottomNavigationBar: Bottom(
            selectedIndex: _selectedIndex,
            onTap: _onItemTapped)
    );
  }
}
