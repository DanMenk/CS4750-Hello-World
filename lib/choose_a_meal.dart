import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:recipe_ran/choose_ingredients.dart';

class ChooseAMealPage extends StatefulWidget {
  const ChooseAMealPage({Key? key}) : super(key: key);

  @override
  State<ChooseAMealPage> createState() => _ChooseAMealPageState();
}

class _ChooseAMealPageState extends State<ChooseAMealPage> {

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
    
    var dairy = [];
    var fruit = [];
    var grain = [];
    var protein = [];
    var vegetable = [];
    var values = []; // for checkbox for ingredients on choose_ingredients page
    var database = FirebaseDatabase.instance.ref();

    database.child("Ingredients/Dairy")
        .get().then((value) {
      print("Retrieved Dairy!");

      Map? food = value.value as Map?;
      food?.forEach((key, value) {
        dairy.add(value);

      });

    }).catchError((error) {
      print("Failed to get Dairy");
      print(error.toString());
    });

    database.child("Ingredients/Fruit")
        .get().then((value) {
      print("Retrieved Fruits!");

      Map? food = value.value as Map?;
      food?.forEach((key, value) {
        fruit.add(value);

      });

    }).catchError((error) {
      print("Failed to get Fruits");
      print(error.toString());
    });

    database.child("Ingredients/Grain")
        .get().then((value) {
      print("Retrieved Grains!");

      Map? food = value.value as Map?;
      food?.forEach((key, value) {
        grain.add(value);

      });

    }).catchError((error) {
      print("Failed to get Grains");
      print(error.toString());
    });

    database.child("Ingredients/Protein")
        .get().then((value) {
      print("Retrieved Proteins!");

      Map? food = value.value as Map?;
      food?.forEach((key, value) {
        protein.add(value);

      });

    }).catchError((error) {
      print("Failed to get Proteins");
      print(error.toString());
    });

    database.child("Ingredients/Vegetable")
        .get().then((value) {
      print("Retrieved Vegetables!");

      Map? food = value.value as Map?;
      food?.forEach((key, value) {
        vegetable.add(value);

      });

    }).catchError((error) {
      print("Failed to get Vegetable");
      print(error.toString());
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 30,
                child: Center(
                  child: Text(
                      "Choose Your Meal",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: title,
                        color: Colors.blue,
                      ),
                  ),
                )
            ),
            Expanded(
              flex: 23,
              child:
                  Container(
                    width: buttonWidth,
                    margin: EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ChooseIngredientsPage("Breakfast", dairy, fruit, grain, protein, vegetable, values)
                              )
                          );
                        },
                        child: Text(
                          "Breakfast",
                          style: TextStyle(
                            fontSize: buttonHeight,
                          ),
                        ),
                    ),
                  ),
            ),

            Expanded(
                flex: 23,
                child: Container(
                  width: buttonWidth,
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChooseIngredientsPage("Lunch", dairy, fruit, grain, protein, vegetable, values)
                            )
                        );
                      },
                      child: Text(
                        "Lunch",
                        style: TextStyle(
                          fontSize: buttonHeight,
                        ),
                      )
                  ),
                ),
            ),

            Expanded(
              flex: 24,
              child: Container(
                width: buttonWidth,
                margin: EdgeInsets.all(10),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChooseIngredientsPage("Dinner", dairy, fruit, grain, protein, vegetable, values)
                          )
                      );
                    },
                    child: Text(
                      "Dinner",
                      style: TextStyle(
                        fontSize: buttonHeight,
                      ),
                    )
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
