import 'package:flutter/material.dart';

class SchedulingPage extends StatefulWidget {
  @override
  _SchedulingPageState createState() => _SchedulingPageState();
}

class _SchedulingPageState extends State<SchedulingPage> {
  List<String> availableTimes = [
    '09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00'
  ];
  DateTime? selectedDate;

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
                  return ListTile(
                    title: Text('${selectedDate?.toIso8601String().substring(0, 10)} ${availableTimes[index]}'),
                    trailing: Icon(Icons.check_circle, color: Colors.green),
                    onTap: () async {
                      bool confirm = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Confirmar Agendamento'),
                          content: Text('Você quer agendar uma consulta para ${selectedDate?.toIso8601String().substring(0, 10)} ${availableTimes[index]}?'),
                          actions: <Widget>[                
                            TextButton(
                              child: Text('Cancelar'),
                              onPressed: () => Navigator.of(context).pop(false),
                            ),
                            TextButton(
                              child: Text('Confirmar'),
                              onPressed: () => Navigator.of(context).pop(true),
                            ),
                          ],
                        ),
                      );
                      if (confirm) {
                        setState(() {
                          availableTimes.removeAt(index);
                        });
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