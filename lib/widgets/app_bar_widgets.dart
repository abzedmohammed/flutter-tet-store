
import 'package:flutter/material.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back_ios_new),
      color: Colors.black,
    );
  }
}

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title, textAlign: TextAlign.center, style: TextStyle(
        color: Colors.black,
        fontFamily: 'Acme',
        letterSpacing: 1.5,
        fontSize: 26
      ),),
    );
  }
}
