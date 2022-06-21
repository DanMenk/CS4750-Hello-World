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

    var ingredients = [];
    var values = [];

    FirebaseDatabase.instance.ref().child("Ingredients")
        .get().then((value) {
      print("Retrieved Ingredients!");

      Map? food = value.value as Map?;
      food?.forEach((key, value) {
        ingredients.add(value);

      });

    }).catchError((error) {
      print("Failed to get Ingredients");
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
                              MaterialPageRoute(builder: (context) => ChooseIngredientsPage("Breakfast", ingredients, values)
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
                            MaterialPageRoute(builder: (context) => ChooseIngredientsPage("Lunch", ingredients, values)
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
                          MaterialPageRoute(builder: (context) => ChooseIngredientsPage("Dinner", ingredients, values)
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
