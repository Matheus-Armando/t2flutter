import 'package:flutter/material.dart';

class PatientHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de Consultas'),
      ),
      body: Center(
        child: Text('Esta é a página de Histórico de Consultas'),
      ),
    );
  }
}