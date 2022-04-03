import 'package:flutter/material.dart';
import 'package:survey/presentation/screens/home_screen/widget/appbar.dart';
import 'package:survey/presentation/screens/home_screen/widget/category_choose.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: const CustomAppbar(),
        body: SingleChildScrollView(
          child: Column(
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 15,top: 20),
                child:CategoryChoose( )
              )
            ],
          ),
        ));
  }
}
