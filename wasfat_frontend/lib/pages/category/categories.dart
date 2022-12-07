import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:wasfat_frontend/providers/category_provider.dart';
import 'package:wasfat_frontend/widgets/category_card.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        backgroundColor: Color(0xFFf14b24),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFf14b24),
        child: Icon(Icons.add),
        onPressed: () => context.push('/add_category'),
      ),
      body: context.watch<CategoryProvider>().isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                context.watch<CategoryProvider>().loadCategories();
              },
              child: Padding(
                padding: EdgeInsets.all(7),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1 / 1.4,
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount:
                      context.watch<CategoryProvider>().categories.length,
                  itemBuilder: (context, index) => CategoryCard(
                      category:
                          context.watch<CategoryProvider>().categories[index]),
                ),
              ),
            ),
    );
  }
}
