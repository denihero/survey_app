import 'package:flutter/material.dart';
import 'package:survey/core/constants/color.dart';


class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'admin',
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(top: 10,left: 10),
              child: BackButton(
                color: BLACK,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          body: const Text('Admin Screen'),
        ),
      ),
    );
  }
}
