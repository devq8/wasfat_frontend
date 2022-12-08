import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wasfat_frontend/models/ingredient_model.dart';

class IngredientCard extends StatelessWidget {
  const IngredientCard({required this.ingredient});
  final Ingredient ingredient;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Container(
            height: 100,
            width: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: NetworkImage(ingredient.image ?? ''),
              ),
            ),
            // child: Image.network(
            //   ingredient.image ?? '',
            //   height: 50,
            //   width: 50,
            //   fit: BoxFit.fill,
            // ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ingredient.title,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
