import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:survey/core/models/category.dart';
import 'package:survey/core/models/submission.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/api.dart';
import '../../core/models/survey.dart';

Future<String> login(String username, String password) async {
  var response = await http.post(
    Uri.parse("${Api.surveyApi}/account/login/"),
    body: {
      "email": username,
      "password": password,
    },
  );

  if (response.statusCode >= 400) throw UnimplementedError();
  print(response.body.toString());
  if (response.statusCode == 201 || response.statusCode == 200) {
    return jsonDecode(response.body.toString())["token"];
  }
  return "";
}

sendNameSurname(String name, String surname, String token, File? file) async {
  FormData formData = FormData.fromMap({
    if (file != null) "image": await MultipartFile.fromFile(file.path),
    "name": name,
    "surname": surname,
  });
  Dio dio = Dio();
  dio.options.headers['Authorization'] = "Token $token";
  var response = await dio.post("${Api.surveyApi}/info_users/", data: formData);
  print("Send name username");
  print(response.extra);
  if (response.statusCode! >= 400) {
    throw UnimplementedError();
  }
  // var response = await http.post(
  //   Uri.parse("${Api.surveyApi}/info_users/"),
  //   body: {
  //     "name": name,
  //     "surname": surname,
  //   },
  //   headers: {
  //     "Authorization": "Token $token",
  //   },
  // );
  // print(response.body);

  // if (response.statusCode >= 400) throw UnimplementedError();
}

Future<bool> register(String username, String password) async {
  var response = await http.post(
    Uri.parse("${Api.surveyApi}/account/register/"),
    body: {
      "email": username,
      "password": password,
      "password_confirmation": password,
    },
  );
  if (response.statusCode >= 400) throw UnimplementedError();
  if (response.statusCode == 201 || response.statusCode == 200) {
    return true;
  }
  return false;
}

Future<bool> confirmPassword(String username, String code) async {
  var response = await http.post(
    Uri.parse("${Api.surveyApi}/account/activate/"),
    body: {
      "email": username,
      "code": code,
    },
  );
  print(response.body);
  if (response.statusCode >= 400) throw UnimplementedError();
  if (response.statusCode == 201 || response.statusCode == 200) {
    return true;
  }
  return false;
}

Future<Map<String, String>> get_categories(String token) async {
  var response =
      await http.get(Uri.parse("${Api.surveyApi}/categories/"), headers: {
    "Authorization": "Token be4f6b0ae5a8b387b98a96ddb5a33ab0ba8b48b1",
  });
  print("token:$token");
  print("Response :${response.body}");
  if (response.statusCode >= 400) {
    throw UnimplementedError();
  }
  return Categories.fromJson(
    jsonDecode(utf8.decode(response.bodyBytes)),
  ).categories;
}

get_survey_via_id(int id, String token) async {
  var response =
      await http.get(Uri.parse("${Api.surveyApi}/surveys/$id/"), headers: {
    "Authorization": "Token $token",
  });
  print(response.body);
  return Surveys.fromJson(
    jsonDecode(
      response.body.toString(),
    ),
  );
}



Stream<Surveys> get_surveys_via_category_stream_fixed(String token,String category) async* {
  var response =
      await http.get(Uri.parse("${Api.surveyApi}/surveys/?category=$category"), headers: {
    "Authorization": "Token $token",
  });

  if (jsonDecode(response.body.toString())["count"] == 0) throw Empty();

  if (response.statusCode >= 400) {
    throw UnimplementedError();
  }

  String? next_one;

  try {
    final first_one = jsonDecode(utf8.decode(response.bodyBytes));
    print(first_one);
    next_one = first_one["next"];
    yield Surveys.fromJson(first_one["results"][0]);
  } catch (_) {
    throw UnimplementedError();
  }
  while (next_one != null) {
    var response = await http.get(Uri.parse(next_one), headers: {
      "Authorization": "Token $token",
    });
    final survey = jsonDecode(utf8.decode(response.bodyBytes));
    next_one = survey["next"];
    yield Surveys.fromJson(survey["results"][0]);
  }
}

Stream<Surveys> get_surveys_Mine(String token,String email) async* {
  var response =
      await http.get(Uri.parse("${Api.surveyApi}/surveys/?search=$email"), headers: {
    "Authorization": "Token $token",
  });

  if (jsonDecode(response.body.toString())["count"] == 0) throw Empty();

  if (response.statusCode >= 400) {
    throw UnimplementedError();
  }

  String? next_one;

  try {
    final first_one = jsonDecode(utf8.decode(response.bodyBytes));
    print(first_one);
    next_one = first_one["next"];
    yield Surveys.fromJson(first_one["results"][0]);
  } catch (_) {
    throw UnimplementedError();
  }
  while (next_one != null) {
    var response = await http.get(Uri.parse(next_one), headers: {
      "Authorization": "Token $token",
    });
    final survey = jsonDecode(utf8.decode(response.bodyBytes));
    next_one = survey["next"];
    yield Surveys.fromJson(survey["results"][0]);
  }
}



Stream<Surveys> find_surveys_stream_fixed(String title,String token) async* {
  var response =
      await http.get(Uri.parse("${Api.surveyApi}/surveys/?search=$title"), headers: {
    "Authorization": "Token $token",
  });
  print(response.body);

  if (jsonDecode(response.body.toString())["count"] == 0) throw Empty();

  if (response.statusCode >= 400) {
    throw UnimplementedError();
  }

  String? next_one;

  try {
    final first_one = jsonDecode(utf8.decode(response.bodyBytes));
    print(first_one);
    next_one = first_one["next"];
    yield Surveys.fromJson(first_one["results"][0]);
  } catch (_) {
    throw UnimplementedError();
  }
  while (next_one != null) {
    var response = await http.get(Uri.parse(next_one), headers: {
      "Authorization": "Token $token",
    });
    final survey = jsonDecode(utf8.decode(response.bodyBytes));
    next_one = survey["next"];
    yield Surveys.fromJson(survey["results"][0]);
  }
  
}


//not correct function

class Empty {}

//correct one
Stream<Surveys> get_surveys_stream_fixed(String token) async* {
  var response =
      await http.get(Uri.parse("${Api.surveyApi}/surveys/"), headers: {
    "Authorization": "Token $token",
  });
  print(response.body);

  if (jsonDecode(response.body.toString())["count"] == 0) throw Empty();

  if (response.statusCode >= 400) {
    throw UnimplementedError();
  }

  String? next_one;

  try {
    final first_one = jsonDecode(utf8.decode(response.bodyBytes));
    print(first_one);
    next_one = first_one["next"];
    yield Surveys.fromJson(first_one["results"][0]);
  } catch (_) {
    throw UnimplementedError();
  }
  while (next_one != null) {
    var response = await http.get(Uri.parse(next_one), headers: {
      "Authorization": "Token $token",
    });
    final survey = jsonDecode(utf8.decode(response.bodyBytes));
    next_one = survey["next"];
    yield Surveys.fromJson(survey["results"][0]);
  }
  
}

post_sumbissions(Submission sub, String token) async {
  var response = await http.post(Uri.parse("${Api.surveyApi}/sumbitions/"),
      body: json.encode(sub.toJson()),
      // encoding: "",
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Token $token",
      });
  print(response.body);

  if (response.statusCode >= 400) throw UnimplementedError();
}

delete_survey(Surveys survey, String token) async {
  var response_surveys = await http.delete(
    Uri.parse(
      "${Api.surveyApi}/surveys/${survey.id}/",
    ),
    headers: {
      // "Content-Type": "application/json",
      "Authorization": "Token $token",
    },
  );
  print(response_surveys.body);
  if (response_surveys.statusCode >= 400) throw UnimplementedError();
}

post_like(int survey_index, String token) async {
  var response_surveys = await http.post(
      Uri.parse(
        "${Api.surveyApi}/likes/",
      ),
      headers: {
        // "Content-Type": "application/json",
        "Authorization": "Token $token",
      },
      body: {
        "survey": survey_index.toString(),
      });

  if (response_surveys.statusCode >= 400) throw UnimplementedError();
  return jsonDecode(response_surveys.body)["id"];
}

get_likes(String token) async {
  var response_surveys = await http.get(
    Uri.parse(
      "${Api.surveyApi}/likes/",
    ),
    headers: {
      // "Content-Type": "application/json",
      "Authorization": "Token $token",
    },
  );
  log("Likes:${response_surveys.body}");
  if (response_surveys.statusCode >= 400) throw UnimplementedError();
  log(response_surveys.body);
  try {
    return jsonDecode(response_surveys.body);
  } catch (_) {
    return [];
  }
}

delete_like(int like_index, String token) async {
  var response_surveys = await http.delete(
    Uri.parse(
      "${Api.surveyApi}/likes/$like_index/",
    ),
    headers: {
      // "Content-Type": "application/json",
      "Authorization": "Token $token",
    },
  );
  print(response_surveys.body);
  if (response_surveys.statusCode >= 400) throw UnimplementedError();
}

post_survey(Surveys survey, String token, File? image) async {
  try {
    int id = await uploadImage(image, survey, token);
    log("$id");
    for (Questions i in survey.questions ?? []) {
      var response_questions = await http.post(
        Uri.parse(
          "${Api.surveyApi}/questions/",
        ),
        headers: {
          // "Content-Type": "application/json",
          "Authorization": "Token $token",
        },
        body: {
          "survey": id.toString(),
          "text": i.text,
        },
      );

      if (response_questions.statusCode >= 400) {
        throw UnimplementedError();
      }
      int question_id =
          jsonDecode(utf8.decode(response_questions.bodyBytes))["id"];

      for (Choice c in i.choices ?? []) {
        var response_choices = await http.post(
          Uri.parse("${Api.surveyApi}/choices/"),
          headers: {
            // "Content-Type": "application/json",
            "Authorization": "Token $token",
          },
          body: {
            "text": c.text,
            "question": question_id.toString(),
          },
        );
        if (response_choices.statusCode >= 400) {
          throw UnimplementedError();
        }
        print(response_choices.body);
      }
    }
  } catch (_) {
    throw UnimplementedError();
  }
}

getNameSurname(String email) async {
  var response = await http.get(Uri.parse("${Api.surveyApi}/info_users/"));
  print(response.body);
  for (var item in jsonDecode(utf8.decode(response.bodyBytes))) {
    if (item["author"] == email) {
      return [item["name"], item["surname"], item["image"]];
    }
  }
}

void main(List<String> args) async {
  await get_likes("616de61914e2ee9c30cb3a2e779c9a31d6b6f2f3");
  // try {
  //   await uploadImage(null, Surveys(id: -1));
  // } catch (_) {
  //   print("Error");
  // }
}

Future<int> uploadImage(File? file, Surveys survey, String token) async {
  FormData formData = FormData.fromMap({
    if (file != null) "image": await MultipartFile.fromFile(file.path),
    "title": survey.title,
    "description": survey.description,
    "category": survey.category,
  });
  Dio dio = Dio();
  dio.options.headers['Authorization'] = "Token $token";
  var response = await dio.post("${Api.surveyApi}/surveys/", data: formData);
  print(response.extra);
  print(response);
  if (response.statusCode! >= 400) {
    throw UnimplementedError();
  }
  return response.data['id'];
}
