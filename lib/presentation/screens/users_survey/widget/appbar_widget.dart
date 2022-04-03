import 'package:flutter/material.dart';
import 'package:survey/core/constants/color.dart';
import 'package:survey/core/constants/style.dart';

class CustomAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppbarWidget({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      leading: BackButton(
        color: Colors.black,
        onPressed: () => Navigator.pop(context),
      ),
      title: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              'Survey App',
              style: Monsterats_700_18_FONT_SIZE_BLACK,
            ),
          ),
        ],
      ),
      backgroundColor: WHITE,
      centerTitle: true,
      toolbarHeight: 151,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(26),
              bottomRight: Radius.circular(26))),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(122.0);
}
