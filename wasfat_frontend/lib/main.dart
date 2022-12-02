import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wasfat_frontend/pages/list.dart';
import 'package:wasfat_frontend/pages/signin.dart';
import 'package:wasfat_frontend/pages/signup.dart';
import 'package:wasfat_frontend/pages/splash.dart';

import 'providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '/recipes',
      routes: [
        GoRoute(
          path: '/splash',
          builder: (context, state) => Splash(),
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) => SignUp(),
        ),
        GoRoute(
          path: '/signin',
          builder: (context, state) => SignIn(),
        ),
        GoRoute(
          path: '/recipes',
          builder: (context, state) => RecipesList(),
        ),
      ],
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'WasFat',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: router,
      ),
    );
  }
}
