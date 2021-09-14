import 'package:flutter/material.dart';
import 'package:csia/FoodSearch/classes/FoodItem.dart';

class FoodDetailsDisplay extends StatelessWidget {
  final FoodItem foodItem;
  FoodDetailsDisplay(this.foodItem);
//loop to find others
  double findCal(List<Flavonoid> myList){
    double returnValue;
    for (var i = 0; i<myList.length; i++){
      if (myList[i].name =='Calories'){
        returnValue = myList[i].amount;
      }
    }
    return returnValue;
  }


  @override
  Widget build(BuildContext context) {
    double gramValue = foodItem.nutrition.weightPerServing.amount;
    double actualValue = findCal(foodItem.nutrition.nutrients)/gramValue;
    return Scaffold(
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Expanded(child: Text(foodItem.name)),
                Expanded(child: Text(actualValue.toString())),//display stuff
              ],
            ),
          ),
         ),
      ),
    );
  }
}
//bottom up design approach