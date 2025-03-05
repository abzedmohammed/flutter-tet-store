// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tet_store/utilities/notification_handler.dart';
import 'package:tet_store/utilities/utils.dart';
import 'package:tet_store/widgets/auth_widgets.dart';

String apiUrl = dotenv.env['API_URL'] ?? '';

class CustomerLogin extends StatefulWidget {
  const CustomerLogin({super.key});

  @override
  State<CustomerLogin> createState() => _CustomerLoginState();
}

class _CustomerLoginState extends State<CustomerLogin> {
  bool passwordVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  late String _email, _password;

  bool isProcessing = false;

  final url = '$apiUrl/api/user/create';

  void _signIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          isProcessing = true;
        });

        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        if (!mounted) return;

        _formKey.currentState!.reset();

        Navigator.of(context).pushReplacementNamed('/customer_home');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          MyMessageHandler.showSnackBar(
            _scaffoldKey,
            'Invalid credentials',
          );
          setState(() {
            isProcessing = false;
          });
        } else {
          MyMessageHandler.showSnackBar(
            _scaffoldKey,
            'An error has occured please try again later',
          );
          setState(() {
            isProcessing = false;
          });
        }
      }
    } else {
      MyMessageHandler.showSnackBar(_scaffoldKey, 'Please fill all fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AuthHeaderLabel(headerLabel: 'Log In'),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          // controller: _emailController,
                          onChanged: (value) => _email = value,

                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            } else if (!value.isValidEmail()) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: textFormDecoration.copyWith(
                            labelText: 'Email Address',
                            prefixIcon: Icon(Icons.email),
                            hintText: 'Enter your email',
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          // controller: _passwordController,
                          onChanged: (value) => _password = value,

                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          obscureText: !passwordVisible,
                          decoration: textFormDecoration.copyWith(
                            labelText: 'Password',
                            prefixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                              icon: Icon(
                                !passwordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            hintText: 'Enter your password',
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      HaveAccount(
                        haveAccount: 'Don\'t have an account?',
                        actionLabel: 'Sign Up',
                        onPressed: () {
                          Navigator.of(
                            context,
                          ).pushReplacementNamed('/customer_signup');
                        },
                      ),

                      isProcessing
                          ? Center(child: CircularProgressIndicator())
                          : AuthMainButton(
                            mainButtonLabel: 'Log In',
                            onPressed: () {
                              _signIn();
                            },
                          ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
