import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/category_provider.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final titleController = TextEditingController();

  File? imageFile;

  String? imageError;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Add Category"),
            backgroundColor: Color(0xFFf14b24),
          ),
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
                  Container(
                    width: 100,
                    height: 100,
                  ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFf14b24),
                      fixedSize: Size.fromWidth(110),
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
                        fixedSize: Size.fromWidth(200)),
                    onPressed: () async {
                      if (imageFile == null) {
                        setState(() {
                          imageError = "Required field";
                        });
                      }

                      if (formKey.currentState!.validate() &&
                          imageFile != null) {
                        await context.read<CategoryProvider>().addCategory(
                              title: titleController.text,
                              image: imageFile!,
                            );
                        context.pop();
                      }
                    },
                    child: Text("Add Category"))
              ],
            ),
          )),
    );
  }
}
