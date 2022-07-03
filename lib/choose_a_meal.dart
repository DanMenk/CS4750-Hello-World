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

    double unitTextHeightValue = deviceData.size.height * 0.01;
    double buttonMultiplier = 2;
    double buttonHeight = buttonMultiplier * unitTextHeightValue;

    var dairy = [];
    var fruit = [];
    var grain = [];
    var protein = [];
    var vegetable = [];
    var other = [];
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

    database.child("Ingredients/Other")
        .get().then((value) {
      print("Retrieved Other ingredients!");

      Map? food = value.value as Map?;
      food?.forEach((key, value) {
        other.add(value);

      });

    }).catchError((error) {
      print("Failed to get Other ingredients");
      print(error.toString());
    });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Choose a Meal",),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

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
                              MaterialPageRoute(builder: (context) => ChooseIngredientsPage("Breakfast", dairy, fruit, grain, protein, vegetable, other, values)
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
                            MaterialPageRoute(builder: (context) => ChooseIngredientsPage("Lunch", dairy, fruit, grain, protein, vegetable, other, values)
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
                          MaterialPageRoute(builder: (context) => ChooseIngredientsPage("Dinner", dairy, fruit, grain, protein, vegetable, other, values)
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
