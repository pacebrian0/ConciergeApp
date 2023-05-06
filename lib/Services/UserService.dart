import 'dart:convert';

import 'package:conciergeapp/Models/User.dart';
import 'dart:async';

import 'package:conciergeapp/Services/HttpService.dart';
import 'package:conciergeapp/Services/TokenStorage.dart';

class UserService {
  // Future<User?>? getUser(String token) async {
  //   final response = await http.get(Uri.parse('$baseUrl/user'),
  //       headers: {'Authorization': 'Bearer $token'});
  //
  //   if (response.statusCode == 200) {
  //     final jsonData = json.decode(response.body);
  //     return User.fromJson(jsonData);
  //   } else {
  //     throw Exception('Failed to fetch user data');
  //   }
  // }
  HttpService hs = HttpService();

  Future<User> registerUser(
      String email, String password, String name, String surname) async {
    var res = await hs.post('auth/register', false, {
      'username': email,
      'password': password,
      'name': name,
      'surname': surname
    });
    if (res.code == 200) {
      var content = jsonDecode(res.content);
      var token = content['token'];
      var id = content['id'];
      await TokenStorage().saveToken(token);

      return User(id: id, name: name, surname: surname, email: email);
    } else {
      throw Exception("Issue with registerUser: ${res.code}");
    }
  }

  // maybe replace AuthService.login
  Future<User> loginUser(String email, String password) async {
    var res = await hs
        .post('auth/login', false, {'username': email, 'password': password});
    if (res.code == 200) {
      var content = jsonDecode(res.content);
      var token = content['token'];
      var id = content['id'];
      await TokenStorage().saveToken(token);
      var res2 = await hs.get('user/$id');

      if (res2.code == 200) {
        var content2 = jsonDecode(res2.content);
        return User(id: id, name: content2['name'], surname: content2["surname"], email: email);
      }
      throw Exception("Issue with loginUser: ${res2.code}");
    } else {
      throw Exception("Issue with loginUser: ${res.code}");
    }
  }
}
