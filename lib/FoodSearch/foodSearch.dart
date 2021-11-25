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
import 'package:intl/intl.dart';

import 'Food.dart' as food;
import 'classes/FoodItem.dart';

List caloriesDayList = [];
double totalCalories = 0;




//persistent storage
Networking networking = Networking();

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;

User loggedInUser = _auth.currentUser;
String timestamp = DateFormat("yyyy-MM-dd").format(DateTime.now());
String collectionName = loggedInUser.email + 'sEntries' + DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();
Stream _stream = _firestore.collection(collectionName).snapshots();


class FoodSearchHome extends StatelessWidget {
  static String id = 'FoodSearchHome';



  @override

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed: (){
        Navigator.pushNamed(context, SearchStateful.id);
      },),
      body:Steambuilder2(),

    );

  }
}

class Steambuilder2 extends StatefulWidget {
  @override
  _Steambuilder2State createState() => _Steambuilder2State();
}

class _Steambuilder2State extends State<Steambuilder2> {
  List<Widget> widList = [];
  String name;
  String calories;
  @override
  Widget build(BuildContext context) {

    return Container(
      child: StreamBuilder(
        stream: _firestore.collection(collectionName).snapshots(),
          builder: (context, snapshots) {
            if(!snapshots.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else {

              final foods = snapshots.data.docs;
                for (var food in foods){
                  Map map = food.data();
                  List<dynamic> flavanoids = map['nutrientList'];
                  name = map['name'];

                  calories = map['calories'];
                  print(map['name']);
                  print(map['calories']);
                  widList.add(ButtonFood(height:100, child: Row(children: [Text(calories), Text(name)]), mapVar: flavanoids));
                }
              return ListView(children: widList);

            }





          }
      ),
    );
  }
}

class ButtonFood extends StatelessWidget {
  final Widget child;
  final List<dynamic> mapVar;
  final double height;
  ButtonFood({this.child, this.mapVar, this.height});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: child,
    );
  }
}



class Streambuilder extends StatefulWidget {


  @override
  State<Streambuilder> createState() => _StreambuilderState();
}

class _StreambuilderState extends State<Streambuilder> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return CircularProgressIndicator();
          }
          else{
            caloriesDayList = [];
            totalCalories = 0;
            List<Widget> foodItemList = [];
            List<Widget> newItems = [];
            final messages = snapshot.data.docs;

            for (var message in messages) {
              Map<String, dynamic> data = message.data();

              String calories = data['calories'];
              String name = data['name'];
              List nutrients = data['nutrientList'];
              foodItemList.add(FoodItemWidget(calories, name, nutrients));

            }
            for (double calorie in caloriesDayList){
              totalCalories = totalCalories + calorie;
            }
            return Container(child: ListView(
              children: foodItemList,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),),
            );
          }
          /*if (snapshot.hasData ==true){
      return Center(child: CircularProgressIndicator(),);
      }
      else{




      }*/
        }
    );
  }
}

class FoodItemWidget extends StatelessWidget {
  final String calories;
  final String name;
  final List listOfMicros;

  FoodItemWidget(this.calories, this.name, this.listOfMicros);

  @override
  Widget build(BuildContext context) {
    double calories2 = double.parse(calories);
    caloriesDayList.add(calories2);
    return TextButton(
      onPressed: (){

      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            Text(name),
            Text(calories),

        ],
      ),
      ),
    );
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
      appBar: AppBar(
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pop(context);
        },
      ),
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
                        foodList = [CircularProgressIndicator()];

                        print(value);
                        searchTerm = value;

                        InstantEndpoint instantEndpoint = await networking
                            .getRawData(searchTerm);
                        foodList = [];

                        for (Result result in instantEndpoint
                            .results) { //make instant endpoint
                          Widget foodResult = TextButton(

                            onPressed: () async {//method to get the actual food
                              print(result.id);
                              FoodItem selectedFood = await networking.getFoodData(result.id.toInt());
                              List<foodDetails.Flavonoid> listOfNutrients = selectedFood.nutrition.nutrients;
                              print(listOfNutrients.toString());
                              double foodAmount = selectedFood.nutrition.weightPerServing.amount;
                              foodDetails.Unit unit = selectedFood.nutrition.weightPerServing.unit;//scales it to 100g nutrient values
                              double scaleFactor = 100/foodAmount;
                              print(listOfNutrients.toString());
                              List<Widget> nutrientWidgetList = [];
                              for (foodDetails.Flavonoid flavonoid in listOfNutrients){
                                print(flavonoid.name);//just to check the validity of data
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

        },
            child: Text('Done?'),
        ),
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
              onPressed: () async {
                if (errorMessage == "") {
                  List<foodDetails.Flavonoid> actualNutrients = [];
                  double scaleFactor = numberOfGrams / 100;
                  double calories = scaleFactor *
                      widget.flavanoidList[0].amount;
                  widget.flavanoidList.removeAt(0);
                  List<Map> uploadDataNutrients = [];
                  print("ok");
                  for (foodDetails.Flavonoid flavanoid in widget
                      .flavanoidList) {
                    flavanoid.amount = flavanoid.amount * scaleFactor;
                    Map newMap = {flavanoid.amount.toString(): flavanoid.unit.toString()};
                    print(flavanoid.unit.toString());
                    Map newMap2 = {flavanoid.name: newMap};
                    uploadDataNutrients.add(newMap2);
                  }
                  print("ok");
                  DateTime timestamp1 = new DateTime.now();
                  String timestamp = DateFormat("yyyy-MM-dd").format(timestamp1);
                  String collectionName = loggedInUser.email + 'sEntries' +
                      timestamp.toString();
                  print('ok');
                  //code to add the entire array and display calories separately
                  try {
                    _firestore.collection(collectionName).add({
                      'user': loggedInUser.email.toString(),
                      'name': widget.foodName.toString(),
                      'calories': calories.toString(),
                      'nutrientList': uploadDataNutrients,
                      'timestamp': timestamp.toString()
                    });
                    print('ok');

                  } catch (e) {
                    print('go to');
                  }
                }

              },


        //code to add the entire array and display calories separately

              child: Text('ADD'),
              ),
      ],
      ),
    );
  }
}
