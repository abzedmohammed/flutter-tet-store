import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tet_store/auth/customer_signup.dart';
import 'package:tet_store/screens/customer_home.dart';
import 'package:tet_store/screens/suplier_home.dart';
import 'package:tet_store/screens/welcome.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env"); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: WelcomeScreen(),
      initialRoute: '/welcome_screen',
      routes: {
        '/welcome_screen': (context) => WelcomeScreen(),
        '/customer_home': (context) => CustomerHomeScreen(),
        '/customer_signup': (context) => CustomerSignup(),
        '/supplier_home': (context) => SuplierHomeScreen(),
      },
    );
  }
}