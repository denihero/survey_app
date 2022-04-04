import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:survey/presentation/screens/favourite/favourite_screen.dart';
import 'package:survey/presentation/screens/home/home_screen.dart';
import 'package:survey/presentation/screens/home/widget/appBar/bottom_appbar_widget.dart';
import 'package:survey/presentation/screens/profile/profile_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MainPage> {

  final _screens = <Widget>[
    const HomeScreen(),
    const FavouriteScreen(),
    const ProfileScreen()
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:IndexedStack(
          children: [
            _screens[_selectedIndex]],
        ),
        bottomNavigationBar: BottomWidget(
            onTap: _onItemTapped, index: _selectedIndex,
        ));
  }

}
