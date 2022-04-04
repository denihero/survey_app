import 'package:http/http.dart' as http;




Future<bool> login(String username, String password) async {
  var response =
      await http.post(Uri.parse("http://127.0.0.1:8000/account/login/"), body: {
    "email": username,
    "password": password,
  });

  if (response.statusCode == 201 || response.statusCode == 200) {
    return true;
  }
  return false;
}
