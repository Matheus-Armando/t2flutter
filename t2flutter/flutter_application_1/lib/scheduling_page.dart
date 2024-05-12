import 'package:flutter/material.dart';

class SchedulingPage extends StatefulWidget {
  @override
  _SchedulingPageState createState() => _SchedulingPageState();
}

class _SchedulingPageState extends State<SchedulingPage> {
  List<String> availableTimes = [
    '09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agendamento de Consultas'),
      ),
      body: ListView.builder(
        itemCount: availableTimes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(availableTimes[index]),
            trailing: Icon(Icons.check_circle, color: Colors.green),
            onTap: () async {
              bool confirm = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Confirmar Agendamento'),
                  content: Text('Você quer agendar uma consulta para ${availableTimes[index]}?'),
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
    );
  }
}