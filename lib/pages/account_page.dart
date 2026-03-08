import 'package:flutter/material.dart';
import 'package:note_application_mobile_app/pages/account_details_page.dart';
import 'package:note_application_mobile_app/pages/login_page.dart';
import 'package:note_application_mobile_app/pages/register_page.dart';
import 'package:note_application_mobile_app/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool _haveAnAccount = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Account",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: authProvider.isLoggedIn ? AccountDetailsPage() : _haveAnAccount
          ? LoginPage(
              onPressed: (value) {
                setState(() {
                  _haveAnAccount = value;
                });
              },
            )
          : RegisterPage(
              onPressed: (value) {
                setState(() {
                  _haveAnAccount = value;
                });
              },
            ),
    );
  }
}
