import 'package:flutter/material.dart';
import 'package:note_application_mobile_app/pages/login_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Account",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: LoginPage(),
    );
  }
}
