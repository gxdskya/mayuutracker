import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csia/FoodSearch/Food.dart';
import 'package:csia/Welcome/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:csia/utilities/Networking.dart';
import 'package:csia/FoodSearch/Food.dart';
import 'package:csia/ScrollingNavigation.dart';
import 'package:csia/FoodSearch/classes/FoodItem.dart' as foodDetails;
import 'package:csia/FoodSearch/FoodInstantEndpoint.dart';
import 'package:http/http.dart';

import 'Food.dart' as food;
import 'classes/FoodItem.dart';


//persistent storage
Networking networking = Networking();

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;

User loggedInUser;


class FoodSearchHome extends StatelessWidget {
  static String id = 'FoodSearchHome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed: (){
        Navigator.pushNamed(context, SearchStateful.id);
      },),
      body: Column(
        children: [
          ConsumedFoodDisplay(),


        ],
      ),
    );

  }
}

class ConsumedFoodDisplay extends StatefulWidget {
  @override
  _ConsumedFoodDisplayState createState() => _ConsumedFoodDisplayState();
}

class _ConsumedFoodDisplayState extends State<ConsumedFoodDisplay> {
  @override
  void initState(){
    super.initState();

  }
  Widget build(BuildContext context) {
    return Container();
  }
}



class SearchStateful extends StatefulWidget {//searching widget
  static String id = 'search';
  @override
  _SearchStatefulState createState() => _SearchStatefulState();
}

class _SearchStatefulState extends State<SearchStateful> {
  List<Widget> foodList = [];

  @override

  Widget build(BuildContext context) {
    TextEditingController _myController = TextEditingController();
    void dispose(){
      _myController.dispose();
      super.dispose();
    }

    String searchTerm;
    return Scaffold(
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [

                  Expanded(
                    child: TextField(//enter search term
                      controller: _myController,
                      obscureText: false,
                      onSubmitted: (value) async {
                        print(value);
                        searchTerm = value;
                        foodList = [CircularProgressIndicator()];
                        InstantEndpoint instantEndpoint = await networking
                            .getRawData(searchTerm);
                        foodList = [];

                        for (Result result in instantEndpoint
                            .results) { //make instant endpoint
                          Widget foodResult = TextButton(

                            onPressed: () async {
                              print(result.id);
                              FoodItem selectedFood = await networking.getFoodData(result.id.toInt());
                              List<foodDetails.Flavonoid> listOfNutrients = selectedFood.nutrition.nutrients;
                              print(listOfNutrients.toString());
                              double foodAmount = selectedFood.nutrition.weightPerServing.amount;
                              foodDetails.Unit unit = selectedFood.nutrition.weightPerServing.unit;
                              double scaleFactor = 100/foodAmount;
                              print(listOfNutrients.toString());
                              List<Widget> nutrientWidgetList = [];
                              for (foodDetails.Flavonoid flavonoid in listOfNutrients){
                                print(flavonoid.name);
                                print(flavonoid.amount);
                                print(flavonoid.unit);
                                double actualQuantity = (flavonoid.amount)*scaleFactor;
                                Widget individualNutrient = SizedBox(height: 100, child: Padding(padding: EdgeInsets.all(20),child: Row(
                                  children: [
                                    Text(flavonoid.name),
                                    Text(actualQuantity.toStringAsFixed(2)),
                                    Text(flavonoid.unit.toString()),
                                  ],
                                ),),);
                                if(flavonoid.name == "Calories"){
                                  nutrientWidgetList.insert(0, individualNutrient);
                                }
                                else{
                                  nutrientWidgetList.add(individualNutrient);
                                }
                              }
                              Navigator.push(context, 
                                MaterialPageRoute(builder: (context) => DetailsPage(displayedNutrients: nutrientWidgetList,nutrientName: selectedFood.name, unit: unit, foodDetailList: listOfNutrients,)),
                              );
                            },
                            child: Row(
                              children: [
                                Image(image: NetworkImage(
                                    'https://spoonacular.com/cdn/ingredients_100x100/' +
                                        result.image)),
                                Text(result.name),
                              ],
                            ),
                          );
                          foodList.add(foodResult);
                          setState(() {

                          });
                        }
                      }
                      ),
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: ListView(
                    children: foodList,
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


class DetailsPage extends StatefulWidget {
  final foodDetails.Unit unit;
  final List<foodDetails.Flavonoid> foodDetailList;
  final List<Widget> displayedNutrients;
  final String nutrientName;
  DetailsPage({this.displayedNutrients, this.nutrientName, this.unit, this.foodDetailList});
  @override

  _DetailsPageState createState() => _DetailsPageState();
}
class _DetailsPageState extends State<DetailsPage> {


  @override
  void initState(){
    super.initState();
    try {
      final User user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email + ' is logged in');
      }
    }
    catch(e){
      print('wrong');
      Navigator.pushNamed(context, Login.id);
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text(widget.nutrientName)),

        body: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [

              Expanded(child:Padding(
                padding: const EdgeInsets.all(20.0),
                child: EntryBox(flavanoidList: widget.foodDetailList, foodName: widget.nutrientName,),
              ),),

              Expanded(child: ListView(children: widget.displayedNutrients,))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.pop(context);
        },),
      ),
    );
  }
}

class EntryBox extends StatefulWidget {
  final String foodName;
  final List<foodDetails.Flavonoid> flavanoidList;
  EntryBox({this.flavanoidList, this.foodName});
  @override
  _EntryBoxState createState() => _EntryBoxState();
}

class _EntryBoxState extends State<EntryBox> {
  double numberOfGrams = 0;
  String errorMessage = "";

  TextEditingController _controller;
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [

          SizedBox(
            width: 100,
            child: TextField(

             controller: _controller,
              onChanged: (value){
               try {
                 numberOfGrams = double.parse(value);
                 errorMessage = "";
               }
               catch(e){
                 errorMessage = "Please enter a number";
                 print('not number');
               }

              },
            ),
          ),
          TextButton(
              onPressed: () async{



                    //code to add the entire array and display calories separately
                  },

              child: Text('ADD')),
        ],
      ),
    );
  }
}
