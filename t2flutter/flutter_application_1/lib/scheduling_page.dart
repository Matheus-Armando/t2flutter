import 'package:flutter/material.dart';

class SchedulingPage extends StatefulWidget {
  @override
  _SchedulingPageState createState() => _SchedulingPageState();
}

class _SchedulingPageState extends State<SchedulingPage> {
  List<String> availableTimes = [
    '09:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00'
  ];
  DateTime? selectedDate;
  String? patientName;
  List<Map<String, dynamic>> scheduledAppointments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agendamento de Consultas'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            child: Text('Escolha uma data'),
            onPressed: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(DateTime.now().year + 1),
              );
              if (date != null) {
                setState(() {
                  selectedDate = date;
                });
              }
            },
          ),
          if (selectedDate == null)
            Expanded(
              child: Center(
                child: Text('Por favor, selecione uma data.'),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: availableTimes.length,
                itemBuilder: (context, index) {
                  String time = availableTimes[index];
                  Map<String, dynamic> appointment =
                      scheduledAppointments.firstWhere(
                    (appointment) =>
                        appointment['time'] == time &&
                        appointment['date'] ==
                            selectedDate?.toIso8601String().substring(0, 10),
                    orElse: () => <String, dynamic>{},
                  );
                  return ListTile(
                    title: Text(
                        '${selectedDate?.toIso8601String().substring(0, 10)} ${availableTimes[index]}'),
                    subtitle: appointment.isNotEmpty
                        ? Text('Paciente: ${appointment['patientName']}')
                        : null,
                    trailing: Icon(Icons.check_circle, color: Colors.green),
                    onTap: () async {
                      String time = availableTimes[index];
                      Map<String, dynamic> appointment =
                          scheduledAppointments.firstWhere(
                        (appointment) =>
                            appointment['time'] == time &&
                            appointment['date'] ==
                                selectedDate
                                    ?.toIso8601String()
                                    .substring(0, 10),
                        orElse: () => <String, dynamic>{},
                      );

                      if (appointment.isNotEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Horário Agendado'),
                            content: Text(
                                'Este horário já foi agendado para ${appointment['patientName']}.'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                              TextButton(
                                child: Text('Desagendar'),
                                onPressed: () {
                                  setState(() {
                                    scheduledAppointments.remove(appointment);
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      } else {
                        TextEditingController _controller =
                            TextEditingController();
                        bool confirm = await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Confirmar Agendamento'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                    'Você quer agendar uma consulta para ${selectedDate?.toIso8601String().substring(0, 10)} $time?'),
                                TextField(
                                  controller: _controller,
                                  decoration: InputDecoration(
                                    labelText: 'Nome do Paciente',
                                  ),
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Cancelar'),
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                              ),
                              TextButton(
                                child: Text('Confirmar'),
                                onPressed: () {
                                  String patientName = _controller.text;
                                  Navigator.of(context)
                                      .pop(patientName.isNotEmpty);
                                  if (patientName.isNotEmpty) {
                                    setState(() {
                                      scheduledAppointments.add({
                                        'time': time,
                                        'date': selectedDate
                                            ?.toIso8601String()
                                            .substring(0, 10),
                                        'patientName': patientName,
                                      });
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
