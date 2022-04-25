import 'package:flutter/material.dart';
import 'package:survey/presentation/screens/favourite/favourite_screen.dart';
import 'package:survey/presentation/screens/home/home_screen.dart';
import 'package:survey/presentation/screens/profile/profile_screen.dart';

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKeys;
  final String tabItem;
  const TabNavigator(
      {Key? key, required this.navigatorKeys, required this.tabItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = const HomeScreen();
    if (tabItem == 'Home') {
      child = const HomeScreen();
    } else if (tabItem == 'Profile') {
      child = const ProfileScreen();
    } else if (tabItem == "Favourite") {
      child = const FavouriteScreen();
    }
    return Navigator(
      key: navigatorKeys,
      onGenerateRoute: (setting) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
