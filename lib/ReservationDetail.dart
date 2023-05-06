import 'package:conciergeapp/Models/Reservation.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReservationDetail extends StatelessWidget {
 late Reservation reservation;
  Map data = {};
  var QRsize = 200;

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty? data:
    ModalRoute.of(context)?.settings.arguments as Map;

    reservation = data['reservation'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservation Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Reservation Code',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            QrImage(
              data: reservation.reservationCode,
              version: QrVersions.auto,
              size: 200.0,

            ),
            const SizedBox(height: 16.0),
            ListTile(
              title: const Text('Reservation ID'),
              subtitle: Text(reservation.id.toString()),
            ),
            ListTile(
              title: const Text('Room ID'),
              subtitle: Text(reservation.roomID.toString()),
            ),
            ListTile(
              title: const Text('Reservation Date'),
              subtitle: Text(reservation.reservationDate.toString()),
            ),
            ListTile(
              title: const Text('User ID'),
              subtitle: Text(reservation.userID.toString()),
            ),
            ListTile(
              title: const Text('Expires'),
              subtitle: Text(reservation.expiresYN ? 'Yes' : 'No'),
            ),
            ListTile(
              title: const Text('Expiry Date'),
              subtitle: Text(reservation.expiryDate.toString()),
            ),
            ListTile(
              title: const Text('Created On'),
              subtitle: Text(reservation.createdOn.toString()),
            ),
            ListTile(
              title: const Text('Created By'),
              subtitle: Text(reservation.createdBy.toString()),
            ),
            ListTile(
              title: const Text('Modified On'),
              subtitle: Text(reservation.modifiedOn.toString()),
            ),
            ListTile(
              title: const Text('Modified By'),
              subtitle: Text(reservation.modifiedBy.toString()),
            ),
            ListTile(
              title: const Text('Status'),
              subtitle: Text(reservation.status),
            ),
            ListTile(
              title: const Text('Is Active'),
              subtitle: Text(reservation.isActive ? 'Yes' : 'No'),
            ),
          ],
        ),
      ),
    );
  }
}