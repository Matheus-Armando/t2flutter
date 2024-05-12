import 'package:flutter/material.dart';

class DoctorProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil do Médico'),
      ),
      body: Center(
        child: Text('Esta é a página de Perfil do Médico'),
      ),
    );
  }
}