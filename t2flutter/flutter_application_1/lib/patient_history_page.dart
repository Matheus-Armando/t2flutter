import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'appointment_data.dart';

class PatientHistoryPage extends StatefulWidget {
  @override
  _PatientHistoryPageState createState() => _PatientHistoryPageState();
}

class _PatientHistoryPageState extends State<PatientHistoryPage> {
  @override
  Widget build(BuildContext context) {
    var appointmentData = Provider.of<AppointmentData>(context);

    // Agrupa os compromissos por nome do paciente
    Map<String, List<Map<String, dynamic>>> appointmentsByPatient = {};
    for (var appointment in appointmentData.scheduledAppointments) {
      if (!appointmentsByPatient.containsKey(appointment['patientName'])) {
        appointmentsByPatient[appointment['patientName']] = [];
      }
      appointmentsByPatient[appointment['patientName']]!.add(appointment);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de Consultas'),
      ),
      body: ListView.builder(
        itemCount: appointmentsByPatient.keys.length,
        itemBuilder: (context, index) {
          String patientName = appointmentsByPatient.keys.elementAt(index);
          return ExpansionTile(
            title: Text('Nome do Paciente: $patientName'),
            children: appointmentsByPatient[patientName]!.map((appointment) {
              return ListTile(
                title: Text('Data: ${appointment['date']}'),
                subtitle: Text('Horário: ${appointment['time']}'),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}