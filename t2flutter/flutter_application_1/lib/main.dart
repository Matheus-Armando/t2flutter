import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'scheduling_page.dart';
import 'patient_history_page.dart';
import 'doctor_profile_page.dart';
import 'appointment_data.dart'; // Importe o arquivo appointment_data.dart

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppointmentData(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => HomePage());
          case '/login':
            return MaterialPageRoute(builder: (context) => LoginPage());
          case '/scheduling':
            return MaterialPageRoute(builder: (context) => SchedulingPage());
          case '/history':
            // Não passe scheduledAppointments para PatientHistoryPage aqui
            return MaterialPageRoute(
                builder: (context) => PatientHistoryPage());
          case '/profile':
            return MaterialPageRoute(builder: (context) => DoctorProfilePage());
          default:
            return MaterialPageRoute(builder: (context) => LoginPage());
        }
      },
    );
  }
}
