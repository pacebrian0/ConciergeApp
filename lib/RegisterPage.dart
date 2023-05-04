import 'package:conciergeapp/Services/UserService.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    String name = "";
    String surname = "";
    String email = "";
    String password = "";

    return Scaffold(
      appBar: AppBar(title: const Text("Welcome to Concierge!")),
      body: Column(
        children: [
          Visibility(
            //visible: !isRegistered,
            child: Card(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Name",
                ),
                onChanged: (value) {
                  name = value;
                },
              ),
            ),
          ),
          Visibility(
            //visible: !isRegistered,
            child: Card(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Surname",
                ),
                onChanged: (value) {
                  surname = value;
                },
              ),
            ),
          ),
          Visibility(
            //visible: !isRegistered,
            child: Card(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Email",
                ),
                onChanged: (value) {
                  email = value.trim();
                },
              ),
            ),
          ),
          Visibility(
            //visible: !isRegistered,
            child: Card(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
                initialValue: password,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
              ),
            ),
          ),
          Visibility(
            //visible: !isRegistered,
            child: TextButton(
                onPressed: () async {
                  var user = await UserService()
                      .registerUser(email, password, name, surname);
                  if (context.mounted) {
                    Navigator.pushReplacementNamed(context, '/dashboard',
                        arguments: {'user': user});
                  }
                },
                child: const Text("Register")),
          ),
          // Visibility(
          //   visible: isRegistered,
          //   child: Card(
          //     child: TextFormField(
          //       decoration: const InputDecoration(labelText: "Confirmation Code"),
          //       onChanged: (value) {
          //         confirmationcode = value;
          //       },
          //     ),
          //   ),
          // ),
          // Visibility(
          //   visible: isRegistered,
          //   child: TextButton(
          //     onPressed: () async {
          //       if (confirmationcode.isNotEmpty) {
          //         var usr = await ConfirmRegister(context, name, surname, email,
          //             password, confirmationcode);
          //         if (usr != null) {
          //           WidgetsBinding.instance.addPostFrameCallback((_) {
          //             Navigator.pushReplacementNamed(context, '/dashboard',
          //                 arguments: {'user': usr});
          //           });
          //         }
          //       }
          //     },
          //     child: const Text("Confirm code"),
          //   ),
          // ),
        ],
      ),
    );
  }
}
