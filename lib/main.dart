import 'package:flutter/material.dart';
import 'package:note_application_mobile_app/pages/screen_manager.dart';
import 'package:note_application_mobile_app/provider/auth_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider()..checkLoginStatus(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ScreenManager());
  }
}
