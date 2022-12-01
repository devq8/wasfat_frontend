import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wasfat_frontend/pages/list.dart';
import 'package:wasfat_frontend/pages/signin.dart';
import 'package:wasfat_frontend/pages/splash.dart';

void main() {
  runApp(const MyApp());
}

final router = GoRouter(initialLocation: '/splash', routes: [
  GoRoute(
    path: '/recipes',
    builder: (context, state) => RecipesList(),
  ),
  GoRoute(
    path: '/signin',
    builder: (context, state) => SignIn(),
  ),
  GoRoute(
    path: '/splash',
    builder: (context, state) => Splash(),
  ),
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'WasFat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: router,
    );
  }
}
