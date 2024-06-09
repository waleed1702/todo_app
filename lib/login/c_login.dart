import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginController {
  String loginUrl = 'https://dummyjson.com/auth/login';
  String? id;

  Future<String> loginUser(username, password) async {
    {
      try {
        var res = await http.post(
          Uri.parse(loginUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'username': 'emilys', // username,
            'password': 'emilyspass', //password,
            'expiresInMins': 30,
          }),
        );

        if (res.statusCode == 200) {
          var json = jsonDecode(res.body);
          id = json['id'].toString();
        }
      } catch (e) {
        print(e);
      } finally {
        id = id ?? '';
      }
      return id!;
    }
  }
}
