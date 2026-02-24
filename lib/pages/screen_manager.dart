import 'package:flutter/material.dart';
import 'package:note_application_mobile_app/pages/account_page.dart';
import 'package:note_application_mobile_app/pages/add_page.dart';
import 'package:note_application_mobile_app/pages/favorite_page.dart';
import 'package:note_application_mobile_app/pages/home_page.dart';

class ScreenManager extends StatefulWidget {
  const ScreenManager({super.key});

  @override
  State<ScreenManager> createState() => _ScreenManagerState();
}

class _ScreenManagerState extends State<ScreenManager> {
  int _selectedIndex = 0;
  final List<Widget> _screenList = [
    HomePage(),
    AddPage(),
    FavoritePage(),
    AccountPage(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (_selectedIndex >= 0 && _selectedIndex < _screenList.length)
          ? _screenList[_selectedIndex]
          : _screenList[0],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTap,
        currentIndex:
            (_selectedIndex >= 0 && _selectedIndex < _screenList.length)
            ? _selectedIndex
            : 0,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_sharp),
            label: "Add",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_rounded),
            label: "Account",
          ),
        ],
      ),
    );
  }
}
