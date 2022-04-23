import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:survey/core/models/category.dart';
import 'package:survey/core/models/submission.dart';

import '../../core/models/survey.dart';

Future<String> login(String username, String password) async {
  var response = await http.post(
    Uri.parse("http://137.184.230.26/account/login/"),
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

Future<bool> register(String username, String password) async {
  var response = await http.post(
    Uri.parse("http://137.184.230.26/account/register/"),
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
    Uri.parse("http://137.184.230.26/account/activate/"),
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
      await http.get(Uri.parse("http://137.184.230.26/categories/"), headers: {
    "Authorization": "Token $token",
  });
  if (response.statusCode >= 400) {
    throw UnimplementedError();
  }
  return Categories.fromJson(
    jsonDecode(response.body.toString()),
  ).categories;
}

//not correct function
Future<List<Surveys>> get_surveys(String token) async {
  List<Surveys> ls = <Surveys>[];
  var response =
      await http.get(Uri.parse("http://137.184.230.26/surveys/"), headers: {
    "Authorization": "Token $token",
  });
  // print(response.body.toString());
  if (response.statusCode >= 400) {
    throw UnimplementedError();
  }
  int length = jsonDecode(response.body.toString())["count"];
  // print(length);
  for (var i = 1; i <= length; i++) {
    var response = await http.get(
      Uri.parse("http://137.184.230.26/surveys/$i/"),
    );
    ls.add(
      Surveys.fromJson(
        jsonDecode(response.body.toString()),
      ),
    );
  }
  return ls;
}

//not correct function
Stream<Surveys> get_surveys_stream(String token) async* {
  var response = await http.get(
    Uri.parse("http://137.184.230.26/surveys/"),
  );
  // print(response.body.toString());
  if (response.statusCode >= 400) {
    throw UnimplementedError();
  }
  int length = jsonDecode(response.body.toString())["count"];
  // print(length);
  for (var i = 1; i <= length; i++) {
    var response = await http.get(
      Uri.parse("http://137.184.230.26/surveys/$i/"),
    );
    // print(i);
    // print(jsonDecode(response.body.toString()));
    yield Surveys.fromJson(
      jsonDecode(response.body.toString()),
    );
  }
  return;
}

class Empty {}

//correct one
Stream<Surveys> get_surveys_stream_fixed(String token) async* {
  var response =
      await http.get(Uri.parse("http://137.184.230.26/surveys/"), headers: {
    "Authorization": "Token $token",
  });
  if (jsonDecode(response.body.toString())["next"] == null) throw Empty();

  if (response.statusCode >= 400) {
    throw UnimplementedError();
  }

  String? next_one;

  try {
    final first_one = jsonDecode(response.body.toString());
    next_one = first_one["next"];
    yield Surveys.fromJson(first_one["results"][0]);
  } catch (_) {
    throw UnimplementedError();
  }
  while (next_one != null) {
    var response = await http.get(Uri.parse(next_one), headers: {
      "Authorization": "Token $token",
    });
    final survey = jsonDecode(response.body.toString());
    next_one = survey["next"];
    yield Surveys.fromJson(survey["results"][0]);
  }
}

post_sumbissions(Submission sub, String token) async {
  var response = await http.post(Uri.parse("http://137.184.230.26/sumbitions/"),
      body: json.encode(sub.toJson()),
      // encoding: "",
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Token $token",
      });
  print(response.body);
}

post_survey(Surveys survey, String token) async {
  var response_surveys = await http.post(
    Uri.parse(
      "http://137.184.230.26/surveys/",
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
  int id = jsonDecode(response_surveys.body)["id"];
  print(response_surveys.body);
  for (Questions i in survey.questions ?? []) {
    var response_questions = await http.post(
      Uri.parse(
        "http://137.184.230.26/questions/",
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
    int question_id = jsonDecode(response_questions.body)["id"];

    for (Choice c in i.choices ?? []) {
      var response_choices = await http.post(
        Uri.parse("http://137.184.230.26/choices/"),
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

void main(List<String> args) async {
  var response = await http.post(
    Uri.parse("http://137.184.230.26/account/login/"),
    body: {
      "email": "alatoo2022@gmail.com",
      "password": 1123.toString(),
    },
  );
  print(response.body);
  print(response.statusCode);
  print("Finish");
  // final survey = Surveys(
  //   id: -12,
  //   title: "Javascript",
  //   description: "A quiz about programming language",
  //   category: "Programming",
  //   questions: [
  //     Questions(
  //       text: "what does console.log?",
  //       choices: [
  //         Choice(text: "prints data"),
  //         Choice(text: "if statement"),
  //         Choice(text: "best thing"),
  //       ],
  //     ),
  //     Questions(
  //       text: "Which js framework you use?",
  //       choices: [
  //         Choice(text: "React"),
  //         Choice(text: "Svelte"),
  //         Choice(text: "Angular"),
  //       ],
  //     ),
  //   ],
  // );
  // await post_survey(survey, "89112c9df37e076e09646c2a481863fdf8d1c310");
}
