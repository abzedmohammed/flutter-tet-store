import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tet_store/widgets/yellow_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

const textColors = [
  Colors.yellowAccent,
  Colors.red,
  Colors.blueAccent,
  Colors.green,
  Colors.purple,
  Colors.teal,
];

const textStyle = TextStyle(
  fontSize: 45,
  fontFamily: 'Acme',
  fontWeight: FontWeight.bold,
);

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool processing = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/inapp/bgimage.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //rcrossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Text(
              //   'Welcome',
              //   style: TextStyle(fontSize: 30, color: Colors.white),
              // ),
              AnimatedTextKit(
                isRepeatingAnimation: true,
                repeatForever: true,
                animatedTexts: [
                  ColorizeAnimatedText(
                    'WELCOME',
                    textStyle: textStyle,
                    colors: textColors,
                  ),
                  ColorizeAnimatedText(
                    'TET STORE',
                    textStyle: textStyle,
                    colors: textColors,
                  ),
                ],
              ),
              SizedBox(
                height: 120,
                width: 200,
                child: Image(image: AssetImage('images/inapp/logo.jpg')),
              ),
              // Text('Shop', style: TextStyle(fontSize: 30, color: Colors.white)),
              SizedBox(
                height: 80,
                child: DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 45,
                    fontFamily: 'Acme',
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlueAccent,
                  ),
                  child: AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      RotateAnimatedText('Buy'),
                      RotateAnimatedText('Shop'),
                      RotateAnimatedText('Tet Store'),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white38,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            bottomLeft: Radius.circular(50),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            'Suppliers only',
                            style: TextStyle(
                              fontSize: 26,
                              color: Colors.yellowAccent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width * .9,
                        decoration: BoxDecoration(
                          color: Colors.white38,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            bottomLeft: Radius.circular(50),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AnimatedLogo(controller: _controller),
                            YellowButton(
                              width: .25,
                              label: 'Log In',
                              onPressed: () {
                                Navigator.of(
                                  context,
                                ).pushReplacementNamed('/supplier_home');
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: YellowButton(
                                width: .30,
                                label: 'Sign Up',
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: YellowButton(
                            width: .25,
                            label: 'Log In',
                            onPressed: () {
                              Navigator.of(
                                context,
                              ).pushReplacementNamed('/customer_home');
                            },
                          ),
                        ),
                        YellowButton(
                          width: .30,
                          label: 'Sign Up',
                          onPressed: () {
                            Navigator.of(
                              context,
                            ).pushReplacementNamed('/customer_signup');
                          },
                        ),
                        AnimatedLogo(controller: _controller),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(color: Colors.white38),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GooglefacebookLogin(
                      label: 'Google',
                      child: Image(
                        image: AssetImage('images/inapp/google.jpg'),
                      ),
                      onPressed: () {},
                    ),
                    GooglefacebookLogin(
                      label: 'Facebook',
                      child: Image(
                        image: AssetImage('images/inapp/facebook.jpg'),
                      ),
                      onPressed: () {},
                    ),
                    processing
                        ? CircularProgressIndicator()
                        : GooglefacebookLogin(
                          label: 'Guest',
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.lightBlueAccent,
                          ),
                          onPressed: () async {
                            setState(() {
                              processing = true;
                            });
                            FirebaseAuth.instance.signInAnonymously();

                            Navigator.of(
                              context,
                            ).pushReplacementNamed('/customer_home');
                          },
                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedLogo extends StatelessWidget {
  const AnimatedLogo({super.key, required AnimationController controller})
    : _controller = controller;

  final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller.view,
      builder:
          (context, child) =>
              Transform.rotate(angle: _controller.value * 2 * pi, child: child),
      child: Image(image: AssetImage('images/inapp/logo.jpg')),
    );
  }
}

class GooglefacebookLogin extends StatelessWidget {
  const GooglefacebookLogin({
    super.key,
    required this.label,
    required this.onPressed,
    required this.child,
  });

  final String label;
  final Function() onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onPressed,
        child: Column(
          children: [
            SizedBox(height: 50, width: 50, child: child),
            Text(label, style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
