import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'scheduling_page.dart';
import 'patient_history_page.dart';
import 'doctor_profile_page.dart';
import 'data/appointment_data.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppointmentData(),
        ),
        ChangeNotifierProvider(
          create: (context) => PatientDescriptionData(),
        ),
      ],
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
            return MaterialPageRoute(
                builder: (context) => PatientHistoryPage()); // Não passe scheduledAppointments para PatientHistoryPage aqui
          case '/profile':
            return MaterialPageRoute(builder: (context) => DoctorProfilePage());
          default:
            return MaterialPageRoute(builder: (context) => LoginPage());
        }
      },
    );
  }
}