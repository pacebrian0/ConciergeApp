import 'package:intl/intl.dart';

class Reservation {
  int id;
  int roomID;
  DateTime reservationDate;
  int userID;
  bool expiresYN;
  DateTime expiryDate;
  String reservationCode = "";
  DateTime createdOn;
  int createdBy;
  DateTime modifiedOn;
  int modifiedBy;
  String status;
  bool isActive;

  Reservation({
    required this.id,
    required this.roomID,
    required this.reservationCode,
    required this.reservationDate,
    required this.userID,
    required this.expiresYN,
    required this.expiryDate,
    required this.createdOn,
    required this.createdBy,
    required this.modifiedBy,
    required this.modifiedOn,
    required this.status,
    required this.isActive,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'] as int,
      roomID: json['roomID'] as int,
      userID: json['userID'] as int,
      expiresYN: json['expiresYN'] as bool,
      expiryDate: DateFormat("yyyy-MM-ddTHH:mm:ss").parse(json['expiryDate'], true).toLocal(),
      reservationCode: json['reservationCode'] as String,
      createdOn: DateFormat("yyyy-MM-ddTHH:mm:ss").parse(json['createdOn'], true).toLocal(),
      createdBy: json['createdBy'] as int,
      modifiedOn: DateFormat("yyyy-MM-ddTHH:mm:ss").parse(json['modifiedOn'], true).toLocal(),
      modifiedBy: json['modifiedBy'] as int,
      status: json['status'] as String,
      isActive: json['isActive'] as bool,
      reservationDate: DateFormat("yyyy-MM-ddTHH:mm:ss").parse(json['reservationDate'], true).toLocal(),
    );
  }
}
