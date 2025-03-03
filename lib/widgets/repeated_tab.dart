import 'package:flutter/material.dart';

class RepeatedTab extends StatelessWidget {
  const RepeatedTab({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(label, style: TextStyle(color: Colors.grey.shade600)),
    );
  }
}