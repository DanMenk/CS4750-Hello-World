import 'package:flutter/material.dart';

class StepsPage extends StatefulWidget {
  const StepsPage(this.ste, this.long, {Key? key}) : super(key: key);

  final int long;
  final List<dynamic> ste;

  @override
  State<StepsPage> createState() => _StepsPageState();
}

class _StepsPageState extends State<StepsPage> {

  late var steps;
  late int size;
  late List<TextEditingController> _stepControllers = [];
  late ScrollController _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    size = widget.long;
    steps = [];
    _scroll = ScrollController();
    for(int i = 0; i < size; i++)
    {
      _stepControllers.add(TextEditingController(text: widget.ste[i]));

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
                    width: 120,
                    height: 100,
                    margin: const EdgeInsets.all(5),
                    child: ElevatedButton(
                      onPressed: () {
                        _stepControllers.add(TextEditingController());
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
                        var foodSize = _stepControllers.length;
                        for(int i = foodSize-1; i > 0; i--)
                        {
                          if(_stepControllers[i].text == "")
                          {
                            _stepControllers.removeAt(i);
                          }
                        }
                        _scroll.jumpTo(_scroll.position.maxScrollExtent);
                        setState(() {

                        });
                      },
                      child: const Text(
                        "Remove Empty Steps",
                        textAlign: TextAlign.center,),
                    ),
                  ),

                ],
              ),
              Container(
                margin: const EdgeInsets.all(5),
                child: ElevatedButton(
                  onPressed: () {
                    for(var step in _stepControllers)
                    {
                      steps.remove(step.text);
                    }
                    for(var step in _stepControllers)
                    {
                      steps.add(step.text);
                    }

                    Navigator.pop(context, steps);

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
