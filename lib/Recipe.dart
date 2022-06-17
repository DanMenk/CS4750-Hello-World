import 'dart:collection';

class Recipe {
  String recipeName = "";
  var ingredients = [];
  var steps = [];
  String type = "";

  Recipe(this.recipeName, this.ingredients, this.steps, this.type);

}