import 'package:flutter/material.dart';
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
          SliverPadding(padding: EdgeInsets.symmetric(vertical: 15)),
          SliverList(
            delegate: SliverChildListDelegate(
              [
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
                Container(
                  padding: EdgeInsets.all(10),
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    children: [],
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
