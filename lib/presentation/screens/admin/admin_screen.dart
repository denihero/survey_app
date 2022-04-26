import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:survey/core/constants/color.dart';
import 'package:survey/core/constants/style.dart';
import 'package:survey/core/models/survey.dart';
import 'package:survey/logic/bloc/auth_bloc.dart';
import 'package:survey/logic/bloc/login_api.dart';
import 'package:survey/logic/cubit/categories_cubit.dart';
import 'package:survey/logic/cubit/survey_cubit.dart';
import 'package:survey/presentation/screens/admin/admin_bloc.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  late final TextEditingController titleController;
  late final TextEditingController descController;

  final ImagePicker _picker = ImagePicker();
  File? imageFile;

  @override
  void initState() {
    titleController = TextEditingController();
    descController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

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

  String categorySelectedVal = "Survey";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListFieldFormBloc(),
      child: Builder(
        builder: ((context) {
          final formBloc = context.read<ListFieldFormBloc>();
          final categoriesMenuItems =
              context.read<CategoriesCubit>().state.categories.keys.toList();
          final _dropDownMenuItems = categoriesMenuItems.map(
            (String e) => DropdownMenuItem<String>(
              child: Text(e),
              value: e,
            ),
          );
          return Theme(
            data: Theme.of(context).copyWith(
              buttonTheme: const ButtonThemeData(
                buttonColor: ORANGE,
              ),
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: BackButton(
                    color: BLACK,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: pickImage,
                            child: imageFile != null
                                ? Container(
                                    margin: const EdgeInsets.only(left: 15),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: Image.file(
                                        imageFile!,
                                        fit: BoxFit.cover,
                                        height: 100,
                                        width: 100,
                                      ),
                                    ),
                                  )
                                : Stack(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 15),
                                        height: 100,
                                        width: 100,
                                        decoration: const BoxDecoration(
                                          color: BLUE,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                        ),
                                      ),
                                      const Positioned(
                                          top: 40,
                                          left: 21.5,
                                          child: Text(
                                            'Upload Image',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700,
                                                color: WHITE),
                                          ))
                                    ],
                                  ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 250,
                                  child: TextFormField(
                                    controller: titleController,
                                    decoration: const InputDecoration(
                                        hintText: 'Type title'),
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                ListTile(
                                  title: const Text("Category:"),
                                  trailing: DropdownButton<String>(
                                    value: categorySelectedVal,
                                    items: _dropDownMenuItems.toList(),
                                    onChanged: (String? newval) {
                                      print(categorySelectedVal);
                                      if (newval != null) {
                                        setState(() {
                                          categorySelectedVal =
                                              newval.toString();
                                          print("After");
                                          print(categorySelectedVal);
                                        });
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                SizedBox(
                                  width: 250,
                                  child: TextFormField(
                                    controller: descController,
                                    maxLines: null,
                                    decoration: const InputDecoration(
                                        hintText: 'Type Description'),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.09,
                              left: MediaQuery.of(context).size.width * 0.03),
                          child: Text(
                            'Your questions:',
                            style: Monsterats_600_24_FONT_SIZE_BLACK,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //Questions
                      FormBlocListener<ListFieldFormBloc, String, String>(
                        onSubmitting: (context, state) {
                          LoadingDialog.show(context);
                        },
                        onSuccess: (context, state) {
                          LoadingDialog.hide(context);
                          List<dynamic> questions_choices =
                              jsonDecode(state.successResponse!)["questions"];
                          print(questions_choices);
                          var questions = questions_choices.map((e) {
                            List<dynamic> ch = e["Answers"];
                            return Questions(
                              text: e["Question"],
                              choices: ch
                                  .map(
                                    (e) => Choice(text: e),
                                  )
                                  .toList(),
                            );
                          }).toList();
                          final survey = Surveys(
                            id: -1,
                            title: titleController.text,
                            description: descController.text,
                            category: categorySelectedVal,
                            questions: questions,
                          );
                          post_survey(
                              survey,
                              BlocProvider.of<AuthBloc>(context).state.token,
                              imageFile);
                          BlocProvider.of<SurveyCubit>(context)
                              .fetch_surveys_stream(
                                  BlocProvider.of<AuthBloc>(context)
                                      .state
                                      .token);
                          // uploadImage(imageFile);
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Your survey is added"),
                              content: const Text("Return to home screen"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            "/", (route) => false);
                                  },
                                  child: const Text(
                                    "OK",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );

                          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //   content: SingleChildScrollView(
                          //       child: Text(state.successResponse!)),
                          //   duration: const Duration(milliseconds: 1500),
                          // ));
                        },
                        onFailure: (context, state) {
                          LoadingDialog.hide(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.failureResponse!)));
                        },
                        child: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          child: Column(
                            children: <Widget>[
                              BlocBuilder<
                                  ListFieldBloc<MemberFieldBloc, dynamic>,
                                  ListFieldBlocState<MemberFieldBloc, dynamic>>(
                                bloc: formBloc.questions,
                                builder: (context, state) {
                                  if (state.fieldBlocs.isNotEmpty) {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: state.fieldBlocs.length,
                                      itemBuilder: (context, i) {
                                        return MemberCard(
                                          memberIndex: i,
                                          memberField: state.fieldBlocs[i],
                                          onRemoveMember: () =>
                                              formBloc.removeMember(i),
                                          onAddHobby: () =>
                                              formBloc.addHobbyToMember(i),
                                        );
                                      },
                                    );
                                  }
                                  return Container();
                                },
                              ),
                              ElevatedButton(
                                onPressed: formBloc.addMember,
                                style: ElevatedButton.styleFrom(
                                  primary: ORANGE,
                                ),
                                child: const Text(
                                  'ADD QUESTION',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton.extended(
                backgroundColor: ORANGE,
                heroTag: 'admin',
                // onPressed: () => Navigator.pushNamed(context, '/create_question'),
                onPressed: () {
                  formBloc.submit();
                },
                label: Row(
                  children: const [
                    Icon(Icons.done),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Submit'),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
