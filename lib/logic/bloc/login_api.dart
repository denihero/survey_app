import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:survey/core/models/category.dart';
import 'package:survey/core/models/submission.dart';

import '../../core/models/survey.dart';

Future<bool> login(String username, String password) async {
  var response = await http.post(
    Uri.parse("http://137.184.230.26/account/login/"),
    body: {
      "email": username,
      "password": password,
    },
  );

  if (response.statusCode >= 400) throw UnimplementedError();
  if (response.statusCode == 201 || response.statusCode == 200) {
    return true;
  }
  return false;
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

Future<List<String>> get_categories() async {
  var response = await http.get(
    Uri.parse("http://137.184.230.26/categories/"),
  );
  if (response.statusCode >= 400) {
    throw UnimplementedError();
  }
  return Categories.fromJson(
    jsonDecode(response.body.toString()),
  ).categories;
}

Future<List<Surveys>> get_surveys() async {
  List<Surveys> ls = <Surveys>[];
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
    ls.add(
      Surveys.fromJson(
        jsonDecode(response.body.toString()),
      ),
    );
  }
  return ls;
}

Stream<Surveys> get_surveys_stream() async* {
  var response = await http.get(
    Uri.parse("http://137.184.230.26/surveys/"),
  );
  // print(response.body.toString());
  if (response.statusCode >= 400) {
    throw UnimplementedError();
  }
  int length = jsonDecode(response.body.toString())["count"];
  // print(length);
  for (var i = 9; i < 9+length; i++) {
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

post_sumbissions(Submission sub) async {
  var response = await http.post(
    Uri.parse("http://137.184.230.26/sumbitions/"),
    body: json.encode(sub.toJson()),
    // encoding: "",
    headers: {
      "Content-Type":"application/json",
    }
  );
  print(response.body);
}

void main(List<String> args) async {
  await post_sumbissions(
    Submission(
        participation_email: "denihero81@gmail.com", survey: 1, answer: [1,2]),
  );
}
