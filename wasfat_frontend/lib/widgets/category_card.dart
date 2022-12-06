import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wasfat_frontend/models/category_model.dart';
import 'package:wasfat_frontend/pages/edit_category.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({required this.category});
  final Category category;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          context.push("/edit_category", extra: category);
        },
        child: Column(
          children: [
            Image.network(
              category.image,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    category.title,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
