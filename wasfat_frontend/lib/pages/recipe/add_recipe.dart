import 'package:flutter/material.dart';

class AddRecipe extends StatelessWidget {
  const AddRecipe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Recipe'),
        backgroundColor: Color(0xFFf14b24),
      ),
      body: Center(
        child: Text('Add New Recipe Page'),
      ),
    );
  }
}
