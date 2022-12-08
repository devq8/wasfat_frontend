import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wasfat_frontend/models/category_model.dart';
import 'package:wasfat_frontend/providers/recipe_provider.dart';
import '../providers/category_provider.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key});

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  final titleController = TextEditingController();
  final categoryController = TextEditingController();
  final prepController = TextEditingController();
  final cookController = TextEditingController();
  final methodController = TextEditingController();

  final Category cat = Category(id: 1, title: 'title', image: 'image');

  File? imageFile;

  String? imageError;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Add Recipe"),
            backgroundColor: Color(0xFFf14b24),
          ),
          body: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                      hintText: "Enter recipe's title", label: Text('Title')),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Field is required";
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: categoryController,
                  decoration: InputDecoration(
                      hintText: "Enter the category", label: Text('Category')),
                  validator: (value) {
                    // if (value == null || value.isEmpty) {
                    //   return "Field is required";
                    // }

                    return null;
                  },
                ),
                TextFormField(
                  controller: prepController,
                  decoration: InputDecoration(
                      hintText: "prepTime", label: Text('Preparation time')),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Field is required";
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: cookController,
                  decoration: InputDecoration(hintText: "cookTime"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Field is required";
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: methodController,
                  decoration: InputDecoration(hintText: "method"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Field is required";
                    }

                    return null;
                  },
                ),
                Spacer(),
                if (imageFile != null)
                  Image.file(
                    imageFile!,
                    width: 100,
                    height: 100,
                  )
                else
                  Container(
                    width: 100,
                    height: 100,
                  ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFf14b24),
                    ),
                    onPressed: () async {
                      var file = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);

                      if (file == null) {
                        print("User didn't select a file");
                        return;
                      }

                      setState(() {
                        imageFile = File(file.path);
                        imageError = null;
                      });
                    },
                    child: Text("Add Image")),
                if (imageError != null)
                  Text(
                    imageError!,
                    style: TextStyle(color: Colors.red),
                  ),
                Spacer(),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFf14b24),
                    ),
                    onPressed: () async {
                      if (imageFile == null) {
                        setState(() {
                          imageError = "Required field";
                        });
                      }

                      if (formKey.currentState!.validate() &&
                          imageFile != null) {
                        await context.read<RecipeProvider>().addRecipe(
                              category: cat,
                              cookTime: int.parse(cookController.text),
                              method: methodController.text,
                              prepTime: int.parse(prepController.text),
                              title: titleController.text,
                              image: imageFile!,
                            );
                        context.pop();
                      }
                    },
                    child: Text("Add Recipe"))
              ],
            ),
          )),
    );
  }
}
