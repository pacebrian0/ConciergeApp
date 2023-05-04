import 'package:intl/intl.dart';

class Property {
  static const String dateFormat = "MM/dd/yyyy hh:mm:ss";
  int id;
  String name = "";
  int hostID;
  DateTime createdOn;
  int createdBy;
  DateTime modifiedOn;
  int modifiedBy;
  String status;

  Property({
    required this.id,
    required this.hostID,
    required this.name,
    required this.createdOn,
    required this.createdBy,
    required this.modifiedBy,
    required this.modifiedOn,
    required this.status,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
        id: json['id'],
        hostID: json['hostID'],
        name: json['name'],
        createdOn: DateFormat(dateFormat).parse(json['createdOn']),
        createdBy: json['createdBy'],
        modifiedOn: DateFormat(dateFormat).parse(json['modifiedOn']),
        modifiedBy: json['modifiedBy'],
        status: json['status']);
  }
}
