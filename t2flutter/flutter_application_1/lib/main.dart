import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'scheduling_page.dart';
import 'patient_history_page.dart';
import 'doctor_profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/scheduling': (context) => SchedulingPage(),
        '/history': (context) => PatientHistoryPage(),
        '/profile': (context) => DoctorProfilePage(),
      },
    );
  }
}



