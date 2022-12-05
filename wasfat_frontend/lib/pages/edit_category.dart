import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wasfat_frontend/providers/category_provider.dart';

import '../models/category_model.dart';

class EditCategory extends StatefulWidget {
  final Category category;
  EditCategory({required this.category, super.key});

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  File? imageFile;
  String? imageError;

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.category.title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Edit Category")),
        body: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(hintText: "Title"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field is required";
                  }

                  return null;
                },
              ),
              if (imageFile != null)
                Image.file(
                  imageFile!,
                  width: 100,
                  height: 100,
                )
              else
                Image.network(
                  widget.category.image,
                  width: 100,
                  height: 100,
                ),
              ElevatedButton(
                  onPressed: () async {
                    var file = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);

                    if (file == null) {
                      print("Use didnt select a file");
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
                  onPressed: () async {
                    if (imageFile == null) {
                      setState(() {
                        imageError = "Required field";
                      });
                    }

                    if (formKey.currentState!.validate() && imageFile != null) {
                      await context.read<CategoryProvider>().editCategory(
                            id: widget.category.id,
                            title: titleController.text,
                            image: imageFile!,
                          );
                      context.pop();
                    }
                  },
                  child: Text("Save"))
            ],
          ),
        ));
  }
}
