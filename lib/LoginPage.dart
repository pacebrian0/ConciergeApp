import 'package:conciergeapp/Services/AuthService.dart';
import 'package:conciergeapp/Services/UserService.dart';
import 'package:flutter/material.dart';

import 'Models/User.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String password = "";
  String passHash = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page")
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Card(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Email",
                ),
                onChanged: (value) {
                  email = value.trim();
                },
              ),
            ),
            Card(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
                onChanged: (value) {
                  password = value.trim();
                },
              ),
            ),
            TextButton(
                onPressed: () async {
                  var user = await SignIn(context, email, password, true);
                  if (user.email.isNotEmpty)
                    {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.pushReplacementNamed(context, '/dashboard',
                            arguments: {'user': user});
                      });
                    }
                },
                child: const Text("Login to Local server")),
            // TextButton(
            //     onPressed: () {
            //       SignIn(context, email, password, false);
            //     },
            //     child: const Text("Login to Remote server")),
            TextButton(
                onPressed: () {
                  if (!context.mounted) return;
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushReplacementNamed(context, '/register', arguments: {});
                  });
                },
                child: const Text("Register")),
          ],
        ),
      ),
    );
  }

  Future<User> SignIn(BuildContext context, String email, String password, bool local) async {
    if (local)
      {
        return await UserService().loginUser(email,password);
      }
    else
      {
        return await UserService().loginUser(email,password);
      }
  }
}
