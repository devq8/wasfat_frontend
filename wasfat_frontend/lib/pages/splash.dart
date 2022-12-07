import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wasfat_frontend/pages/auth/signin.dart';
import 'package:wasfat_frontend/providers/auth_provider.dart';

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
    var authProvider = AuthProvider();

    var isAuth = await authProvider.hasToken();

    await Future.delayed(Duration(milliseconds: 2000), () {});

    final String initialRoute = isAuth ? '/recipes' : '/signup';

    context.go(initialRoute);

    print('Navigate => Home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(
                'assets/images/logo.png',
                height: 250,
                width: 250,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                'WasFat',
                style: GoogleFonts.nerkoOne(
                  textStyle: TextStyle(
                    fontSize: 70,
                    // fontWeight: FontWeight.bold,
                    color: Color(0xFFf14b24),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
