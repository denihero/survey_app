import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:survey/core/constants/color.dart';
import 'package:survey/core/constants/style.dart';
import 'package:survey/logic/bloc/auth_bloc.dart';
import 'package:survey/presentation/navigation/routes.dart';

class ProfileIcon extends StatelessWidget {
  ProfileIcon({
    Key? key,
    this.is_settings = false,
  }) : super(key: key);
  bool is_settings;

  @override
  Widget build(BuildContext context) {
    final String? image = BlocProvider.of<AuthBloc>(context).state.image;
    return is_settings
        ? Container(
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
            padding: EdgeInsets.all(is_settings ? 20 : 50),
            child: Icon(
              Icons.person,
              size: is_settings ? 43 : 100,
            ),
          )
        : image == null || image.isEmpty
            ? Center(
                child: Container(
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
                  padding: EdgeInsets.all(is_settings ? 20 : 50),
                  child: Icon(
                    Icons.person,
                    size: is_settings ? 43 : 100,
                  ),
                ),
              )
            : GestureDetector(
                onTap: () {
                  // return Container()
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
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white10,
                    radius: 110,
                    child: ClipOval(
                      child: CachedNetworkImage(
                        progressIndicatorBuilder: (context, url, progress) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          );
                        },
                        imageUrl: image,
                        fit: BoxFit.cover,
                        height: 300,
                        width: 290,
                      ),
                    ),
                  ),
                ),
              );
  }
}
