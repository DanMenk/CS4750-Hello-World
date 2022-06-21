import 'package:flutter/material.dart';

import 'main_menu.dart';

class HowToCookPage extends StatefulWidget {
  HowToCookPage(this.recipeName, this.ingredients, this.steps);
  final String recipeName;
  final List<dynamic> ingredients;
  final List<dynamic> steps;

  @override
  State<HowToCookPage> createState() => _HowToCookPageState();
}

class _HowToCookPageState extends State<HowToCookPage> {

  late String recipeName;
  late var ingredients = [];
  late var steps = [];

  @override
  void initState() {

  recipeName = widget.recipeName;
  ingredients = widget.ingredients;
  steps = widget.steps;
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
              flex: 30,
                child: Text(
                    recipeName,
                  style: TextStyle(
                    fontSize: title,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                )
            ),
            Expanded(
                flex: 60,
                child: Column(
                  children: [
                    ExpansionTile(
                        title: const Text("Ingredients"),
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: ingredients.length,
                              itemBuilder: (BuildContext context, int index) {
                                return  Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(5),
                                            child: Text(
                                              "${ingredients[index]}",
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                }
                          ),
                        ]
                    ),
                    ExpansionTile(
                        title: const Text("Steps"),
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: steps.length,
                              itemBuilder: (BuildContext context, int index) {
                                return  Container(
                                  margin: const EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(5),
                                        child: Text(
                                          "Step ${index + 1}: ${steps[index]}",
                                          textAlign: TextAlign.center,

                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                          ),
                        ]
                    ),
                  ],
                )
            ),
            Expanded(
              flex: 10,
              child: Container(
                width: buttonWidth,
                margin: const EdgeInsets.all(5),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MainMenuPage()
                        )
                    );
                  },
                  child: Text(
                    "Back to Main Menu",
                    style: TextStyle(
                      fontSize: buttonHeight,
                    ) ,

                  ),

                ),
              ))
          ],
        ),
      ),
    );
  }
}
