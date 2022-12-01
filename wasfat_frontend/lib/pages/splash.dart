import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wasfat_frontend/pages/signin.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    print('App is started ...');
    await Future.delayed(Duration(milliseconds: 2000), () {});

    context.go('/signin');

    print('Navigate => Home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(
                'assets/images/logo.png',
                height: 100,
                width: 100,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                'WasFat',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
