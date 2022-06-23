
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:recipe_ran/ingredients.dart';
import 'package:recipe_ran/steps.dart';

class AddARecipePage extends StatefulWidget {
  const AddARecipePage({Key? key}) : super(key: key);

  @override
  State<AddARecipePage> createState() => _AddARecipePageState();
}

class _AddARecipePageState extends State<AddARecipePage> {

  var ingredients = [];
  var ingredientName = [];
  var type = [];
  var steps = [];
  TextEditingController recipeNameCont = TextEditingController();

  late int childrenCount;
  int _groupValue = 0;

  void getDatabaseRecipeAmount() {
    if(_groupValue == 1)
      {
        FirebaseDatabase.instance.ref().child("Recipes/Breakfast").onChildChanged.listen((event) {
          childrenCount = event.snapshot.children.length;
          print("Breakfast! $childrenCount");
        });
      }
    else if(_groupValue == 2)
      {
        FirebaseDatabase.instance.ref().child("Recipes/Breakfast").onChildChanged.listen((event) {
          childrenCount = event.snapshot.children.length;
          print("Lunch! $childrenCount");
        });
      }
    else
      {
        FirebaseDatabase.instance.ref().child("Recipes/Dinner").onChildChanged.listen((event) {
          childrenCount = event.snapshot.children.length;
          print("Dinner! $childrenCount");
        });
      }

  }

  void radioValueChanged(int? value) {

    setState(() {
      _groupValue = value!;
      print(_groupValue);
    });
  }

  @override
  Widget build(BuildContext context) {

    var deviceData = MediaQuery.of(context);
    const double buttonWidthMod = 0.4;
    double buttonWidth = buttonWidthMod*deviceData.size.width;

    double unitTextHeightValue = deviceData.size.height * 0.01;
    double buttonMultiplier = 2;
    double button = buttonMultiplier * unitTextHeightValue;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Add a Recipe",),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: TextField(
                controller: recipeNameCont,
                obscureText: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Recipe Name',
                ),
              ),

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                    value: 1,
                    groupValue: _groupValue,
                    onChanged: radioValueChanged
                ),
                const Text("Breakfast"),
                Radio(
                    value: 2,
                    groupValue: _groupValue,
                    onChanged: radioValueChanged),
                const Text("Lunch"),
                Radio(
                    value: 3,
                    groupValue: _groupValue,
                    onChanged: radioValueChanged),
                const Text("Dinner"),
              ],
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: buttonWidth,
                  margin: const EdgeInsets.only(right: 5),
                  child: ElevatedButton(
                    onPressed: () async {

                        print("Input: $ingredients");
                       ingredients = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => IngredientsPage(ingredients, ingredients.length)
                          )
                      );

                       print("Output 2: $ingredients");
                    },
                    child: Text(
                      "Ingredients",
                      style: TextStyle(
                          fontSize: button,
                      ),
                    ),

                  ),
                ),
                Container(
                  width: buttonWidth,
                  margin: const EdgeInsets.only(right: 5),
                  child: ElevatedButton(
                    onPressed: () async {
                      print(steps.length);
                      steps = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => StepsPage(steps, steps.length)
                          )
                      );

                      print(steps);
                    },
                    child: Text(
                      "Recipe Steps",
                      style: TextStyle(fontSize: button),
                    ),

                  ),
                ),
              ],
            ),

            Container(
              width: buttonWidth,
              child: ElevatedButton(
                onPressed: () async {
                  if(recipeNameCont.text.isNotEmpty && ingredientName.isNotEmpty && type.isNotEmpty && steps.isNotEmpty && _groupValue != 0)
                    {
                      print(ingredients);
                      for(int i = 0; i < ingredients.length; i++)
                      {
                        ingredientName.add(ingredients[i].ingredientName);
                        type.add(ingredients[i].type);
                      }
                      var recipe = {
                        "ingredients": ingredientName,
                        "recipeName": recipeNameCont.text,
                        "steps": steps,
                        "type": type,
                      };
                      var rand = Random().nextInt(4294967296);
                      for(int i = 0; i < ingredients.length; i++)
                      {
                        var rand1 = Random().nextInt(4294967296);
                        if(type[i] == 1)
                        {
                          await FirebaseDatabase.instance.ref().child("Ingredients/Dairy/ingredient$rand1")
                              .set(ingredientName[i])
                              .then((value) {
                            print("Added the ingredient!");
                          }).catchError((error) {
                            print("Failed to add ingredient!");
                            print(error.toString());
                          });
                        } else if(type[i] == 2)
                        {
                          await FirebaseDatabase.instance.ref().child("Ingredients/Fruit/ingredient$rand1")
                              .set(ingredientName[i])
                              .then((value) {
                            print("Added the ingredient!");
                          }).catchError((error) {
                            print("Failed to add ingredient!");
                            print(error.toString());
                          });
                        } else if(type[i] == 3)
                        {
                          await FirebaseDatabase.instance.ref().child("Ingredients/Grain/ingredient$rand1")
                              .set(ingredientName[i])
                              .then((value) {
                            print("Added the ingredient!");
                          }).catchError((error) {
                            print("Failed to add ingredient!");
                            print(error.toString());
                          });
                        } else if(type[i] == 4)
                        {
                          await FirebaseDatabase.instance.ref().child("Ingredients/Protein/ingredient$rand1")
                              .set(ingredientName[i])
                              .then((value) {
                            print("Added the ingredient!");
                          }).catchError((error) {
                            print("Failed to add ingredient!");
                            print(error.toString());
                          });
                        } else
                        {
                          await FirebaseDatabase.instance.ref().child("Ingredients/Vegetable/ingredient$rand1")
                              .set(ingredientName[i])
                              .then((value) {
                            print("Added the ingredient!");
                          }).catchError((error) {
                            print("Failed to add ingredient!");
                            print(error.toString());
                          });
                        }

                      }
                      print("Done adding ingredients!");
                      if(_groupValue == 1)
                      {
                        await FirebaseDatabase.instance.ref().child("Recipes/Breakfast/Recipe$rand")
                            .set(recipe)
                            .then((value) {
                          print("Added the Breakfast recipe!");
                        }).catchError((error) {
                          print("Failed to add the Breakfast recipe!");
                          print(error.toString());
                        });
                      } else if(_groupValue == 2)
                      {
                        await FirebaseDatabase.instance.ref().child("Recipes/Lunch/Recipe$rand")
                            .set(recipe)
                            .then((value) {
                          print("Added the Lunch recipe!");
                        }).catchError((error) {
                          print("Failed to add the Lunch recipe!");
                          print(error.toString());
                        });
                      } else
                      {
                        await FirebaseDatabase.instance.ref().child("Recipes/Dinner/Recipe$rand")
                            .set(recipe)
                            .then((value) {
                          print("Added the Dinner recipe!");
                        }).catchError((error) {
                          print("Failed to add the Dinner recipe!");
                          print(error.toString());
                        });
                      }
                      Navigator.pop(context);

                    }
                  else
                    {
                      print("Recipe Incomplete!");
                      Navigator.pop(context);
                    }

                },
                child: Text(
                  "Done",
                  style: TextStyle(fontSize: button),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
