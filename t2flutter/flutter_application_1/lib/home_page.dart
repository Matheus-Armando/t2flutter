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
        title: Text('Home Page'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style.copyWith(decoration: TextDecoration.none),
                children: <TextSpan>[
                  TextSpan(text: 'Olá, ', style: TextStyle(color: Colors.black)),
                  TextSpan(
                      text: '$username',
                      style: TextStyle(color: Colors.purple.shade400), ),
                ],
              ),
            ),
          ),
          Container(
            height: 400,
            width: 400,
            child: Image.asset('images/home.jpg', fit: BoxFit.cover),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 300,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(250, 50),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/scheduling');
                      },
                      child: Text('Agendamento de Consultas'),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 300,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(250, 50),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/history');
                      },
                      child: Text('Histórico de Pacientes'),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 300,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(250, 50),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                      child: Text('Perfil do Médico'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
