import 'package:flutter/material.dart';
import 'package:pahlawan_indonesia/screens/home.dart';
import 'package:pahlawan_indonesia/screens/splash.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pahlawan Indonesia",
      theme: ThemeData(
        primaryColor: Colors.redAccent,
        primarySwatch: Colors.red,
      ),
      initialRoute: 'splash',
      routes: <String, WidgetBuilder>{
        '/': (context) => const HomeScreen(),
        'splash': (context) => const SplashScreen(),
      },
    );
  }
}
