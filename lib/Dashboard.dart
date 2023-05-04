import 'dart:convert';

import 'package:conciergeapp/Models/User.dart';
import 'package:conciergeapp/Services/HttpService.dart';
import 'package:flutter/material.dart';

import 'Models/Reservation.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Reservation> reservations = [];
  late User user;

  Future<List<Reservation>> getReservations(int id) async {
    String url = 'reservation/user/name/$id';
    var response = await HttpService().get(url);
    if(response.content.length > 0) {
      return List<Reservation>.from(
        jsonDecode(response.content).map((i) => Reservation.fromJson(i)));
    } else {
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    user = User(id: 0,name: "",surname: "",email: "");

    Future.delayed(Duration.zero, ()
    async {
      // TODO: implement initState
      final args =
      ModalRoute
          .of(context)!
          .settings
          .arguments as Map<String, dynamic>;
      user = args['user'];
      reservations = await getReservations(user.id);
    });

  }

  @override
  Widget build(BuildContext context) {
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
                                'Reservation: #${reservations[index].id}\nRoom: ${reservations[index].roomID}\nCreated on: ${reservations[index].createdOn}'),
                            trailing: const Icon(Icons.qr_code),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : ElevatedButton(
                  onPressed: () {
                    if (context.mounted) {
                      Navigator.pushReplacementNamed(context, '/reservationForm',
                          arguments: {'user': user});
                    }
                  },
                  child: const Text("Book a reservation"))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Perform action when FAB is pressed
          print('FAB pressed');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
