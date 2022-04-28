import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:survey/core/models/category.dart';
import 'package:survey/core/models/submission.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

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

sendNameSurname(String name, String surname, String token) async {
  var response = await http.post(
    Uri.parse("${Api.surveyApi}/info_users/"),
    body: {
      "name": name,
      "surname": surname,
    },
    headers: {
      "Authorization": "Token $token",
    },
  );
  print(response.body);

  if (response.statusCode >= 400) throw UnimplementedError();
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
    "Authorization": "Token $token",
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
      "${Api.surveyApi}/likes/favorite/",
    ),
    headers: {
      // "Content-Type": "application/json",
      "Authorization": "Token $token",
    },
  );
  if (response_surveys.statusCode >= 400) throw UnimplementedError();
  print(response_surveys.body);
  return jsonDecode(response_surveys.body);
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
  var response_surveys = await http.post(
    Uri.parse(
      "${Api.surveyApi}/surveys/",
    ),
    headers: {
      // "Content-Type": "application/json",
      "Authorization": "Token $token",
    },
    body: {
      "title": survey.title,
      "description": survey.description,
      "category": survey.category,
    },
  );
  if (response_surveys.statusCode >= 400) {
    throw UnimplementedError();
  }
  int id = jsonDecode(utf8.decode(response_surveys.bodyBytes))["id"];
  print(response_surveys.body);
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
    print(response_questions.body);
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
}

getNameSurname(String email) async {
  var response = await http.get(Uri.parse("${Api.surveyApi}/info_users/"));
  print(response.body);
  for (var item in jsonDecode(utf8.decode(response.bodyBytes))) {
    if (item["author"] == email) {
      return [item["name"], item["surname"]];
    }
  }
}

void main(List<String> args) async {}

Future<String> uploadImage(File? file) async {
  FormData formData = FormData.fromMap({
    "image": await MultipartFile.fromFile(
      "/Users/ulukbekovbr/Library/Developer/CoreSimulator/Devices/66FDE0C9-ED05-4DC4-AB5C-A6D21BB726A1/data/Containers/Data/Application/B54FA2DB-21EF-4A95-87B6-60FE97D6E1C8/tmp/image_picker_37E68399-9391-4B3F-9A3F-F62793FA37CB-46747-000000AFDE8AB817.jpg",
    ),
    "title": "Best survey",
    "description": "Yeah",
    "category": "Sport",
  });
  Dio dio = Dio();
  dio.options.headers['Authorization'] =
      "Token 89112c9df37e076e09646c2a481863fdf8d1c310";
  var response = await dio.post("${Api.surveyApi}/surveys/", data: formData);
  print(response.extra);
  return response.data['id'];
}
