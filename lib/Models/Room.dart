import 'package:intl/intl.dart';

class Room {
  static const String dateFormat = "MM/dd/yyyy hh:mm:ss";
  int id;
  String name = "";
  int propertyID;
  DateTime createdOn;
  int createdBy;
  DateTime modifiedOn;
  int modifiedBy;
  String status;

  Room({
    required this.id,
    required this.propertyID,
    required this.name,
    required this.createdOn,
    required this.createdBy,
    required this.modifiedBy,
    required this.modifiedOn,
    required this.status,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
        id: json['id'],
        propertyID: json['propertyID'],
        name: json['name'],
        createdOn: DateFormat(dateFormat).parse(json['createdOn']),
        createdBy: json['createdBy'],
        modifiedOn: DateFormat(dateFormat).parse(json['modifiedOn']),
        modifiedBy: json['modifiedBy'],
        status: json['status']);
  }
}
