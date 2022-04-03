import 'package:flutter/material.dart';
import '../../../../core/constants/color.dart';


class Bottom extends StatelessWidget {
  const Bottom({Key? key,required this.selectedIndex, required this.onTap}) : super(key: key);
  final int selectedIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home,size: 30,),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite,size: 30,),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person,size: 30,),
          label: '',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: BLUE,
      onTap: onTap,
    );
  }
}
