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
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(3),
                    child: Text(
                      '${recipe.category.title}',
                      style: TextStyle(fontSize: 11),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      print('Rate function');
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                        Text('4.5')
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      print('Make favorite function');
                    },
                    child: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              alignment: Alignment.centerLeft,
              child: Text(
                recipe.title,
                style: TextStyle(fontSize: 15),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
