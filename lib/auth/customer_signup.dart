// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tet_store/utilities/notification_handler.dart';
import 'package:tet_store/utilities/utils.dart';
import 'package:tet_store/widgets/auth_widgets.dart';
import 'package:http/http.dart' as http;

String apiUrl = dotenv.env['API_URL'] ?? '';

class CustomerSignup extends StatefulWidget {
  const CustomerSignup({super.key});

  @override
  State<CustomerSignup> createState() => _CustomerSignupState();
}

class _CustomerSignupState extends State<CustomerSignup> {
  bool passwordVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  late String _email, _password, _name, _profileImage, _uid;
  XFile? _imageFile;

  final ImagePicker _imagePicker = ImagePicker();
  CollectionReference customer = FirebaseFirestore.instance.collection(
    'customers',
  );
  final url = Uri.parse('$apiUrl/api/user/create');

  void _pickImageFromCamera() async {
    try {
      final pickedImage = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 95,
      );

      setState(() {
        _imageFile = pickedImage;
      });
    } catch (e) {
      MyMessageHandler.showSnackBar(_scaffoldKey, e.toString());
    }
  }

  void _pickImageFromgallery() async {
    try {
      final pickedImage = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 95,
      );

      setState(() {
        _imageFile = pickedImage;
      });
    } catch (e) {
      MyMessageHandler.showSnackBar(_scaffoldKey, e.toString());
    }
  }

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      if (_imageFile != null) {
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _email,
            password: _password,
          );

          final response = await http.post(
            url,
            headers: {
              "Content-Type": "application/json", // ✅ Specify JSON content type
              "Accept": "application/json",
            },
            body: jsonEncode({
              'usrNames': _name,
              'usrEmail': _email,
              'usrAvatar': _imageFile!.path.toString(),
              'usrPhone': '',
              'usrAddress': '',
              'usrCid': FirebaseAuth.instance.currentUser!.uid,
            }),
          );

          final responseBody = json.decode(response.body);

          if (!mounted) return;

          if (responseBody['success'] == true) {
            _formKey.currentState!.reset();
            setState(() {
              _imageFile = null;
            });
            Navigator.of(context).pushReplacementNamed('/customer_home');
          } else {
            MyMessageHandler.showSnackBar(
              _scaffoldKey,
              responseBody['messages']['message'],
            );
            FirebaseAuth.instance.currentUser!.delete();
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'email-already-in-use') {
            MyMessageHandler.showSnackBar(
              _scaffoldKey,
              'The email address is already in use by another account.',
            );
          } else if (e.code == 'weak-password') {
            MyMessageHandler.showSnackBar(
              _scaffoldKey,
              'Password should be atleast 6 characters',
            );
          } else {
            MyMessageHandler.showSnackBar(
              _scaffoldKey,
              'An error has occured please try again later',
            );
          }
        }
      } else {
        MyMessageHandler.showSnackBar(_scaffoldKey, 'Please select an image');
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
                    children: [
                      AuthHeaderLabel(headerLabel: 'Sign Up'),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 40,
                            ),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.purpleAccent,
                              backgroundImage:
                                  _imageFile == null
                                      ? null
                                      : FileImage(File(_imageFile!.path)),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: _pickImageFromCamera,
                                  icon: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(height: 6),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: _pickImageFromgallery,
                                  icon: Icon(Icons.photo, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          // controller: _nameController,
                          onChanged: (value) => _name = value,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your full name';
                            }
                            return null;
                          },
                          decoration: textFormDecoration.copyWith(
                            labelText: 'Full Name',
                            prefixIcon: Icon(Icons.person),
                            hintText: 'Enter your full name',
                          ),
                        ),
                      ),

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
                      HaveAccount(
                        haveAccount: 'Already have an account?',
                        actionLabel: 'Sign In',
                        onPressed: () {},
                      ),
                      AuthMainButton(
                        mainButtonLabel: 'Sign Up',
                        onPressed: () {
                          _signUp();
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
