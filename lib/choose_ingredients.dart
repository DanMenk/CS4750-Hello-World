import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:recipe_ran/recommendations.dart';

class ChooseIngredientsPage extends StatefulWidget {
  const ChooseIngredientsPage(this.meal, this.dairy, this.fruit, this.grain, this.protein, this.vegetable, this.other, this.values,  {Key? key}) : super(key: key);
  final List<dynamic> other;
  final List<dynamic> dairy;
  final List<dynamic> fruit;
  final List<dynamic> grain;
  final List<dynamic> protein;
  final List<dynamic> vegetable;
  final List<dynamic> values;

  final String meal;

  @override
  State<ChooseIngredientsPage> createState() => _ChooseIngredientsPageState();
}

class _ChooseIngredientsPageState extends State<ChooseIngredientsPage> {



  late String meal;
  late var dairy = [];
  late var fruit = [];
  late var grain = [];
  late var protein = [];
  late var vegetable = [];
  late var other = [];
  late var chosenIngredients = [];
  late var values = [];

  @override
  void initState() {


    meal = widget.meal;
    dairy = widget.dairy;
    fruit = widget.fruit;
    grain = widget.grain;
    protein = widget.protein;
    vegetable = widget.vegetable;
    other = widget.other;
    values = widget.values;
    for(int i = 0; i < (dairy.length + fruit.length + grain.length + protein.length + vegetable.length + other.length); i++)
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

    double unitTextHeightValue = deviceData.size.height * 0.01;
    double buttonMultiplier = 2;
    double buttonHeight = buttonMultiplier * unitTextHeightValue;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Choose Your Ingredients",),
      ),
              body: Center(
                child: Column(
                  children: [

                    Expanded(
                      flex: 70,
                      child: SingleChildScrollView(
                        physics: const ScrollPhysics(),
                        child: Column(
                            children: [
                              ExpansionTile(

                                  title: const Text("Dairy"),
                                  children: [
                                    ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: dairy.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          if (dairy.isEmpty)
                                          {
                                            return Container();
                                          } else
                                          {
                                            return Container(
                                              margin: const EdgeInsets.all(5),
                                              child:
                                              CheckboxListTile(

                                                title: Text(dairy[index]),
                                                onChanged: (bool? value) {

                                                  if(values[index] == false)
                                                  {
                                                    chosenIngredients.add(dairy[index]);
                                                    values[index] = value;
                                                    setState((){

                                                    });
                                                  }
                                                  else {
                                                    chosenIngredients.remove(dairy[index]);
                                                    values[index] = value;
                                                    setState((){

                                                    });
                                                  }

                                                },
                                                value: values[index],

                                              ),

                                            );
                                          }


                                        }
                                    ),
                                  ]
                              ),
                              ExpansionTile(
                                  title: const Text("Fruits"),
                                  children: [
                                    ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: fruit.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          if (fruit.isEmpty)
                                          {
                                            return Container();
                                          } else
                                          {
                                            return Container(
                                              margin: const EdgeInsets.all(5),
                                              child:
                                              CheckboxListTile(

                                                title: Text(fruit[index]),
                                                onChanged: (bool? value) {

                                                  if(values[index + dairy.length] == false)
                                                  {
                                                    chosenIngredients.add(fruit[index]);
                                                    values[index + dairy.length] = value;
                                                    setState((){

                                                    });
                                                  }
                                                  else {
                                                    chosenIngredients.remove(fruit[index]);
                                                    values[index + dairy.length] = value;
                                                    setState((){

                                                    });
                                                  }

                                                },
                                                value: values[index + dairy.length],

                                              ),

                                            );
                                          }


                                        }
                                    ),
                                  ]
                              ),
                              ExpansionTile(
                                  title: const Text("Grains"),
                                  children: [
                                    ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: grain.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          if (grain.isEmpty)
                                          {
                                            return Container();
                                          } else
                                          {
                                            return Container(
                                              margin: const EdgeInsets.all(5),
                                              child:
                                              CheckboxListTile(

                                                title: Text(grain[index]),
                                                onChanged: (bool? value) {

                                                  if(values[index + dairy.length + fruit.length] == false)
                                                  {
                                                    chosenIngredients.add(grain[index]);
                                                    values[index + dairy.length + fruit.length] = value;
                                                    setState((){

                                                    });
                                                  }
                                                  else {
                                                    chosenIngredients.remove(grain[index]);
                                                    values[index + dairy.length + fruit.length] = value;
                                                    setState((){

                                                    });
                                                  }

                                                },
                                                value: values[index + dairy.length + fruit.length],

                                              ),

                                            );
                                          }


                                        }
                                    ),
                                  ]
                              ),
                              ExpansionTile(
                                  title: const Text("Proteins"),
                                  children: [
                                    ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: protein.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          if (protein.isEmpty)
                                          {
                                            return Container();
                                          } else
                                          {
                                            return Container(
                                              margin: const EdgeInsets.all(5),
                                              child:
                                              CheckboxListTile(

                                                title: Text(protein[index]),
                                                onChanged: (bool? value) {

                                                  if(values[index + dairy.length + grain.length + fruit.length] == false)
                                                  {
                                                    chosenIngredients.add(protein[index]);
                                                    values[index + dairy.length + grain.length + fruit.length] = value;
                                                    setState((){

                                                    });
                                                  }
                                                  else {
                                                    chosenIngredients.remove(protein[index]);
                                                    values[index + dairy.length + grain.length + fruit.length] = value;
                                                    setState((){

                                                    });
                                                  }

                                                },
                                                value: values[index + dairy.length + grain.length + fruit.length],

                                              ),

                                            );
                                          }


                                        }
                                    ),
                                  ]
                              ),
                              ExpansionTile(
                                  title: const Text("Vegetables"),
                                  children: [
                                    ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: vegetable.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          if (vegetable.isEmpty)
                                          {
                                            return Container();
                                          } else
                                          {
                                            return Container(
                                              margin: const EdgeInsets.all(5),
                                              child:
                                              CheckboxListTile(

                                                title: Text(vegetable[index]),
                                                onChanged: (bool? value) {

                                                  if(values[index + dairy.length + grain.length + protein.length + fruit.length] == false)
                                                  {
                                                    chosenIngredients.add(vegetable[index]);
                                                    values[index + dairy.length + grain.length + protein.length + fruit.length] = value;
                                                    setState((){

                                                    });
                                                  }
                                                  else {
                                                    chosenIngredients.remove(vegetable[index]);
                                                    values[index + dairy.length + grain.length + protein.length + fruit.length] = value;
                                                    setState((){

                                                    });
                                                  }

                                                },
                                                value: values[index + dairy.length + grain.length + protein.length + fruit.length],

                                              ),

                                            );
                                          }


                                        }
                                    ),
                                  ]
                              ),
                              ExpansionTile(

                                  title: const Text("Other"),
                                  children: [
                                    ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: other.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          if (other.isEmpty)
                                          {
                                            return Container();
                                          } else
                                          {
                                            return Container(
                                              margin: const EdgeInsets.all(5),
                                              child:
                                              CheckboxListTile(

                                                title: Text(other[index]),
                                                onChanged: (bool? value) {

                                                  if(values[index + dairy.length + grain.length + protein.length + fruit.length + vegetable.length] == false)
                                                  {
                                                    chosenIngredients.add(other[index]);
                                                    values[index + dairy.length + grain.length + protein.length + fruit.length + vegetable.length] = value;
                                                    setState((){

                                                    });
                                                  }
                                                  else {
                                                    chosenIngredients.remove(other[index]);
                                                    values[index + dairy.length + grain.length + protein.length + fruit.length + vegetable.length] = value;
                                                    setState((){

                                                    });
                                                  }

                                                },
                                                value: values[index + dairy.length + grain.length + protein.length + fruit.length + vegetable.length],

                                              ),

                                            );
                                          }


                                        }
                                    ),
                                  ]
                              ),
                            ]
                        ),
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
                                       var recipeIngredients = recipes[recipe]['ingredients'];
                                       var items = chosenIngredients.where((ingredient) => recipeIngredients.contains(ingredient));
                                       int similarity = items.length;
                                       int totalIngredients = recipes[recipe]['ingredients'].length;

                                       if( similarity / totalIngredients >= 0.5 && similarity / totalIngredients < 0.8)
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
