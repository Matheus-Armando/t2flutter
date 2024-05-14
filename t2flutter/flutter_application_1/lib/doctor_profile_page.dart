import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String username;
  final String password;
  final String name;
  final String email;
  final String specialty;
  final String description;

  User({required this.username, required this.password, required this.name, required this.email, required this.specialty, required this.description});
}

class DoctorProfilePage extends StatefulWidget {
  @override
  _DoctorProfilePageState createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  String username = '';
  User? userInfo;

  // Mapa de exemplo de nomes de usuários para endereços de e-mail
  Map<String, String> userEmails = {
    'matheus': 'matheus@exemplo.com',
    'roger': 'roger@exemplo.com',
  };

  // Mapa de exemplo de nomes de usuários para especialidades
  Map<String, String> userSpecialties = {
    'matheus': 'Cardiologista',
    'roger': 'Neurologista',
  };

  // Mapa de exemplo de nomes de usuários para descrições
  Map<String, String> userDescriptions = {
    'matheus': 'Dr. Matheus é um cardiologista com mais de 10 anos de experiência.',
    'roger': 'Dr. Roger é um neurologista renomado com vasta experiência em seu campo.',
  };

  Future<User> getUserInfo(String username) async {
    // Substitua isso pelo seu próprio mecanismo de recuperação de informações do usuário
    String email = userEmails[username.toLowerCase()] ?? 'unknown@exemplo.com';
    String specialty = userSpecialties[username.toLowerCase()] ?? 'Desconhecida';
    String description = userDescriptions[username.toLowerCase()] ?? 'Descrição não disponível';
    return Future.delayed(Duration(seconds: 1), () => User(username: username, password: '123', name: 'Nome do Usuário', email: email, specialty: specialty, description: description));
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
            width: MediaQuery.of(context).size.width * 1.0, // 70% da largura da tela
            height: MediaQuery.of(context).size.height * 1.0, // 70% da altura da tela
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Olá, ${userInfo!.username}, bem vindo ao seu perfil!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text('Nome: ${userInfo!.username}', style: TextStyle(fontSize: 18)),
                  Divider(thickness: 0.5),
                  SizedBox(height: 5),
                  Text('Email: ${userInfo!.email}', style: TextStyle(fontSize: 18)),
                  Divider(thickness: 0.5),
                  SizedBox(height: 5),
                  Text('Especialidade: ${userInfo!.specialty}', style: TextStyle(fontSize: 18)),
                  Divider(thickness: 0.5),
                  SizedBox(height: 5),
                  Text('Descrição: ${userInfo!.description}', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
    );
  }
}