
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:recipe_ran/Recipe.dart';
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
  Recipe recipe1 = Recipe("", [""], [""], "");


  int _groupValue = 0;
  late String mealType;

  void radioValueChanged(int? value) {
    if(_groupValue == 1) {
      mealType = "Breakfast";
    } else if (_groupValue == 2) {
      mealType = "Lunch";
    } else {
      mealType = "Dinner";
    }
    setState(() {

      _groupValue = value!;
      recipe1.type = mealType;
    });
  }


  @override
  Widget build(BuildContext context) {

    var deviceData = MediaQuery.of(context);
    double unitTitleHeightValue = deviceData.size.height * 0.01;
    double titlemultiplier = 5;
    double title = titlemultiplier * unitTitleHeightValue;
    TextEditingController recipeNameCont = TextEditingController();

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

                                print(recipe1.ingredients);
                               ingredients = await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => IngredientsPage(recipe1.ingredients, recipe1.ingredients.length)
                                  )
                              );
                               recipe1.ingredients = ingredients;
                               print(recipe1.ingredients);
                            },
                            child: const Text("Ingredients"),

                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5),
                          child: ElevatedButton(
                            onPressed: () async {
                              print(recipe1.steps.length);
                              steps = await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => StepsPage(recipe1.steps, recipe1.steps.length)
                                  )
                              );
                              recipe1.steps = steps;
                              print(recipe1.steps);
                            },
                            child: const Text("Recipe Steps"),

                          ),
                        ),
                      ],
                    ),


                    Container(
                      margin: const EdgeInsets.all(5),
                      child: ElevatedButton(
                        onPressed: () {
                          recipe1 = Recipe(recipeNameCont.text, ingredients, steps, recipe1.type);
                          var recipe = {
                            "ingredients": recipe1.ingredients,
                            "recipeName": recipe1.recipeName,
                            "steps": recipe1.steps,
                            "type": recipe1.type,
                          };
                          var rand = Random().nextInt(4294967296);
                          for(int i = 0; i < recipe1.ingredients.length; i++)
                            {
                              FirebaseDatabase.instance.ref().child("Ingredients/ingredient$i")
                                  .set(recipe1.ingredients[i])
                                  .then((value) {
                                    print("Added the ingredient!");
                              }).catchError((error) {
                                print("Failed to add ingredient!");
                                print(error.toString());
                              });
                            }
                          if(recipe1.type == "Breakfast")
                            {
                              FirebaseDatabase.instance.ref().child("Recipes/Breakfast/Recipe$rand")
                              .set(recipe)
                              .then((value) {
                                print("Added the Breakfast recipe!");
                              }).catchError((error) {
                                print("Failed to add the Breakfast recipe!");
                                print(error.toString());
                              });
                            } else if(recipe1.type == "Lunch")
                          {
                            FirebaseDatabase.instance.ref().child("Recipes/Lunch/Recipe$rand")
                            .set(recipe)
                            .then((value) {
                              print("Added the Lunch recipe!");
                            }).catchError((error) {
                              print("Failed to add the Lunch recipe!");
                              print(error.toString());
                            });
                          } else
                            {
                              FirebaseDatabase.instance.ref().child("Recipes/Dinner/Recipe$rand")
                              .set(recipe)
                              .then((value) {
                                print("Added the Dinner recipe!");
                              }).catchError((error) {
                                print("Failed to add the Dinner recipe!");
                                print(error.toString());
                              });
                            }


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
