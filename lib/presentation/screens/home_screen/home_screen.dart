import 'package:flutter/material.dart';
<<<<<<< HEAD

import 'widget/appbar.dart';


=======
import 'package:survey/presentation/screens/home_screen/widget/appBar/appbar_widget.dart';
>>>>>>> 6ae20db9bba80b0090e85f761776bc76fc48e0eb


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: CustomAppbar(),
        body: Text('HomeScreen'));
  }
}
