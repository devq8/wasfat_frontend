import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wasfat_frontend/models/category_model.dart';
import 'package:wasfat_frontend/clients.dart';

import 'package:wasfat_frontend/models/recipe_model.dart';
import 'package:wasfat_frontend/pages/category/add_category.dart';
import 'package:wasfat_frontend/pages/ingredient/add_ingredient.dart';
import 'package:wasfat_frontend/pages/ingredient/ingredients.dart';
import 'package:wasfat_frontend/pages/recipe/add_recipe.dart';
import 'package:wasfat_frontend/pages/category/categories.dart';
import 'package:wasfat_frontend/pages/recipe/recipe_details.dart';
import 'package:wasfat_frontend/pages/category/edit_category.dart';
import 'package:wasfat_frontend/pages/recipe/list.dart';
import 'package:wasfat_frontend/pages/auth/signin.dart';
import 'package:wasfat_frontend/pages/auth/signup.dart';
import 'package:wasfat_frontend/pages/splash.dart';
import 'package:wasfat_frontend/providers/category_provider.dart';
import 'package:wasfat_frontend/providers/ingredient_provider.dart';
import 'package:wasfat_frontend/providers/recipe_provider.dart';

import 'providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    Client.dio.options = BaseOptions(baseUrl: "http://10.0.2.2:8000");
  }
  runApp(MyApp());
}

final router = GoRouter(
  initialLocation: '/splash',
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
    GoRoute(
      path: '/add_recipe',
      builder: (context, state) => AddRecipe(),
    ),
    GoRoute(
      path: '/details',
      builder: (context, state) => RecipeDetails(
        recipe: state.extra as Recipe,
      ),
    ),
    GoRoute(
      path: '/categories',
      builder: (context, state) => Categories(),
    ),
    GoRoute(
      path: '/add_category',
      builder: (context, state) => AddCategory(),
    ),
    GoRoute(
      path: '/edit_category',
      builder: (context, state) =>
          EditCategory(category: state.extra as Category),
    ),
    GoRoute(
      path: '/ingredients',
      builder: (context, state) =>
          Ingredients(category: state.extra as Category),
    ),
    GoRoute(
      path: '/add_ingredient',
      builder: (context, state) => AddIngredient(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => RecipeProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => IngredientProvider()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'WasFat',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme:
                GoogleFonts.openSansTextTheme(Theme.of(context).textTheme)),
        routerConfig: router,
      ),
    );
  }
}
