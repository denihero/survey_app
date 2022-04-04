import 'package:flutter/material.dart';
import 'package:survey/core/constants/color.dart';

class BottomWidget extends StatefulWidget {
  const BottomWidget({Key? key, required this.onTap,required this.index,}) : super(key: key);
  final ValueChanged<int>? onTap;
  final int index;

  @override
  State<BottomWidget> createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(21), topRight: Radius.circular(21)),
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(21), topRight: Radius.circular(21)),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedIconTheme: const IconThemeData(color: BLUE),
          unselectedItemColor: BLACK,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 35,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                size: 35,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_sharp,
                size: 35,
              ),
              label: '',
            ),
          ],
          currentIndex: widget.index,
          selectedItemColor: BLUE,
          onTap: widget.onTap,
        ),
      ),
    );
  }
}
