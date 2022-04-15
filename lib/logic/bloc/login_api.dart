import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

Future<bool> loginb(String username, String password) async {
  Response response;
  var dio = Dio();
  response = await dio.post(
      'http://45.32.114.90:8002/login/http://45.32.114.90:8002/login/',
      data: {
        'username': username,
        'password': password,
      });

  print(response.statusCode);
  print(response.data.toString());
  return false;
}

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
