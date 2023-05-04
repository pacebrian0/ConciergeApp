// import 'package:conciergeapp/LoginPage.dart';
// import 'package:conciergeapp/Services/UserService.dart';
// import 'package:conciergeapp/services/tokenstorage.dart';
// import 'package:flutter/material.dart';
// import 'package:conciergeapp/Models/User.dart';
//
// class ProtectedRoute extends StatelessWidget {
//   final Widget child;
//
//   const ProtectedRoute({super.key, required this.child});
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<String?>(
//       future: TokenStorage().getToken(),
//       builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           if (snapshot.hasData && snapshot.data != null) {
//             // verify the JWT token and fetch user data
//             return FutureBuilder<User?>(
//               future: UserService().getUser(snapshot.data!),
//               builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   if (snapshot.hasData && snapshot.data != null) {
//                     return child;
//                   } else {
//                     return const LoginPage();
//                   }
//                 } else {
//                   return const CircularProgressIndicator();
//                 }
//               },
//             );
//           } else {
//             return const LoginPage();
//           }
//         } else {
//           return const CircularProgressIndicator();
//         }
//       },
//     );
//   }
// }
