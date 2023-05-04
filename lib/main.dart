import 'dart:io';

import 'package:conciergeapp/Dashboard.dart';
import 'package:conciergeapp/Forms/ReservationForm.dart';
import 'package:conciergeapp/LoadingPage.dart';
import 'package:conciergeapp/LoginPage.dart';
import 'package:conciergeapp/PropertyDetail.dart';
import 'package:conciergeapp/RegisterPage.dart';
import 'package:conciergeapp/ReservationDetail.dart';
import 'package:conciergeapp/RoomDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  //ByteData data = await PlatformAssetBundle().load('lib/Assets/ca/lets-encrypt-r3.pem');
  //SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => LoadingPage(),
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/dashboard': (context) => Dashboard(),
        '/property': (context) => PropertyDetail(),
        '/room': (context) => RoomDetail(),
        '/reservation': (context) => ReservationDetail(),
        '/reservationForm': (context) => ReservationForm(onSave: (Reservation ) {  },),
      },
      debugShowCheckedModeBanner: false,
      title: 'Concierge',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
