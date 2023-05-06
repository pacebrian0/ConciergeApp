import 'dart:convert';

import 'package:conciergeapp/Models/User.dart';
import 'package:conciergeapp/Services/HttpService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Models/Reservation.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Reservation> reservations = [];
  late User user;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  Map args = {};

  Future<List<Reservation>> getReservations(int id) async {
    String url = 'reservation/user/$id';
    var response = await HttpService().get(url);
    if (response.content.length > 0) {
      return List<Reservation>.from(
          jsonDecode(response.content).map((i) => Reservation.fromJson(i)));
    } else {
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    user = User(id: 0, name: "", surname: "", email: "");

    Future.delayed(Duration.zero, () async {
      // TODO: implement initState
      args = args.isNotEmpty? args:
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      user = args['user'];
      var res = await getReservations(user.id);
      setState(() {
        reservations = res;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(reservations);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, ${user.name} ${user.surname}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  (reservations.length > 0
                      ? 'Here are your reservations:'
                      : 'No Reservations Found'),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          reservations.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: reservations.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Card(
                          child: ListTile(
                            title: Text(
                                reservations[index].reservationDate.toString()),
                            subtitle: Text(
                                'Reservation: #${reservations[index].id}\nRoom: ${reservations[index].roomID}\nReservation Date: ${dateFormat.format(reservations[index].reservationDate)}'),
                            trailing: const Icon(Icons.qr_code),
                            onTap: () {
                              if (context.mounted) {
                                Navigator.pushReplacementNamed(
                                    context, '/reservationDetail',
                                    arguments: {'user': user, 'reservation': reservations[index]});
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                )
              : ElevatedButton(
                  onPressed: () {
                    if (context.mounted) {
                      Navigator.pushReplacementNamed(
                          context, '/reservationForm',
                          arguments: {'user': user});
                    }
                  },
                  child: const Text("Book a reservation"))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (context.mounted) {
            Navigator.pushReplacementNamed(context, '/reservationForm',
                arguments: {'user': user});
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
