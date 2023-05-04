import 'package:conciergeapp/Models/Auth.dart';

class HttpResponse{
  String content = "";
  int code = 0;

  HttpResponse(
      {required this.content, required this.code});
}