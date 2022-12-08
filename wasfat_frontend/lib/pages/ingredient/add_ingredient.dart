import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/category_provider.dart';

class AddIngredient extends StatefulWidget {
  const AddIngredient({super.key});

  @override
  State<AddIngredient> createState() => _AddIngredientState();
}

class _AddIngredientState extends State<AddIngredient> {
  final titleController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Add Ingredient"),
            backgroundColor: Color(0xFFf14b24),
          ),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      label: Text('Title'),
                      hintText: "Enter the ingredient title",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field is required";
                      }

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFf14b24),
                        // fixedSize: Size.fromWidth(200),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          // await context.read<CategoryProvider>().addCategory(
                          //       title: titleController.text,
                          //     );
                          context.pop();
                        }
                      },
                      child: Text("Add Ingredient"))
                ],
              ),
            ),
          )),
    );
  }
}
