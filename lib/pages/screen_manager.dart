import 'package:flutter/material.dart';
import 'package:note_application_mobile_app/pages/home_page.dart';

class ScreenManager extends StatefulWidget {
  const ScreenManager({super.key});

  @override
  State<ScreenManager> createState() => _ScreenManagerState();
}

class _ScreenManagerState extends State<ScreenManager> {
  int _selectedIndex = 0;
  final List<Widget> _screenList = [HomePage()];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screenList[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTap,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.add_box_sharp), label: "Add"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites")
        ],
      ),
    );
  }
}
