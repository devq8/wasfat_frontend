import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasfat_frontend/providers/recipe_provider.dart';
import 'package:wasfat_frontend/util.dart';
import 'package:wasfat_frontend/widgets/drawer.dart';
import 'package:wasfat_frontend/widgets/recipe_card.dart';

class RecipesList extends StatefulWidget {
  const RecipesList({super.key});

  @override
  State<RecipesList> createState() => _RecipesListState();
}

class _RecipesListState extends State<RecipesList> {
  String username = '@username';
  String avatar =
      'https://st4.depositphotos.com/4329009/19956/v/600/depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar.jpg';

  Future<Null> getSharedPref() async {
    // avatar = await SharedPrefUtils.readPrefStr('avatar');
    // username = await SharedPrefUtils.readPrefStr('username');
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getSharedPref();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFf14b24),
        title: Text('Recipes List'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFf14b24),
        child: Icon(Icons.add),
        onPressed: () => context.push('/add_recipe'),
      ),
      drawer: DrawerWidget(
        avatar: avatar,
        username: username,
      ),
      body: context.watch<RecipeProvider>().isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                print('Refresh indicator');
                await context.read<RecipeProvider>().loadRecipes();
              },
              child: Column(
                children: [
                  // Container(
                  //   height: 50,
                  //   child: ListView.builder(
                  //       scrollDirection: Axis.horizontal,
                  //       itemCount: 3,
                  //       itemBuilder: (context, index) => Padding(
                  //             padding: const EdgeInsets.all(8.0),
                  //             child: Container(
                  //               height: 50,
                  //               width: 50,
                  //               color: Colors.green,
                  //             ),
                  //           )),
                  // ),
                  // Container(
                  //   height: 50,
                  //   child: SliverList(
                  //     delegate: SliverChildBuilderDelegate((context, index) {
                  //       return Container(
                  //         height: 20,
                  //       );
                  //     }),
                  //   ),
                  // ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1 / 1.6,
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemCount:
                            context.watch<RecipeProvider>().recipes.length,
                        itemBuilder: (context, index) => RecipeCard(
                          recipe:
                              context.watch<RecipeProvider>().recipes[index],
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
