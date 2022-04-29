import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey/presentation/screens/profile/widgets/profileicon.dart';

import '../../../../core/constants/style.dart';
import '../../../../logic/bloc/auth_bloc.dart';

class ProfileEditIcon extends StatelessWidget {
  const ProfileEditIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String? image = BlocProvider.of<AuthBloc>(context).state.image;
    return SizedBox(
      width: 150,
      child: Stack(
        // alignment: Alignment.bottomRight,
        clipBehavior: Clip.hardEdge,
        children: [
          image==null||image.isEmpty?
          ProfileIcon(
            is_settings: true,
          ):
          GestureDetector(
            onTap: (){

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return WillPopScope(
                          onWillPop: ()async=>false,
                          child: Scaffold(
                            backgroundColor: Colors.white,
                            appBar: AppBar(
                              title:  Text("View Image",style: Monsterats_500_18_FONT_SIZE_BLACK,),
                              backgroundColor: Colors.white,
                              leading: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                              elevation: 0,
                            ),
                            body: Center(
                              child: CachedNetworkImage(
                                imageUrl: image,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
            },
            child: CircleAvatar(
              radius: 43,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: image ,
                  fit: BoxFit.cover,
                  height: 300,
                  width: 300,
                ),
              ),
            ),
          ),
          Positioned(
              left: 50,
              top: 40,
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 5,
                        spreadRadius: 4,
                      ),
                    ]),
                child: const Icon(
                  Icons.edit,
                  size: 26,
                ),
              )),
        ],
      ),
    );
  }
}
