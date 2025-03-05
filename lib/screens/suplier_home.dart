import 'package:flutter/material.dart';
import 'package:tet_store/screens/category.dart';
import 'package:tet_store/screens/dashboard.dart';
import 'package:tet_store/screens/home.dart';
import 'package:tet_store/screens/store.dart';
import 'package:tet_store/screens/upload_product.dart';

class SuplierHomeScreen extends StatefulWidget {
  const SuplierHomeScreen({super.key});

  @override
  State<SuplierHomeScreen> createState() => _SuplierHomeScreenState();
}

class _SuplierHomeScreenState extends State<SuplierHomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _tabs = [
    HomeScreen(),
    CategoryScreen(),
    StoreScreen(),
    DashboardScreen(),
    UploadProductScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Category'),
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Stores'),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dasboard',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.upload), label: 'Upload'),
        ],
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}
