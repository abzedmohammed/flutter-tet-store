import 'package:flutter/material.dart';
import 'package:tet_store/widgets/app_bar_widgets.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(title: 'Stores'),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
    );
  }
}