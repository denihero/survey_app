import 'dart:convert';

import 'package:http/http.dart' as http;

Future<bool> login(String username, String password) async {
  var response = await http.post(
    Uri.parse("http://45.32.114.90:8002/account/login/"),
    body: {
      "email": username,
      "password": password,
    },
  );
  print(response.body);

  if (response.statusCode == 201 || response.statusCode == 200) {
    return true;
  }
  return false;
}

Future<bool> register(String username, String password) async {
  var response = await http.post(
    Uri.parse("http://45.32.114.90:8002/account/register/"),
    body: {
      "email": username,
      "password": password,
      "password_confirmation": password,
    },
  );
  if (response.statusCode == 201 || response.statusCode == 200) {
    return true;
  }
  return false;
}

class Categories {
  final List<String> categories;

  factory Categories.fromJson(List<dynamic> json) {
    var x = <String>[];
    var c = json.forEach(
      (element) => x.add(
        element["name"],
      ),
    );
    return Categories(x);
  }
  Categories(this.categories);
}

Future<List<String>> get_categories() async {
  var response = await http.get(
    Uri.parse("http://45.32.114.90:8002/categories/"),
  );
  return Categories.fromJson(
    jsonDecode(response.body.toString()),
  ).categories;
}
