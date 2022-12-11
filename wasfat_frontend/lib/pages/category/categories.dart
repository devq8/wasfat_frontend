import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wasfat_frontend/providers/category_provider.dart';
import 'package:wasfat_frontend/util.dart';
import 'package:wasfat_frontend/widgets/category_card.dart';
import 'package:wasfat_frontend/widgets/drawer.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  String username = '@username';
  String avatar =
      'https://st4.depositphotos.com/4329009/19956/v/600/depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar.jpg';

  Future<Null> getSharedPref() async {
    // avatar = await SharedPrefUtils.readPrefStr('avatar');
    // username = await SharedPrefUtils.readPrefStr('username');
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getSharedPref();
    });
    super.initState();
  }

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
      drawer: DrawerWidget(
        avatar: avatar,
        username: username,
      ),
      body: context.watch<CategoryProvider>().isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                await context.read<CategoryProvider>().loadCategories();
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
