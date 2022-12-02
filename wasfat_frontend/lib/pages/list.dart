import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasfat_frontend/providers/recipe_provider.dart';
import 'package:wasfat_frontend/widgets/recipe_card.dart';

class RecipesList extends StatefulWidget {
  const RecipesList({super.key});

  @override
  State<RecipesList> createState() => _RecipesListState();
}

class _RecipesListState extends State<RecipesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFf14b24),
        title: Text('Recipes List'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFFf9971c)),
              padding: EdgeInsets.only(
                bottom: 15,
                top: 15,
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/images/avatar.jpeg',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('First Name & Last Name',
                      style: TextStyle(
                        fontSize: 15,
                      )),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home_outlined),
              title: Text('Home'),
              onTap: () {
                print('Go Home');
              },
            ),
            ListTile(
              leading: Icon(Icons.food_bank_outlined),
              title: Text('Categories'),
              onTap: () {
                print('Go to Categories');
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite_outline),
              title: Text('Favorite'),
              onTap: () {
                print('Go Favorite');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app_outlined),
              title: Text('Sign out'),
              onTap: () async {
                var pref = await SharedPreferences.getInstance();
                await pref.setString('token', '');
                context.go('/signin');
              },
            ),
          ],
        ),
      ),
      body: context.watch<RecipeProvider>().isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                print('Refresh indicator');
                context.watch<RecipeProvider>().loadRecipes();
              },
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1 / 1.6,
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: context.watch<RecipeProvider>().recipes.length,
                  itemBuilder: (context, index) => RecipeCard(
                    recipe: context.watch<RecipeProvider>().recipes[index],
                  ),
                ),
              ),
            ),
    );
  }
}
