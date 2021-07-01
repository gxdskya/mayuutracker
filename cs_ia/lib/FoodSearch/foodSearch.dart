import 'package:csia/FoodSearch/Food.dart';
import 'package:flutter/material.dart';
import 'package:csia/FoodSearch/Networking.dart';
import 'package:csia/FoodSearch/Food.dart';
import 'package:csia/ScrollingNavigation.dart';
import 'package:csia/FoodSearch/FoodItem.dart';
import 'package:csia/FoodSearch/FoodInstantEndpoint.dart';
import 'package:csia/Welcome/FoodDetailsDisplay.dart';
//persistent storage

class FoodSearchHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SingleFoodDisplay displayTest = SingleFoodDisplay();
    return MaterialApp(
      theme: ThemeData(

      ),
      title: 'Search',
      home: Scaffold(
        body: Column(
          children: [
            DynamicBodyFoodList(foodList: [displayTest, displayTest, displayTest,displayTest,displayTest],),//add the actual list here
          ],
        ), //TODO: find the actual food list
        appBar: AppBar(
          backgroundColor: ThemeData().backgroundColor,
          title: Text('Search'),


        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Search()), //adding the search
            );
          } //add food
        ),
      ),
    );
  }
}

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: SearchStateful(),
      ),
    );
  }
}


class SearchStateful extends StatefulWidget {//searching widget
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

    Networking networking = Networking();
    String searchTerm;
    return Container(
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
                    onSubmitted: (value){

                      setState(() {

                      });



                    },
                    onChanged: (value){
                      searchTerm = value;

                    },
                  ),
                ),
                TextButton(
                  child: Text('Search'),
                  onPressed: (){



                    setState(() {

                    });




                    
                  },
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: Column(
                  children: foodList,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DynamicBodyFoodList extends StatefulWidget {//how the final search results are displayed
  final List<Widget> foodList;
  DynamicBodyFoodList({Key key, @required this.foodList}): super (key:key);
  @override
  _DynamicBodyFoodListState createState() => _DynamicBodyFoodListState();
}

class _DynamicBodyFoodListState extends State<DynamicBodyFoodList> {

  @override

  Widget build(BuildContext context) {
    int length = widget.foodList.length;

    return Container(
      child: Column(
        children: widget.foodList,
      ),
    );
  }
}

class SingleFoodDisplay extends StatelessWidget {//widget used to display food



  @override

  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

          ],
        ),
      ),
    );
  }
}
//TODO: make the dynamic body food list WITH data from internet, not just data selected
//TODO: make the search page

class InstantEndpointWidget extends StatefulWidget {
  final List queries;

  InstantEndpointWidget(this.queries);

  @override
  _InstantEndpointWidgetState createState() => _InstantEndpointWidgetState();
}

class _InstantEndpointWidgetState extends State<InstantEndpointWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
