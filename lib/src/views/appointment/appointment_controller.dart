import 'package:flutter/material.dart';
import 'package:flutterfeatures/src/views/appointment/appointment_service.dart';

class AppointmentController extends ChangeNotifier {
  AppointmentController(this._appointmentService);

  final AppointmentService _appointmentService;

  late List? _appointmentList;
  List? get appointmentList => _appointmentList;
  setAppointmentList(List? items) {
    _appointmentList = items;
    notifyListeners();
  }

  late bool _isConnectedToInternet;

  bool get isConnectedToInternet => _isConnectedToInternet;

  Future<List?> getAppointments() async {
    var lst = await _appointmentService.getAppointments();
    setAppointmentList(lst);
    return appointmentList;
  }

  //time variable for meeting
  late String _appointmentTime;
  String get appointmentTime => _appointmentTime;

  setAppointmentTime(String time) {
    _appointmentTime = time;
    notifyListeners();
  }

  //User form Controller and properties
  late String _username;
  String get username => _username;
  setusername(String name) {
    _username = name;
    notifyListeners();
  }
}
