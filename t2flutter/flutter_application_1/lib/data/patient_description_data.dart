import 'package:flutter/material.dart';

class PatientDescriptionData extends ChangeNotifier {
  Map<String, String> patientDescriptions = {};

  void addDescription(String patientName, String description) {
    patientDescriptions[patientName] = description;
    notifyListeners();
  }
}