import 'package:flutter/material.dart';
import 'package:project_education/view/home.dart';
import 'dart:async';

import 'package:project_education/main.dart';
import 'package:project_education/view/login.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _goHome();
    super.initState();

  }

  _goHome() async {
    await Future.delayed(const Duration(milliseconds: 5000),() {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
  }

  // void navigateToHome() {
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (context) => Home()),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(255, 255, 255, 1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/edukasi.jpg',
                width: 250,
                height: 250,
              ),
              SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
