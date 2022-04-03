import 'package:flutter/material.dart';
import 'package:survey/core/constants/style.dart';
import 'package:survey/presentation/screens/usert_attempt_screen/widget/users_tile_widget.dart';

class UserAttemptScreen extends StatelessWidget {
  const UserAttemptScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 77,
            ),
            Center(
              child: Text(
                'Math for high school',
                style: Monsterats_600_24_FONT_SIZE_BLACK,
              ),
            ),
            const SizedBox(height: 94),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 32),
                child: Text(
                  'Users:',
                  style: Monsterats_600_24_FONT_SIZE_BLACK,
                ),
              ),
            ),
            UserTileWidget(),
            UserTileWidget(),
            UserTileWidget(),
            UserTileWidget(),
            UserTileWidget(),
            UserTileWidget(),
            UserTileWidget(),
            UserTileWidget(),
            UserTileWidget(),
            UserTileWidget(),
          ],
        ),
      ),
    );
  }
}
