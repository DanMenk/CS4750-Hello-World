import 'package:flutter/material.dart';

class IngredientsPage extends StatefulWidget {
   const IngredientsPage(this.ingred, this.long, {Key? key}) : super(key: key);

  final int long;
  final List<dynamic> ingred;

  @override
  State<IngredientsPage> createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {




  late var ingredients;
  late int size;
  late List<TextEditingController> _foodControllers = [];
  late ScrollController _scroll;

  @override
  void initState() {
    super.initState();
    size = widget.long;
    ingredients = [];
    _scroll = ScrollController();
    for(int i = 0; i < size; i++)
    {
      _foodControllers.add(TextEditingController(text: widget.ingred[i]));

    }


  }

  @override
  void dispose() {
    super.dispose();
  }


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
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText: ("Ingredient ${index+1}"),
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
                        width: 120,
                        height: 100,
                        margin: const EdgeInsets.all(5),
                        child: ElevatedButton(
                          onPressed: () {
                            _foodControllers.add(TextEditingController());
                            _scroll.jumpTo(_scroll.position.maxScrollExtent);
                            setState(() {

                            });
                          },
                          child: const Text(
                              'Add Another Ingredient',
                              textAlign: TextAlign.center,),
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 100,
                        margin: const EdgeInsets.all(5),
                        child: ElevatedButton(
                          onPressed: () {
                            var foodSize = _foodControllers.length;
                            for(int i = foodSize-1; i > 0; i--)
                              {
                                if(_foodControllers[i].text == "")
                                  {
                                    _foodControllers.removeAt(i);
                                  }
                              }
                            _scroll.jumpTo(_scroll.position.maxScrollExtent);
                            setState(() {

                            });
                          },
                          child: const Text(
                              "Remove Empty Ingredients",
                              textAlign: TextAlign.center,),
                        ),
                      ),

                    ],
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

                        Navigator.pop(context, ingredients);

                      },
                      child: const Text('Done'),
                    ),
                  ),
                ],
              ),

            ),
          ),
    );
  }
}
