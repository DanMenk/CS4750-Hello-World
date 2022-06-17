import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:recipe_ran/Recipe.dart';

class AddARecipePage extends StatefulWidget {
  const AddARecipePage({Key? key}) : super(key: key);

  @override
  State<AddARecipePage> createState() => _AddARecipePageState();
}

class _AddARecipePageState extends State<AddARecipePage> {


  late Recipe recipe1;
  double ingredientsLength = 10;
  double stepsLength = 10;

  late String ingredient;
  late String step;

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
    });
  }
    Future<void> initializeEmptyIngredientsAndSteps() async {
      var tmpFood = [];
      FirebaseDatabase database = FirebaseDatabase.instance;
      var tmpStep = [];

      await database.ref().child("Recipes/Recipe0/steps").get()
          .then((data) {
        print("Successfully loaded steps.");

        Map<dynamic, dynamic>? rules = data.value as Map?;
        print(rules);
        rules?.forEach((key, value) {

          step = value;
          tmpStep.add(step);
        });
      }).catchError((error) {
        print("Hello! Failed to load steps.");
        print(error);
      });

      await database.ref().child("Recipes/Recipe0/ingredients").get()
          .then((data) {
        print("Successfully loaded ingredients.");



        Map<dynamic, dynamic>? food = data.value as Map?;
        print(food);
        food?.forEach((key, value) {

          ingredient = value;
          tmpFood.add(ingredient);

          print(tmpFood);
        });
      }).catchError((error) {
        print("Hi! Failed to load ingredients.");
        print(error);
      });
      ;
      recipe1 = Recipe("", tmpFood, tmpStep, "");

      for(int i = 0; i < recipe1.steps.length; i++)
      {

        print(recipe1.ingredients.elementAt(i));
        print(recipe1.steps.elementAt(i));
      }
    }
  _AddARecipePageState() {
    initializeEmptyIngredientsAndSteps();
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
                margin: EdgeInsets.all(20),
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
                      margin: EdgeInsets.all(10),
                      child: const TextField(
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Recipe Name',
                        ),
                      ),

                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                              value: 1,
                              groupValue: _groupValue,
                              onChanged: radioValueChanged
                          ),
                          Text("Breakfast"),
                          Radio(
                              value: 2,
                              groupValue: _groupValue,
                              onChanged: radioValueChanged),
                          Text("Lunch"),
                          Radio(
                              value: 3,
                              groupValue: _groupValue,
                              onChanged: radioValueChanged),
                          Text("Dinner"),
                        ],
                        ),
                      ),


                  ],
                )
            ),


            Column(
              children: [
                ListView.builder(
                  itemExtent: ingredientsLength,
                  scrollDirection: Axis.vertical,

                  itemBuilder: (BuildContext context, int index) {
                    return Column(

                    );
                  },

                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
