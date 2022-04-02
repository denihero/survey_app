import 'package:flutter/material.dart';
import 'package:survey/presentation/screens/home_screen/widget/appbar.dart';




class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: CustomAppbar(),
        body: Text('HomeScreen'));
  }
}
