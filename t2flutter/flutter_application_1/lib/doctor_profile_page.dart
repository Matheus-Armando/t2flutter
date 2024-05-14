import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String username;
  final String password;
  final String name;
  final String email;
  final String specialty;
  final String description;

  User(
      {required this.username,
      required this.password,
      required this.name,
      required this.email,
      required this.specialty,
      required this.description});
}

class DoctorProfilePage extends StatefulWidget {
  @override
  _DoctorProfilePageState createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  String username = '';
  User? userInfo;

  Map<String, String> userEmails = {
    'Matheus': 'matheus@exemplo.com',
    'Roger': 'roger@exemplo.com',
  };

  Map<String, String> userSpecialties = {
    'Matheus': 'Cardiologista',
    'Roger': 'Neurologista',
  };

  Map<String, String> userDescriptions = {
    'Matheus':
        'Dr. Matheus é um cardiologista com mais de 10 anos de experiência.',
    'Roger':
        'Dr. Roger é um neurologista renomado com vasta experiência em seu campo.',
  };

  Future<User> getUserInfo(String username) async {
    String email = userEmails[username] ?? 'unknown@exemplo.com';
    String specialty =
        userSpecialties[username] ?? 'Desconhecida';
    String description =
        userDescriptions[username] ?? 'Descrição não disponível';
    return Future.delayed(
        Duration(seconds: 1),
        () => User(
            username: username,
            password: '123',
            name: 'Nome do Usuário',
            email: email,
            specialty: specialty,
            description: description));
  }

  Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? '';
  }

  @override
  void initState() {
    super.initState();
    getUsername().then((value) => setState(() {
          username = value;
          getUserInfo(username).then((user) => setState(() {
                userInfo = user;
              }));
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil do Médico'),
      ),
      body: userInfo == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              width: MediaQuery.of(context).size.width *
                  1.0, 
              height: MediaQuery.of(context).size.height *
                  1.0, 
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style.copyWith(decoration: TextDecoration.none),
                        children: <TextSpan>[
                          TextSpan(text: 'Olá ', style: TextStyle(color: Colors.black)),
                          TextSpan(
                              text: '${userInfo!.username}',
                              style: TextStyle(color: Colors.purple)),
                          TextSpan(text: ', bem vindo ao seu perfil!', style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Text('Nome: ${userInfo!.username}',
                        style: TextStyle(fontSize: 18)),
                    Divider(thickness: 0.5),
                    SizedBox(height: 5),
                    Text('Email: ${userInfo!.email}',
                        style: TextStyle(fontSize: 18)),
                    Divider(thickness: 0.5),
                    SizedBox(height: 5),
                    Text('Especialidade: ${userInfo!.specialty}',
                        style: TextStyle(fontSize: 18)),
                    Divider(thickness: 0.5),
                    SizedBox(height: 5),
                    Text('Descrição: ${userInfo!.description}',
                        style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ),
    );
  }
}
