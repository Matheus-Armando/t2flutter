import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = '';

  Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? '';
  }

  @override
  void initState() {
    super.initState();
    getUsername().then((value) => setState(() {
          username = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Olá, $username',
            style: TextStyle(fontSize: 24),
          ),
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