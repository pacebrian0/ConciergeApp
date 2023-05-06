import 'dart:convert';
import 'package:conciergeapp/Models/Auth.dart';
import 'package:conciergeapp/Services/AuthService.dart';
import 'package:http/http.dart' as http;
import 'package:conciergeapp/Models/HttpResponse.dart';

class HttpService {
  //final String baseUrl = 'https://192.168.1.41:44356/api/';
  final String baseUrl = 'https://192.168.1.109:32768/api/';
  final AuthService as = AuthService();


  Future<HttpResponse> get(String endpoint) async {

    var bearer = await as.getBearer();
    // if (DateTime.now().toUtc().compareTo(auth.Expiry.toUtc()) > 0)
    // {
    //   //navigate to login
    // }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearer'
    };

    var request = http.Request('GET', Uri.parse('$baseUrl$endpoint'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    // if (response.statusCode == 200) {
    //   print(await response.stream.bytesToString());
    // }
    // else {
    // print(response.reasonPhrase);
    // }

    return HttpResponse(content: await response.stream.bytesToString(), code: response.statusCode);
  }

  Future<HttpResponse> post(String endpoint, bool auth, Map<String, String> args ) async {
    // if (DateTime.now().toUtc().isAfter(auth.Expiry.toUtc()))
    // {
    //   //navigate to login
    // }
    var headers = {'Content-Type': 'application/json',};

    if (auth){
      headers['Authorization']= 'Bearer ${await as.getBearer()}';
    }


    var request = http.Request('POST', Uri.parse('$baseUrl$endpoint'));
    request.body = json.encode(args);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    // if (response.statusCode == 200) {
    //   print(await response.stream.bytesToString());
    // }
    // else {
    // print(response.reasonPhrase);
    // }

    return HttpResponse(content: await response.stream.bytesToString(), code: response.statusCode);
  }
}
