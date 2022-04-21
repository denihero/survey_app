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
  print(response.body.toString());

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

Future<Map<String, String>> get_categories() async {
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

//not correct function
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
    print(response.body.toString());
    ls.add(
      Surveys.fromJson(
        jsonDecode(response.body.toString()),
      ),
    );
  }
  return ls;
}

//not correct function
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
Stream<Surveys> get_surveys_stream_fixed() async* {
  var response = await http.get(
    Uri.parse("http://137.184.230.26/surveys/"),
  );
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
    var response = await http.get(
      Uri.parse(next_one),
    );
    final survey = jsonDecode(response.body.toString());
    next_one = survey["next"];
    yield Surveys.fromJson(survey["results"][0]);
  }
}

post_sumbissions(Submission sub) async {
  var response = await http.post(Uri.parse("http://137.184.230.26/sumbitions/"),
      body: json.encode(sub.toJson()),
      // encoding: "",
      headers: {
        "Content-Type": "application/json",
      });
  print(response.body);
}

post_survey() {}

void main(List<String> args) async {
  print(await get_categories());
}
