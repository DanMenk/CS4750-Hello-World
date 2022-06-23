import 'package:flutter/material.dart';
import 'package:recipe_ran/how_to_cook.dart';
import 'package:recipe_ran/main_menu.dart';

class RecommendationsPage extends StatefulWidget {
  const RecommendationsPage(this.recommend, this.highlyRecommend, this.match, {Key? key}) : super(key: key);
  final List<dynamic> recommend;
  final List<dynamic> highlyRecommend;
  final List<dynamic> match;

  @override
  State<RecommendationsPage> createState() => _RecommendationsPageState();
}



class _RecommendationsPageState extends State<RecommendationsPage> {

  late var recommend = [];
  late var highlyRecommend = [];
  late var match = [];
  @override
  void initState()
  {
      recommend = widget.recommend;
      highlyRecommend = widget.highlyRecommend;
      match = widget.match;
      super.initState();
  }

  @override
  Widget build(BuildContext context) {

    const double buttonWidthMod = 1;
    var deviceData = MediaQuery.of(context);
    double buttonWidth = buttonWidthMod*deviceData.size.width;

    double unitTextHeightValue = deviceData.size.height * 0.01;
    double buttonMultiplier = 2;
    double buttonHeight = buttonMultiplier * unitTextHeightValue;

    print(recommend);
    print(highlyRecommend);
    print(match);

    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Results",),
      ),
      body: Center(
        child: Column(
          children: [

            Expanded(
              flex: 90,
              child: Column(
                children: [
                  ExpansionTile(
                    title: const Text("Match"),
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: match.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (match.isEmpty)
                            {
                              return const ListTile();
                            } else
                              {
                                return ListTile(
                                  onTap: () {

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => HowToCookPage(match[index]['recipeName'], match[index]['ingredients'], match[index]['steps'])
                                        )
                                    );

                                  },
                                  title: Container(
                                    margin: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(5),
                                          child: Text(
                                            "${match[index]['recipeName']}",
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.all(5),
                                          child: Text("Amount of Ingredients: ${match[index]['ingredients'].length}"),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.all(5),
                                          child: Text("Number of Steps: ${match[index]['steps'].length}"),
                                        ),

                                      ],
                                    ),
                                  ),

                                );
                              }


                        }
                    ),
                  ]
                  ),
                  ExpansionTile(
                      title: const Text("Highly Recommended"),
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: highlyRecommend.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (highlyRecommend.isEmpty)
                              {
                                return const ListTile();
                              } else
                              {
                                return ListTile(
                                  onTap: () {

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => HowToCookPage(highlyRecommend[index]['recipeName'], highlyRecommend[index]['ingredients'], highlyRecommend[index]['steps'])
                                        )
                                    );

                                  },
                                  title: Container(
                                    margin: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(5),
                                          child: Text(
                                            "${highlyRecommend[index]['recipeName']}",
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.all(5),
                                          child: Text("Amount of Ingredients: ${highlyRecommend[index]['ingredients'].length}"),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.all(5),
                                          child: Text("Number of Steps: ${highlyRecommend[index]['steps'].length}"),
                                        ),

                                      ],
                                    ),
                                  ),

                                );
                              }


                            }
                        ),
                      ]
                  ),
                  ExpansionTile(
                      title: const Text("Recommended"),
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: recommend.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (recommend.isEmpty)
                              {
                                return const ListTile();
                              } else
                              {
                                return ListTile(
                                  onTap: () {

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => HowToCookPage(recommend[index]['recipeName'], recommend[index]['ingredients'], recommend[index]['steps'])
                                        )
                                    );

                                  },
                                  title: Container(
                                    margin: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(5),
                                          child: Text(
                                            "${recommend[index]['recipeName']}",
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.all(5),
                                          child: Text("Amount of Ingredients: ${recommend[index]['ingredients'].length}"),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.all(5),
                                          child: Text("Number of Steps: ${recommend[index]['steps'].length}"),
                                        ),

                                      ],
                                    ),
                                  ),

                                );
                              }


                            }
                        ),
                      ]
                  ),
              ]
              ),
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
                )
            )

          ],
        ),
      ),

    );
  }
}
