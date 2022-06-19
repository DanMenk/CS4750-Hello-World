import 'package:flutter/material.dart';

class StepsPage extends StatefulWidget {
  const StepsPage({Key? key}) : super(key: key);

  @override
  State<StepsPage> createState() => _StepsPageState();
}

class _StepsPageState extends State<StepsPage> {

  var steps = [];
  final List<TextEditingController> _stepControllers = [TextEditingController()];
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
                  itemCount: _stepControllers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Container(
                          margin: const EdgeInsets.all(5),
                          child: TextField(
                            controller: _stepControllers[index],
                            obscureText: false,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Step ${index+1}',
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
                        _stepControllers.add(TextEditingController());
                        _scroll.jumpTo(_scroll.position.maxScrollExtent);
                        setState(() {

                        });
                      },
                      child: const Text('Add Another Step'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: ElevatedButton(
                      onPressed: () {
                        for(var ingredient in _stepControllers)
                        {
                          steps.remove(ingredient.text);
                        }
                        for(var ingredient in _stepControllers)
                        {
                          steps.add(ingredient.text);
                        }
                        print(steps);
                        Navigator.pop(context, steps);

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
