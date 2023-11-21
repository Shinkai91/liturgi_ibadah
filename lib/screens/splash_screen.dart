import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:liturgi_ibadah/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(builder: (ctx) => const App()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(flex: 2),
          Image(
            image: AssetImage('assets/images/quiz-logo.png'),
            width: 200,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          Spacer(flex: 2),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 40.0),
              child: SpinKitThreeBounce(
                color: Color.fromARGB(255, 158, 158, 158),
                size: 30.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}