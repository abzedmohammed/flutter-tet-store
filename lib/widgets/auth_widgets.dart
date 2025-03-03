
import 'package:flutter/material.dart';

class AuthMainButton extends StatelessWidget {
  const AuthMainButton({
    super.key,
    required this.mainButtonLabel,
    required this.onPressed,
  });

  final String mainButtonLabel;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Material(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(25),
        child: MaterialButton(
          minWidth: double.infinity,
          onPressed: onPressed,
          child: Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class HaveAccount extends StatelessWidget {
  const HaveAccount({
    super.key,
    required this.haveAccount,
    required this.actionLabel,
    required this.onPressed,
  });

  final String haveAccount;
  final String actionLabel;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          haveAccount,
          style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            actionLabel,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
        ),
      ],
    );
  }
}

class AuthHeaderLabel extends StatelessWidget {
  const AuthHeaderLabel({super.key, required this.headerLabel});

  final String headerLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            headerLabel,
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/weclome_screen');
            },
            icon: Icon(Icons.home_work, size: 40),
          ),
        ],
      ),
    );
  }
}

var textFormDecoration = InputDecoration(
  labelText: 'Full Name',
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: BorderSide(color: Colors.purple, width: 1),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: BorderSide(color: Colors.deepPurple, width: 2),
  ),
  prefixIcon: Icon(Icons.person),
  hintText: 'Enter your full name',
);
