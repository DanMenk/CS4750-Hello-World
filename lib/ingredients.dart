import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'Recipe.dart';

class IngredientsPage extends StatefulWidget {
  const IngredientsPage({Key? key}) : super(key: key);

  @override
  State<IngredientsPage> createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {




  var ingredients = [];
  final List<TextEditingController> _foodControllers = [TextEditingController()];
  final ScrollController _scroll = ScrollController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              controller: _scroll,
              child: Column(
                children: [
                  ListView.builder(

                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                      itemCount: _foodControllers.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                                     Container(
                                      margin: const EdgeInsets.all(5),
                                      child: TextField(
                                        controller: _foodControllers[index],
                                        obscureText: false,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Ingredient',
                                        ),
                                      ),
                                    ),




                          ],
                        );
                    }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: ElevatedButton(
                          onPressed: () {
                            _foodControllers.add(TextEditingController());
                            _scroll.jumpTo(_scroll.position.maxScrollExtent);
                            setState(() {

                            });
                          },
                          child: const Text('Add Another Ingredient'),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: ElevatedButton(
                          onPressed: () {
                            for(var ingredient in _foodControllers)
                            {
                              ingredients.remove(ingredient.text);
                            }
                            for(var ingredient in _foodControllers)
                            {
                              ingredients.add(ingredient.text);
                            }
                            print(ingredients);
                            Navigator.pop(context, ingredients);

                          },
                          child: const Text('Done'),
                        ),
                      ),
                    ],
                  )
                ],
              ),

            ),
          ),
    );
  }
}
