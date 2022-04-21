import 'package:flutter/material.dart';
import 'package:survey/presentation/screens/home/widget/appBar/appbar_search_widget.dart';
import '../../../../../core/constants/color.dart';
import '../../../../../core/constants/style.dart';

class CustomAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppbarWidget({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              'Survey App',
              style: Monsterats_700_18_FONT_SIZE_BLACK,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          SearchWidget()
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
  Size get preferredSize => const Size.fromHeight(151.0);
}
