import 'package:flutter/material.dart';

import 'widget/appbar.dart';




class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: CustomAppbar(),
        body: Text('HomeScreen'));
  }
}
