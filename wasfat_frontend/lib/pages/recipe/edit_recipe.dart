import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasfat_frontend/models/category_model.dart';
import 'package:wasfat_frontend/models/ingredient_model.dart';
import 'package:wasfat_frontend/models/recipe_model.dart';
import 'package:wasfat_frontend/providers/category_provider.dart';
import 'package:wasfat_frontend/providers/ingredient_provider.dart';
import 'package:wasfat_frontend/providers/recipe_provider.dart';

class EditRecipe extends StatefulWidget {
  EditRecipe({required this.recipe});
  final Recipe recipe;

  @override
  State<EditRecipe> createState() => _EditRecipeState();
}

class _EditRecipeState extends State<EditRecipe> {
  final titleController = TextEditingController();

  final prepController = TextEditingController();
  final cookController = TextEditingController();
  final methodController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.recipe.title;
    // prepController.text = widget.recipe.prepTime;
    // titleController.text = widget.recipe.title;
    // titleController.text = widget.recipe.title;
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    prepController.dispose();
    cookController.dispose();
    methodController.dispose();

    super.dispose();
  }

  Category? selectedCategory;
  List<Ingredient> selectedIngredients = [];

  File? imageFile;

  String? imageError;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Edit Recipe"),
            backgroundColor: Color(0xFFf14b24),
          ),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
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
                  SizedBox(
                    height: 15,
                  ),
                  DropdownButton<Category>(
                    isExpanded: true,
                    value: selectedCategory,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    onChanged: (Category? value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                    items: context
                        .watch<CategoryProvider>()
                        .categories
                        .map(
                          (e) => DropdownMenuItem<Category>(
                            value: e,
                            child: Text(e.title),
                          ),
                        )
                        .toList(),
                  ),
                  TextFormField(
                    controller: prepController,
                    decoration: InputDecoration(
                      label: Text('Preparation time (in minutes)'),
                      hintText: "How long the preparation time for this recipe",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field is required";
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    controller: cookController,
                    decoration: InputDecoration(
                        label: Text('Cooking time (in minutes)'),
                        hintText: "How long the cooking time for this recipe"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field is required";
                      }

                      return null;
                    },
                  ),
                  Container(
                    height: 150,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: TextFormField(
                        controller: methodController,
                        keyboardType: TextInputType.multiline,
                        minLines: 4,
                        maxLines: 20,
                        decoration: InputDecoration(
                            hintText: "Kindly enter the steps of this recipe",
                            label: Text('Direction')),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Field is required";
                          }

                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  context.watch<IngredientProvider>().isLoading
                      ? Center(child: CircularProgressIndicator())
                      : MultiSelectDialogField<Ingredient>(
                          title: Text('Ingredients'),
                          items: context
                              .watch<IngredientProvider>()
                              .ingredients
                              .map((e) => MultiSelectItem(e, e.title))
                              .toList(),
                          listType: MultiSelectListType.CHIP,
                          onConfirm: (values) {
                            selectedIngredients = values;
                          },
                        ),
                  SizedBox(height: 15),
                  if (imageFile != null)
                    Image.file(
                      imageFile!,
                      width: 300,
                      height: 100,
                    )
                  else
                    Container(
                      width: 300,
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
                        // if (imageFile == null) {
                        //   setState(() {
                        //     imageError = "Required field";
                        //   });
                        // }

                        if (formKey.currentState!.validate() &&
                            // imageFile != null &&
                            selectedCategory != null) {
                          var pref = await SharedPreferences.getInstance();

                          var tokenMap =
                              JwtDecoder.decode(pref.getString('token')!);
                          print(tokenMap['user_id']);
                          print(titleController.text);
                          print(selectedCategory);
                          print(int.parse(prepController.text));
                          print(int.parse(cookController.text));
                          print(methodController.text);
                          print(selectedIngredients);
                          print(imageFile);
                          var errorMessage =
                              await context.read<RecipeProvider>().addRecipe(
                                    profile: tokenMap['user_id'],
                                    category: selectedCategory!,
                                    cookTime: int.parse(cookController.text),
                                    method: methodController.text,
                                    prepTime: int.parse(prepController.text),
                                    title: titleController.text,
                                    ingredients: selectedIngredients,
                                    image: imageFile!,
                                  );
                          if (errorMessage == null) {
                            context.pop();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(errorMessage)));
                          }
                        }
                      },
                      child: Text("Add Recipe"))
                ],
              ),
            ),
          )),
    );
  }
}
