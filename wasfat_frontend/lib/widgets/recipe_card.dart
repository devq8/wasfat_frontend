import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wasfat_frontend/models/recipe_model.dart';

class RecipeCard extends StatelessWidget {
  RecipeCard({required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          context.push('/details', extra: recipe);
        },
        child: Column(
          children: [
            Image.network(
              recipe.image.toString(),
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    recipe.title,
                    style: TextStyle(fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                  ),
                  InkWell(
                    onTap: () {
                      print('Make favorite function');
                    },
                    child: Icon(Icons.favorite_outline),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
