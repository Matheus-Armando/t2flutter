import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/appointment_data.dart';
import 'package:intl/intl.dart';

class PatientDescriptionData extends ChangeNotifier {
  Map<String, String> patientDescriptions = {};

  void addDescription(String patientName, String description) {
    patientDescriptions[patientName] = description;
    notifyListeners();
  }
}

class PatientHistoryPage extends StatefulWidget {
  @override
  _PatientHistoryPageState createState() => _PatientHistoryPageState();
}

class _PatientHistoryPageState extends State<PatientHistoryPage> {
  Future<void> showDescriptionDialog(String patientName) async {
    TextEditingController descriptionController = TextEditingController();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Adicionar descrição para $patientName'),
          content: TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              labelText: 'Descrição',
            ),
            maxLines: 3,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Salvar'),
              onPressed: () {
                Provider.of<PatientDescriptionData>(context, listen: false)
                    .addDescription(patientName, descriptionController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  TextEditingController filterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appointmentData = Provider.of<AppointmentData>(context);
    var patientDescriptionData = Provider.of<PatientDescriptionData>(context);

    Map<String, List<Map<String, dynamic>>> appointmentsByPatient = {};
    for (var appointment in appointmentData.scheduledAppointments) {
      if (!appointmentsByPatient.containsKey(appointment['patientName'])) {
        appointmentsByPatient[appointment['patientName']] = [];
      }
      appointmentsByPatient[appointment['patientName']]!.add(appointment);
    }

    // Filtrar os nomes dos pacientes
    String filter = filterController.text;
    var filteredPatientNames = appointmentsByPatient.keys.where((patientName) {
      return patientName.toLowerCase().contains(filter.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de Consultas'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: filterController,
              decoration: InputDecoration(
                labelText: 'Filtrar por nome do paciente',
              ),
              onChanged: (value) {
                setState(() {}); // Reconstruir o widget quando o filtro mudar
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPatientNames.length,
              itemBuilder: (context, index) {
                String patientName = filteredPatientNames[index];
                return ExpansionTile(
                  title: Text(patientName),
                  children: [
                    ListTile(
                      title: Text(
                          'Informações: ${patientDescriptionData.patientDescriptions[patientName] ?? 'Nenhuma informação fornecida.'}'),
                    ),
                    ...appointmentsByPatient[patientName]!.map((appointment) {
                      DateTime date = DateTime.parse(appointment['date']);
                      String formattedDate =
                          DateFormat('dd/MM/yyyy').format(date);

                      return ListTile(
                        title: Text('Data: $formattedDate'),
                        subtitle: Text('Horário: ${appointment['time']}'),
                      );
                    }).toList(),
                    TextButton(
                      onPressed: () => showDescriptionDialog(patientName),
                      child: Text(
                          'Adicionar/alterar informações sobre o paciente'),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
