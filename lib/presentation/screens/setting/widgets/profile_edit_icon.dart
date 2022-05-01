import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:survey/logic/bloc/login_api.dart';
import 'package:survey/presentation/screens/profile/widgets/profileicon.dart';

import '../../../../core/constants/style.dart';
import '../../../../logic/bloc/auth_bloc.dart';

class ProfileEditIcon extends StatefulWidget {
  ProfileEditIcon({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileEditIcon> createState() => _ProfileEditIconState();
}

class _ProfileEditIconState extends State<ProfileEditIcon> {
  @override
  Widget build(BuildContext context) {
    final String? image = BlocProvider.of<AuthBloc>(context).state.image;
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        print("new:");
        print(state);
        print("end");
        if (state is AuthLoading)
          // ignore: curly_braces_in_flow_control_structures
          return const Align(
            alignment: Alignment.centerLeft,
            child: CircularProgressIndicator(color: Colors.black,),
          );
        return SizedBox(
          width: 150,
          child: Stack(
            // alignment: Alignment.bottomRight,
            clipBehavior: Clip.hardEdge,
            children: [
              image == null || image.isEmpty
                  ? GestureDetector(
                    onTap: ()=>Navigator.of(context).pushNamed("/view_change_image"),
                    child: ProfileIcon(
                        is_settings: true,
                      ),
                  )
                  : GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed("/view_change_image");
                      },
                      child: CircleAvatar(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.white,
                        radius: 43,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            progressIndicatorBuilder:
                                (context, url, progress) => const Center(
                                    child: CircularProgressIndicator(
                              color: Colors.black,
                            )),
                            imageUrl: image,
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
      },
    );
  }
}

class ChangeImage extends StatefulWidget {
  const ChangeImage({Key? key}) : super(key: key);

  @override
  State<ChangeImage> createState() => _ChangeImageState();
}

class _ChangeImageState extends State<ChangeImage> {
  final ImagePicker _picker = ImagePicker();

  File? imageFile;
  pickImage() async {
    try {
      final image = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 50);
      if (image == null) return;
      setState(() {
        this.imageFile = File(image.path);
      });
      print(imageFile?.path);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final String? image = BlocProvider.of<AuthBloc>(context).state.image;
    bool is_loading = false;
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return state is AuthLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
            : WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    title: Text(
                      "View Image",
                      style: Monsterats_500_18_FONT_SIZE_BLACK,
                    ),
                    backgroundColor: Colors.white,
                    actions: [
                      IconButton(
                        onPressed: pickImage,
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                      ),
                    ],
                    leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 30,
                      ),
                      onPressed: () async {
                        var val = BlocProvider.of<AuthBloc>(context).state;
                        if (imageFile != null) {
                          BlocProvider.of<AuthBloc>(context)
                              .add(AuthChangeInfo(imageFile));
                          final nextState =
                              await BlocProvider.of<AuthBloc>(context)
                                  .state
                                  .email;
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                    elevation: 0,
                  ),
                  body: image==null||image.isEmpty&&imageFile==null?Center(child: Text("None",style: Monsterats_600_24_FONT_SIZE_BLACK,),):Center(
                          child: imageFile == null
                              ? image==null||image.isEmpty?Center(child:Text("None",style:Monsterats_600_24_FONT_SIZE_BLACK)):Padding(
                                  padding: const EdgeInsets.only(bottom: 60),
                                  child: CachedNetworkImage(
                                    imageUrl: image ??"",
                                    width: double.infinity,
                                    fit: BoxFit.fitWidth,
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(bottom: 60),
                                  child: Image.file(
                                    imageFile!,
                                    width: double.infinity,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                        )
                ));
      },
    );
  }
}
