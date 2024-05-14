import 'package:flutter/foundation.dart';

class AppointmentData extends ChangeNotifier {
  List<Map<String, dynamic>> _scheduledAppointments = [];

  List<Map<String, dynamic>> get scheduledAppointments => _scheduledAppointments;

  void addAppointment(Map<String, dynamic> appointment) {
    _scheduledAppointments.add(appointment);
    notifyListeners();
  }

  void removeAppointment(Map<String, dynamic> appointment) {
    _scheduledAppointments.remove(appointment);
    notifyListeners();
  }
}