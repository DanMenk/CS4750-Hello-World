import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    double button = buttonMultiplier * unitTextHeightValue;

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

                        },
                        child: Text(
                          "Breakfast",
                          style: TextStyle(
                            fontSize: button,
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

                      },
                      child: Text(
                        "Lunch",
                        style: TextStyle(
                          fontSize: button,
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

                    },
                    child: Text(
                      "Dinner",
                      style: TextStyle(
                        fontSize: button,
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
