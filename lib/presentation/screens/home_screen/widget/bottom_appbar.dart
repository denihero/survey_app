import 'package:flutter/material.dart';
import 'package:survey/core/constants/color.dart';


class Bottom extends StatelessWidget {
  const Bottom({Key? key,required this.selectedIndex, required this.onTap}) : super(key: key);
  final int selectedIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(21),
            topRight: Radius.circular(21)),
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(21),
            topRight: Radius.circular(21)),

        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedIconTheme: const IconThemeData(color: BLUE),
          unselectedItemColor: BLACK,
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
              icon: Icon(Icons.person_sharp,size: 30,),
              label: '',
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: BLUE,
          onTap: onTap,
        ),
      ),
    );
  }
}
