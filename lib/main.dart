import 'package:flutter/material.dart';
import 'package:note_application_mobile_app/pages/screen_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ScreenManager(),);
  }
}