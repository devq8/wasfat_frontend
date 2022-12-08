import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wasfat_frontend/models/category_model.dart';
import 'package:wasfat_frontend/providers/category_provider.dart';
import 'package:wasfat_frontend/providers/ingredient_provider.dart';
import 'package:wasfat_frontend/widgets/category_card.dart';
import 'package:wasfat_frontend/widgets/ingredient_card.dart';

class Ingredients extends StatefulWidget {
  final Category category;
  Ingredients({required this.category});

  @override
  State<Ingredients> createState() => _IngredientsState();
}

class _IngredientsState extends State<Ingredients> {
  @override
  void initState() {
    context
        .read<IngredientProvider>()
        .loadIngredients(category_id: widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ingredients of ${widget.category.title}'),
        backgroundColor: Color(0xFFf14b24),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFf14b24),
        child: Icon(Icons.add),
        onPressed: () => context.push('/add_ingredient'),
      ),
      body: context.watch<IngredientProvider>().isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                context
                    .read<IngredientProvider>()
                    .loadIngredients(category_id: widget.category.id);
              },
              child: Padding(
                padding: EdgeInsets.all(7),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1 / 1.2,
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount:
                      context.watch<IngredientProvider>().ingredients.length,
                  itemBuilder: (context, index) => IngredientCard(
                      ingredient: context
                          .watch<IngredientProvider>()
                          .ingredients[index]),
                ),
              ),
            ),
    );
  }
}
