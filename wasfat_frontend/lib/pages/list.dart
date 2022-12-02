import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipesList extends StatelessWidget {
  const RecipesList({super.key});

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
                bottom: 18,
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
      body: Padding(
        padding: const EdgeInsets.all(7.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                print('Go to Recipe Details No. $index');
              },
              child: Container(
                padding: EdgeInsets.zero,
                color: Colors.amber,
                child: GridTile(
                  footer: Container(
                    height: 40,
                    child: GridTileBar(
                      title: Text(
                        'Machboos',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: Colors.black12,
                    ),
                  ),
                  child: Text('test'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
