import 'package:flutter/material.dart';

class StepsPage extends StatefulWidget {
  const StepsPage(this.ste, this.long, {Key? key}) : super(key: key);

  final int long;
  final List<dynamic> ste;

  @override
  State<StepsPage> createState() => _StepsPageState();
}

class _StepsPageState extends State<StepsPage> {

  late var steps = [];
  late int size;
  late final List<TextEditingController> _stepControllers = [];
  late ScrollController _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    size = widget.long;
    _scroll = ScrollController();
    if(size < 1)
    {
      _stepControllers.add(TextEditingController());
    }
    else
    {
      for(int i = 0; i < size; i++)
      {
        _stepControllers.add(TextEditingController(text: widget.ste[i]));

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
    const double buttonWidthMod = 0.4;
    double buttonWidth = buttonWidthMod*deviceData.size.width;

    double unitTextHeightValue = deviceData.size.height * 0.01;
    double buttonMultiplier = 2;
    double button = buttonMultiplier * unitTextHeightValue;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Recipe Steps",
        ),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        controller: _scroll,
        child: Container(
          margin: const EdgeInsets.only(top: 10),
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
              Container(
                width: buttonWidth,
                margin: const EdgeInsets.all(5),
                child: ElevatedButton(
                  onPressed: () {
                    _stepControllers.add(TextEditingController());
                    _scroll.jumpTo(_scroll.position.maxScrollExtent);
                    setState(() {

                    });
                  },
                  child: Text(
                    'Add Another Step',
                    style: TextStyle(fontSize: button),
                    textAlign: TextAlign.center,),
                ),
              ),
              Container(
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
