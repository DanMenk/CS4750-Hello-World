import 'package:flutter/material.dart';
import 'package:recipe_ran/choose_a_meal.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({Key? key}) : super(key: key);

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {

  @override
  Widget build(BuildContext context) {

    const double buttonWidthMod = 0.6;
    var deviceData = MediaQuery.of(context);
    double buttonWidth = buttonWidthMod*deviceData.size.width;

    double unitTitleHeightValue = deviceData.size.height * 0.01;
    double titlemultiplier = 5;
    double title = titlemultiplier * unitTitleHeightValue;

    double unitTextHeightValue = deviceData.size.height * 0.01;
    double buttonMultiplier = 2;
    double button = buttonMultiplier * unitTextHeightValue;

    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Expanded(

                flex: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Text(
                      "Recipe Randomizer",
                      style: TextStyle(
                        fontSize: title,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue
                      ),
                    ),
                  ],
                )
            ),

            Expanded(
                flex: 20,
                child: Container(
                  width: buttonWidth,
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ChooseAMealPage()
                          )
                      );
                    },
                    child: Text(
                        "Choose a Meal",
                        style: TextStyle(
                          fontSize: button,
                        ),
                    ),

                  ),
                )
            ),

            Expanded(
                flex: 20,
                child: Container(
                  width: buttonWidth,
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {

                    },
                    child: Text(
                      "Add Recipe",
                      style: TextStyle(
                        fontSize: button,
                      ),
                    ),

                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
