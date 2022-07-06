
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

    double unitTitleHeightValue = deviceData.size.height * 0.01;
    double titlemultiplier = 5;
    double title = titlemultiplier * unitTitleHeightValue;

    double unitTextHeightValue = deviceData.size.height * 0.01;
    double buttonMultiplier = 2;
    double button = buttonMultiplier * unitTextHeightValue;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Add a Recipe",
          style: TextStyle(fontSize: title),),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: buttonWidth*2,
              margin: const EdgeInsets.all(20),
              child: TextField(
                style: TextStyle(fontSize: buttonWidth/4),
                controller: recipeNameCont,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Recipe Name',
                  labelStyle: TextStyle(fontSize: button*2)
                ),
              ),

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                    value: 1,
                    groupValue: _groupValue,
                    onChanged: radioValueChanged,

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
                  var tmpIngredients = [];
                  var tmpType = [];
                  for(int i = 0; i < ingredients.length; i++)
                  {
                    ingredientName.add(ingredients[i].ingredientName.toLowerCase());
                    type.add(ingredients[i].type);
                  }

                  if(recipeNameCont.text.isNotEmpty && ingredientName.isNotEmpty && type.isNotEmpty && steps.isNotEmpty && _groupValue != 0 && ingredientName.length == type.length)
                    {
                      print("Ingredients: $ingredientName");
                      print("Recipe Name: ${recipeNameCont.text}");

                      var rand = Random().nextInt(4294967296);
                      bool removed = false;
                      int ingredientLength = ingredientName.length;
                      for(int i = 0; i < ingredientLength; i++)
                      {
                        if(ingredientName.isEmpty)
                          {
                            break;
                          }
                        if(ingredientName.isNotEmpty && removed)
                          {
                            i = 0;
                            removed = false;
                          }
                        print(ingredientName[i]);
                        if(type[i] == 1)
                        {
                          await FirebaseDatabase.instance.ref().child("Ingredients/Dairy")
                              .get().then((value) {
                                print("hi 1");
                                Map<dynamic, dynamic>? val = value.value as Map?;
                                val?.forEach((key, value) {

                                  if(ingredientName[i] == value)
                                    {
                                      ingredientName.remove(value);
                                      type.remove(1);
                                      removed = true;
                                      print("Ingredients: $ingredientName");
                                      print("Removing duplicate ingredient from list of ingredients to add to database.");
                                    }
                                });
                          }).catchError((error) {
                            print("Check for duplicate ingredients failed");
                            print(error.toString());

                          });

                        } else if(type[i] == 2)
                        {
                          await FirebaseDatabase.instance.ref().child("Ingredients/Fruit")
                              .get().then((value) {
                            print("hi 2");
                            Map<dynamic, dynamic>? val = value.value as Map?;
                            val?.forEach((key, value) {

                              if(ingredientName[i] == value)
                              {
                                ingredientName.remove(value);
                                type.remove(2);
                                removed = true;
                                print("Ingredients: $ingredientName");
                                print("Removing duplicate ingredient from list of ingredients to add to database.");
                              }
                            });
                          }).catchError((error) {
                            print("Check for duplicate ingredients failed");
                            print(error.toString());

                          });

                        } else if(type[i] == 3)
                        {
                          await FirebaseDatabase.instance.ref().child("Ingredients/Grain")
                              .get().then((value) {
                            print("hi 3");
                            Map<dynamic, dynamic>? val = value.value as Map?;
                            val?.forEach((key, value) {

                              if(ingredientName[i] == value)
                              {
                                ingredientName.remove(value);
                                type.remove(3);
                                removed = true;
                                print("Ingredients: $ingredientName");
                                print("Removing duplicate ingredient from list of ingredients to add to database.");
                              }
                            });
                          }).catchError((error) {
                            print("Check for duplicate ingredients failed");
                            print(error.toString());

                          });

                        } else if(type[i] == 4)
                        {
                          await FirebaseDatabase.instance.ref().child("Ingredients/Protein")
                              .get().then((value) {
                            print("hi 4");
                            Map<dynamic, dynamic>? val = value.value as Map?;
                            val?.forEach((key, value) {

                              if(ingredientName[i] == value)
                              {
                                ingredientName.remove(value);
                                type.remove(4);
                                removed = true;
                                print("Ingredients: $ingredientName");
                                print("Removing duplicate ingredient from list of ingredients to add to database.");
                              }
                            });
                          }).catchError((error) {
                            print("Check for duplicate ingredients failed");
                            print(error.toString());

                          });

                        } else if (type[i] == 5)
                        {
                          await FirebaseDatabase.instance.ref().child("Ingredients/Vegetable")
                              .get().then((value) {
                            print("hi 5");
                            Map<dynamic, dynamic>? val = value.value as Map?;
                            val?.forEach((key, value) {

                              if(ingredientName[i] == value)
                              {
                                ingredientName.remove(value);
                                type.remove(5);
                                removed = true;
                                print("Ingredients: $ingredientName");
                                print("Removing duplicate ingredient from list of ingredients to add to database.");
                              }
                            });
                          }).catchError((error) {
                            print("Check for duplicate ingredients failed");
                            print(error.toString());

                          });

                        } else
                          {
                            print("milk?");
                            await FirebaseDatabase.instance.ref().child("Ingredients/Other")
                                .get().then((value) {
                              print("hi 6");
                              Map<dynamic, dynamic>? val = value.value as Map?;
                              val?.forEach((key, value) {

                                if(ingredientName[i] == value)
                                {
                                  ingredientName.remove(value);
                                  type.remove(6);
                                  removed = true;
                                  print("Ingredients: $ingredientName");
                                  print("Removing duplicate ingredient from list of ingredients to add to database.");
                                }
                              });
                            }).catchError((error) {
                              print("Check for duplicate ingredients failed");
                              print(error.toString());

                            });

                          }

                      }

                      for(int i = 0; i < ingredientName.length; i++)
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
                            }
                          else if(type[i] == 2)
                            {
                              await FirebaseDatabase.instance.ref().child("Ingredients/Fruit/ingredient$rand1")
                                  .set(ingredientName[i])
                                  .then((value) {
                                print("Added the ingredient!");
                              }).catchError((error) {
                                print("Failed to add ingredient!");
                                print(error.toString());
                              });
                            }
                          else if(type[i] == 3)
                            {
                              await FirebaseDatabase.instance.ref().child("Ingredients/Grain/ingredient$rand1")
                                  .set(ingredientName[i])
                                  .then((value) {
                                print("Added the ingredient!");
                              }).catchError((error) {
                                print("Failed to add ingredient!");
                                print(error.toString());
                              });
                            }
                          else if(type[i] == 4)
                            {
                              await FirebaseDatabase.instance.ref().child("Ingredients/Protein/ingredient$rand1")
                                  .set(ingredientName[i])
                                  .then((value) {
                                print("Added the ingredient!");
                              }).catchError((error) {
                                print("Failed to add ingredient!");
                                print(error.toString());
                              });
                            }
                          else if (type[i] == 5)
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
                          else
                            {
                              await FirebaseDatabase.instance.ref().child("Ingredients/Other/ingredient$rand1")
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

                      for(int i = 0; i < ingredients.length; i++)
                      {
                        tmpIngredients.add(ingredients[i].ingredientName.toLowerCase());
                        tmpType.add(ingredients[i].type);
                      }
                      var recipe = {
                        "ingredients": tmpIngredients,
                        "recipeName": recipeNameCont.text,
                        "steps": steps,
                        "type": tmpType,
                      };
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
                      print(recipeNameCont.text);
                      print(ingredientName);
                      print(type);
                      print(steps);
                      print(_groupValue);
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
