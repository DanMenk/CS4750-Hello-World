import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:recipe_ran/recommendations.dart';

class ChooseIngredientsPage extends StatefulWidget {
  const ChooseIngredientsPage(this.meal, this.ingredients, this.values, {Key? key}) : super(key: key);
  final List<dynamic> ingredients;
  final List<dynamic> values;
  final String meal;

  @override
  State<ChooseIngredientsPage> createState() => _ChooseIngredientsPageState();
}

class _ChooseIngredientsPageState extends State<ChooseIngredientsPage> {



  late String meal;
  late var ingredients = [];
  late var chosenIngredients = [];
  late var values = [];

  @override
  void initState() {


    meal = widget.meal;
    ingredients = widget.ingredients;
    values = widget.values;
    for(int i = 0; i < ingredients.length; i++)
    {
      values.add(false);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    const double buttonWidthMod = 1;
    var deviceData = MediaQuery.of(context);
    double buttonWidth = buttonWidthMod*deviceData.size.width;

    double unitTitleHeightValue = deviceData.size.height * 0.01;
    double titlemultiplier = 5;
    double title = titlemultiplier * unitTitleHeightValue;

    double unitTextHeightValue = deviceData.size.height * 0.01;
    double buttonMultiplier = 2;
    double buttonHeight = buttonMultiplier * unitTextHeightValue;

    return Scaffold(
              body: Center(
                child: Column(
                  children: [

                    Expanded(
                      flex: 20,
                      child: Container(
                        margin: const EdgeInsets.all(5),
                          child: Center(
                            child: Text(
                                "Choose Your Ingredients",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: title,
                                  color: Colors.blue,
                              ),),
                          )
                      ),
                    ),
                    Expanded(
                      flex: 70,
                      child: ListView.builder(
                        itemCount: ingredients.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.all(5),
                            child:
                                CheckboxListTile(

                                title: Text(ingredients[index]),
                                onChanged: (bool? value) {

                                  if(values[index] == false)
                                    {
                                      chosenIngredients.add(ingredients[index]);
                                      values[index] = value;
                                      setState((){

                                      });
                                    }
                                  else {
                                    chosenIngredients.remove(ingredients[index]);
                                    values[index] = value;
                                    setState((){

                                    });
                                  }

                                },
                                value: values[index],

                              ),

                          );
                        },

                      ),
                    ),
                    Expanded(
                      flex: 10,
                        child: Container(
                          width: buttonWidth,
                          margin: const EdgeInsets.all(5),
                          child: ElevatedButton(
                            onPressed: () {
                              late var recipes = [];
                             FirebaseDatabase.instance.ref().child("Recipes/$meal").get()
                                 .then((value) {
                                   print(chosenIngredients);
                                   print("$meal recipes retrieved!");

                                   Map? recipe = value.value as Map?;
                                   recipe?.forEach((key, value) {
                                     recipes.add(value); //gets recipe itself


                                   });

                                   print("Recipes: $recipes");
                                   var recommended = [];
                                   var highlyRecommended = [];
                                   var match = [];
                                   print("Amount of Recipes: ${recipes.length}");

                                   for(int recipe = 0; recipe < recipes.length; recipe++)
                                     {
                                       double similarity = 0;
                                       int totalIngredients = recipes[recipe]['ingredients'].length;
                                       print("Amount of Ingredients for Recipe $recipe: $totalIngredients");

                                       for(int items = 0; items < totalIngredients; items++)
                                         {
                                           for(int item = 0; item < totalIngredients; item++)
                                           {
                                              if(item < chosenIngredients.length && chosenIngredients[item] == recipes[recipe]['ingredients'][items] )
                                                {
                                                  similarity++;
                                                }

                                           }


                                         }

                                       print("${similarity/totalIngredients}");
                                       if( similarity / totalIngredients >= 0.6 && similarity / totalIngredients < 0.8)
                                       {
                                         recommended.add(recipes[recipe]);
                                       } else if (similarity / totalIngredients >= 0.8 && similarity / totalIngredients < 1)
                                       {
                                         highlyRecommended.add(recipes[recipe]);
                                       } else if (similarity / totalIngredients >= 1)
                                       {
                                         match.add(recipes[recipe]);
                                       } else
                                       {

                                       }

                                     }
                                   print("Recipes suggested!");



                                   for(int i = 0; i < (recommended.length + highlyRecommended.length + match.length); i++ )
                                   {
                                     if(recommended.length > 3)
                                     {
                                       int rand = Random().nextInt(recommended.length);
                                       recommended.removeAt(rand);
                                     }
                                     if(highlyRecommended.length > 3)
                                     {
                                       int rand = Random().nextInt(recommended.length);
                                       highlyRecommended.removeAt(rand);
                                     }
                                     if(match.length > 3)
                                     {
                                       int rand = Random().nextInt(recommended.length);
                                       match.removeAt(rand);
                                     }
                                   }

                                   Navigator.push(
                                       context,
                                       MaterialPageRoute(builder: (context) => RecommendationsPage(recommended, highlyRecommended, match)
                                       )
                                   );

                             }).catchError((error) {
                               print("Failed to retrieve $meal recipes!");
                               print(error.toString());
                             });
                            },
                            child: Text(
                              "Done",
                              style: TextStyle(
                                fontSize: buttonHeight,
                              ),),

                          ),
                        ))
                  ],
                ),
              ),
    );
  }
}
