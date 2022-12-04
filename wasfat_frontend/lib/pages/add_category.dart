import 'package:flutter/material.dart';

class AddCategory extends StatelessWidget {
  const AddCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Category'),
        backgroundColor: Color(0xFFf14b24),
      ),
      body: Center(
        child: Text('Add New Category Page'),
      ),
    );
  }
}
