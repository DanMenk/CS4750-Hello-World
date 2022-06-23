
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
    double unitTitleHeightValue = deviceData.size.height * 0.01;
    double titlemultiplier = 5;
    double title = titlemultiplier * unitTitleHeightValue;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 20,
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Text(
                    "Add a Recipe",
                    style: TextStyle(
                      fontSize: title,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                ),
              ),
            ),

            Expanded(
              flex: 80,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: TextField(
                        controller: recipeNameCont,
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Recipe Name',
                        ),
                      ),

                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Row(
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
                      ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(5),
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
                            child: const Text("Ingredients"),

                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5),
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
                            child: const Text("Recipe Steps"),

                          ),
                        ),
                      ],
                    ),


                    Container(
                      margin: const EdgeInsets.all(5),
                      child: ElevatedButton(
                        onPressed: () async {
                          print(ingredients);

                          var recipe = {
                            "ingredients": ingredients,
                            "recipeName": recipeNameCont.text,
                            "steps": steps,
                          };
                          var rand = Random().nextInt(4294967296);
                          for(int i = 0; i < ingredients.length; i++)
                            {
                              var rand1 = Random().nextInt(4294967296);
                              await FirebaseDatabase.instance.ref().child("Ingredients/ingredient$rand1")
                                  .set(ingredients[i])
                                  .then((value) {
                                    print("Added the ingredient!");
                              }).catchError((error) {
                                print("Failed to add ingredient!");
                                print(error.toString());
                              });
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

                        },
                        child: const Text("Done"),
                      ),
                    )


                  ],
                )
            ),

          ],
        ),
      ),
    );
  }
}
