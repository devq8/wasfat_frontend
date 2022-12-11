import 'package:flutter/material.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:wasfat_frontend/models/recipe_model.dart';

class RecipeDetails extends StatelessWidget {
  const RecipeDetails({
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            actions: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: IconButton(
                    onPressed: () => {
                          print('This should redirect to Edit Recipe page!'),
                        },
                    icon: Icon(Icons.more_vert)),
              ),
            ],
            expandedHeight: 300,
            floating: true,
            backgroundColor: Color(0xFFf14b24),
            iconTheme: IconThemeData(color: Colors.white, shadows: [
              Shadow(
                blurRadius: 3,
                offset: Offset(1, 1),
                color: Colors.black38,
              )
            ]),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                recipe.title,
                style: TextStyle(
                  shadows: [
                    Shadow(
                      blurRadius: 3,
                      offset: Offset(1, 1),
                      color: Colors.black38,
                    ),
                  ],
                ),
              ),
              background: Container(
                foregroundDecoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black38,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Image.network(
                  recipe.image.toString(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverPadding(padding: EdgeInsets.symmetric(vertical: 8)),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        padding: EdgeInsets.all(7),
                        child: Text('${recipe.category.title}'),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.star,
                      color: Colors.orange,
                    ),
                    Text('4.5 (231)'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Icon(Icons.favorite, color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 60,
                      child: Text(
                        'Ingredients',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text('Created by Khaled'),
                    ),
                  ],
                ),
                // recipe.ingredients
                //     .map((e) => MultiSelectItem(e, e.title))
                //     .toList(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Wrap(
                    spacing: 6,
                    children: [
                      for (int i = 0; i < 10; i++)
                        Chip(
                          label: Text('Ingredient $i'),
                        )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  height: 60,
                  child: Text(
                    'Directions',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '${recipe.method}',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverPadding(padding: EdgeInsets.symmetric(vertical: 20)),
          // SliverGrid(
          //   delegate: SliverChildBuilderDelegate((context, index) {
          //     return Card(
          //       child: Container(
          //         child: Text('text'),
          //       ),
          //     );
          //   }),
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 3,
          //   ),
          // ),
        ],
      ),
    );
  }
}
