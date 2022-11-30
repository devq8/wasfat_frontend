import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wasfat_frontend/pages/list.dart';
import 'package:wasfat_frontend/pages/signin.dart';

void main() {
  runApp(const MyApp());
}

final router = GoRouter(initialLocation: '/signin', routes: [
  GoRoute(
    path: '/recipes',
    builder: (context, state) => RecipesList(),
  ),
  GoRoute(
    path: '/signin',
    builder: (context, state) => SignIn(),
  ),
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'WasFat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: router,
    );
  }
}
