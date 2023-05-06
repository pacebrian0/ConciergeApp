import 'dart:convert';

import 'package:conciergeapp/Models/Property.dart';
import 'package:conciergeapp/Models/Reservation.dart';
import 'package:conciergeapp/Models/Room.dart';
import 'package:conciergeapp/Services/HttpService.dart';
import 'package:flutter/material.dart';

class ReservationForm extends StatefulWidget {
  final Reservation? reservation;
  final Function(Reservation) onSave;

  ReservationForm({super.key, this.reservation, required this.onSave});

  @override
  State<ReservationForm> createState() => _ReservationFormState();
}

class _ReservationFormState extends State<ReservationForm> {
  final _formKey = GlobalKey<FormState>();
  late int _id = 0;
  late int _roomID;
  late DateTime _reservationDate;
  late int _userID;
  late bool _expiresYN;
  late DateTime _expiryDate;
  late String _reservationCode;
  late DateTime _createdOn;
  late int _createdBy;
  late DateTime _modifiedOn;
  late int _modifiedBy;
  late String _status;
  late bool _isActive;

  late List<Property> _properties = [];
  late List<Room> _rooms = [];
  int selectedProperty = -1;
  int selectedRoom = -1;

  Future<DateTime?> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (picked != null) {
      return picked;
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.reservation != null) {
      _roomID = widget.reservation!.roomID;
      _reservationDate = widget.reservation!.reservationDate;
      _userID = widget.reservation!.userID;
      _expiresYN = widget.reservation!.expiresYN;
      _expiryDate = widget.reservation!.expiryDate;
      _reservationCode = widget.reservation!.reservationCode;
      _status = widget.reservation!.status;
      _isActive = widget.reservation!.isActive;
    }
    Future.delayed(Duration.zero, () async {
      if (_properties.isEmpty) {
        _properties = await getProperties();
      }
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Reservation newReservation = Reservation(
        id: 0,
        roomID: _roomID,
        reservationDate: _reservationDate,
        userID: _userID,
        expiresYN: _expiresYN,
        expiryDate: _expiryDate,
        reservationCode: _reservationCode,
        createdOn: _createdOn,
        createdBy: _createdBy,
        modifiedOn: _modifiedOn,
        modifiedBy: _modifiedBy,
        status: _status,
        isActive: _isActive,
      );
      widget.onSave(newReservation);
      Navigator.pop(context);
    }
  }

  Future<List<Property>> getProperties() async {
    var res = await HttpService().get("property/");
    if (res.content.length == 0 || res.content == "[]") {
      return <Property>[];
    }
    return List<Property>.from(
        jsonDecode(res.content).map((i) => Property.fromJson(i)));
  }

  Future<List<Room>> getRooms(int property) async {
    var res = await HttpService().get("room/property/$property");
    if (res.content.length == 0 || res.content == "[]") {
      return <Room>[];
    } else {
      return List<Room>.from(
          jsonDecode(res.content).map((i) => Room.fromJson(i)));
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime? selectedDate;

    late List<Room> roomList = <Room>[];

    getRooms(selectedProperty).then((value) => roomList = value);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.reservation == null
            ? 'Create Reservation'
            : 'Edit Reservation'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  initialValue: _id.toString() ?? "0",
                  decoration: const InputDecoration(labelText: 'Reservation'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a reservation';
                    }
                    return null;
                  },
                  onSaved: (value) => _id = int.parse(value!),
                ),
                FormField<DateTime>(
                  initialValue: DateTime.now(),
                  builder: (FormFieldState<DateTime> state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () => _selectDate(context).then((value) =>
                              selectedDate = value ?? DateTime.now()),
                          child: const Text('Select a date'),
                        ),
                        Text(
                          selectedDate == null
                              ? 'No date selected'
                              : selectedDate.toString(),
                          style: const TextStyle(color: Colors.black),
                        ),
                        state.hasError
                            ? Text(state.errorText ?? "",
                                style: const TextStyle(color: Colors.red))
                            : Container(),
                      ],
                    );
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a date';
                    }
                    return null;
                  },
                  onSaved: (value) =>
                      _reservationDate = value ?? DateTime.now(),
                ),
                TextFormField(
                    initialValue: "0",
                    decoration:
                        const InputDecoration(labelText: 'Property Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a property name';
                      }
                      return null;
                    },
                    onChanged: (value) =>
                    {
                      if(value != "")
                        setState(() {
                          selectedProperty = int.parse(value);
                          selectedRoom = -1;
                        })
                    }),
                DropdownButtonFormField<int>(
                  items: roomList.map((room) {
                    return DropdownMenuItem<int>(
                      value: room.id,
                      child: Text(room.name),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() {
                    selectedRoom = value!;
                  }),
                  decoration: const InputDecoration(labelText: 'Room Number'),
                  validator: (value) {
                    if (value! == -1) {
                      return 'Please enter a room number';
                    }
                    return null;
                  },
                  value: selectedRoom,
                  onSaved: (value) => _roomID = value!,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Save Reservation'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

