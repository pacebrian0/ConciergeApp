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
      id: json['id'],
      roomID: json['roomID'],
      userID: json['userID'],
      expiresYN: json['expiresYN'],
      expiryDate: json['expiryDate'],
      reservationCode: json['reservationCode'],
      createdOn: json['createdOn'],
      createdBy: json['createdBy'],
      modifiedOn: json['modifiedOn'],
      modifiedBy: json['modifiedBy'],
      status: json['status'],
      isActive: json['isActive'],
      reservationDate: json['reservationDate'],
    );
  }
}
