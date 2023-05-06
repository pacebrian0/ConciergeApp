import 'dart:convert';
import 'package:conciergeapp/Services/TokenStorage.dart';
import 'package:http/http.dart' as http;

class AuthService{
  //final String baseUrl = 'https://192.168.1.41:44356/api/';
  final String baseUrl = 'http://localhost:44356/api/';

  //check if this can be replaced by UserService.loginUser
  Future<String> login(String email, String password) async {
    try {
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse('${baseUrl}login'));
      request.body = json.encode({
        "username": email,
        "password": password
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      // if (response.statusCode == 200) {
      //   print(await response.stream.bytesToString());
      // }
      // else {
      //   print(response.reasonPhrase);
      // }
      if (response.statusCode == 200) {
        return response.stream.bytesToString();
      } else {
        throw Exception('Failed to login');
      }
    }
    catch (e)
    {
      print(e);
    }


  return "";
  }


  Future<void> logout() async {
    await TokenStorage().deleteToken();
  }

  Future<String> getBearer() async{
    var token = await TokenStorage().getToken();
    if (token == null)
      {
        throw Exception("No Token!");
      }
    var tokenMap = parseJwt(token);
    print(tokenMap);
    return token;

  }

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }


}