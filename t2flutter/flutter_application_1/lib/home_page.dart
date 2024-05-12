// homepage.dart
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Agendamento de Consultas'),
              onPressed: () {
                Navigator.pushNamed(context, '/scheduling');
              },
            ),
            ElevatedButton(
              child: Text('Histórico de Pacientes'),
              onPressed: () {
                Navigator.pushNamed(context, '/history');
              },
            ),
            ElevatedButton(
              child: Text('Perfil do Médico'),
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
          ],
        ),
      ),
    );
  }
}