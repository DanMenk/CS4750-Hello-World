import 'package:flutter/material.dart';
import 'package:recipe_ran/ingredient.dart';

class IngredientsPage extends StatefulWidget {
   const IngredientsPage(this.ingred, this.long, {Key? key}) : super(key: key);

  final int long;
  final List<dynamic> ingred;

  @override
  State<IngredientsPage> createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {

  late List<dynamic> _ingredients = [];
  late int size;
  late List<TextEditingController> _foodControllers = [];
  late List<int> _groupValue = [];
  late ScrollController _scroll;

  @override
  void initState() {
    super.initState();
    size = widget.long;
    _ingredients = widget.ingred;
    _scroll = ScrollController();

    if(size < 1)
      {
        _foodControllers.add(TextEditingController());
        _groupValue.add(0);
      }
    else
      {
        for(int i = 0; i < size; i++)
        {
          print("Ingredient: ${widget.ingred[i].ingredientName}");
          print("Type: ${widget.ingred[i].type}");
          _foodControllers.add(TextEditingController(text: widget.ingred[i].ingredientName));
          int type = widget.ingred[i].type;
          if(type == 1)
            {
              _groupValue.add(1);
            } else if(type == 2)
              {
                _groupValue.add(2);
              } else if(type == 3)
                {
                  _groupValue.add(3);
                } else if(type == 4)
                  {
                    _groupValue.add(4);
                  } else if(type == 5)
                    {
                      _groupValue.add(5);
                    } else
                      {
                        _groupValue.add(6);
                      }


        }
      }



  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    var deviceData = MediaQuery.of(context);
    const double buttonWidthMod = 0.6;
    double buttonWidth = buttonWidthMod*deviceData.size.width;

    double unitTextHeightValue = deviceData.size.height * 0.01;
    double buttonMultiplier = 2;
    double button = buttonMultiplier * unitTextHeightValue;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Ingredients",),
      ),
          body: SingleChildScrollView(
            physics: const ScrollPhysics(),
            controller: _scroll,
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  ListView.builder(

                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                      itemCount: _foodControllers.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Radio(
                                    value: 1,
                                    groupValue: _groupValue[index],
                                    onChanged: (int? val) {
                                      _groupValue[index] = val!;
                                      if(size == 0)
                                        {
                                          _ingredients.add(Ingredient(_foodControllers[index].text, _groupValue[index]));
                                        }
                                      else
                                        {
                                          index >= size ? _ingredients.add(Ingredient(_foodControllers[index].text, _groupValue[index]))
                                              : _ingredients.replaceRange(index, index + 1,[Ingredient(_foodControllers[index].text, _groupValue[index])]);
                                        }

                                      setState((){});
                                    }
                                    ),
                                const Text("Dairy"),
                                Radio(
                                    value: 2,
                                    groupValue: _groupValue[index],
                                    onChanged: (int? val) {
                                      _groupValue[index] = val!;
                                      if(size == 0)
                                      {
                                        _ingredients.add(Ingredient(_foodControllers[index].text, _groupValue[index]));
                                      }
                                      else
                                      {
                                        index >= size ? _ingredients.add(Ingredient(_foodControllers[index].text, _groupValue[index]))
                                            : _ingredients.replaceRange(index, index + 1,[Ingredient(_foodControllers[index].text, _groupValue[index])]);
                                      }
                                      setState((){});
                                    }
                                    ),
                                const Text("Fruit"),
                                Radio(
                                    value: 3,
                                    groupValue: _groupValue[index],
                                    onChanged: (int? val) {
                                      _groupValue[index] = val!;
                                      if(size == 0)
                                      {
                                        _ingredients.add(Ingredient(_foodControllers[index].text, _groupValue[index]));
                                      }
                                      else
                                      {
                                        index >= size ? _ingredients.add(Ingredient(_foodControllers[index].text, _groupValue[index]))
                                        : _ingredients.replaceRange(index, index + 1,[Ingredient(_foodControllers[index].text, _groupValue[index])]);
                                      }
                                      setState((){});
                                    }
                                    ),
                                const Text("Grain"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Radio(
                                    value: 4,
                                    groupValue: _groupValue[index],
                                    onChanged: (int? val) {
                                      _groupValue[index] = val!;
                                      if(size == 0)
                                      {
                                        _ingredients.add(Ingredient(_foodControllers[index].text, _groupValue[index]));
                                      }
                                      else
                                      {
                                        index >= size ? _ingredients.add(Ingredient(_foodControllers[index].text, _groupValue[index]))
                                            : _ingredients.replaceRange(index, index + 1,[Ingredient(_foodControllers[index].text, _groupValue[index])]);
                                      }
                                      setState((){});
                                    }
                                    ),
                                const Text("Protein"),
                                Radio(
                                    value: 5,
                                    groupValue: _groupValue[index],
                                    onChanged: (int? val) {
                                      _groupValue[index] = val!;
                                      if(size == 0)
                                      {
                                        _ingredients.add(Ingredient(_foodControllers[index].text, _groupValue[index]));
                                      }
                                      else
                                      {
                                        index >= size ? _ingredients.add(Ingredient(_foodControllers[index].text, _groupValue[index]))
                                            : _ingredients.replaceRange(index, index + 1,[Ingredient(_foodControllers[index].text, _groupValue[index])]);
                                      }
                                      setState((){});
                                    }
                                    ),
                                const Text("Vegetable"),
                                Radio(
                                    value: 6,
                                    groupValue: _groupValue[index],
                                    onChanged: (int? val) {
                                      _groupValue[index] = val!;
                                      if(size == 0)
                                      {
                                        _ingredients.add(Ingredient(_foodControllers[index].text, _groupValue[index]));
                                      }
                                      else
                                      {
                                        index >= size ? _ingredients.add(Ingredient(_foodControllers[index].text, _groupValue[index]))
                                            : _ingredients.replaceRange(index, index + 1,[Ingredient(_foodControllers[index].text, _groupValue[index])]);
                                      }
                                      setState((){});
                                    }
                                ),
                                const Text("Other"),
                              ],
                            )




                          ],
                        );
                    }),
                  Container(
                    width: buttonWidth,
                    margin: const EdgeInsets.all(5),
                    child: ElevatedButton(
                      onPressed: () {
                        _foodControllers.add(TextEditingController());
                        _groupValue.add(0);
                        _scroll.jumpTo(_scroll.position.maxScrollExtent);
                        setState(() {

                        });
                      },
                      child: Text(
                          'Add Another Ingredient',
                          style: TextStyle(fontSize: button),
                          textAlign: TextAlign.center,),
                    ),
                  ),
                  Container(
                    width: buttonWidth,
                    margin: const EdgeInsets.all(5),
                    child: ElevatedButton(
                      onPressed: () {
                        var foodSize = _foodControllers.length;
                        for(int i = foodSize-1; i > 0; i--)
                        {
                          if(_foodControllers[i].text == "")
                          {
                            _foodControllers.removeAt(i);
                            _groupValue.removeAt(i);
                          }
                        }
                        _scroll.jumpTo(_scroll.position.maxScrollExtent);
                        setState(() {

                        });

                        print("Output: $_ingredients");

                        Navigator.pop(context, _ingredients);

                      },
                      child: Text(
                        'Done',
                        style: TextStyle(fontSize: button),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ),
    );
  }
}
