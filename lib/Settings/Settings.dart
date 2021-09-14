import 'package:csia/FoodSearch/LoggedInHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Settings extends StatefulWidget {
  static String id = 'Settings';
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int height = 163;
  int weight = 50;
  int age = 25;
  Color backgroundColor1 = Colors.grey;
  Color backgroundColor2 = Colors.grey;
  bool isFemale;
  FirebaseAuth _auth = FirebaseAuth.instance;
  User loggedInUser;
  final _firestore = FirebaseFirestore.instance;


  void getCurrentUser() async {
    try{
      final User _user = _auth.currentUser;
      if (_user !=null){
        loggedInUser = _user;
      }
      else{
        Navigator.pop(context);
      }

    }
    catch(e){
      Navigator.pop(context);
    }
  }


  @override
  void initState(){
   super.initState();
   getCurrentUser();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Column(
        children: [
          Text('Please enter your stats'),

          Row(
            children: [
              TextButton(child: Icon(FontAwesomeIcons.mars),style: TextButton.styleFrom(backgroundColor: backgroundColor1), onPressed: (){
                setState(() {
                  backgroundColor1 = Colors.blue;
                  backgroundColor2 = Colors.grey;
                  isFemale = false;

                });
              },),
              TextButton(child: Icon(FontAwesomeIcons.venus), style: TextButton.styleFrom(backgroundColor: backgroundColor2),onPressed: (){
                setState(() {
                  backgroundColor1 = Colors.grey;
                  backgroundColor2 = Colors.blue;
                  isFemale = true;
                });
              },),
            ],
          ),
          Slider(
            value: height.toDouble(),
            min: 100,
            max: 220,
            divisions: 121,
            onChanged: (double value){

              setState(() {
                height = value.toInt();
              });

            },),
          Text(height.toString()),
          Slider(
            value: weight.toDouble(),
            min: 10,
            max: 100,
            divisions: 91,
            onChanged: (double value){
              setState(() {
                weight = value.toInt();
              });
            },
          ),
          Text(weight.toString()),
          Slider(
            value: age.toDouble(),
            min: 18,
            max: 100,
            divisions: 83,
            onChanged: (double value){
              setState(() {
                age = value.toInt();
              });
            },
          ),
          Text(age.toString()),
          TextButton(
            child: Text('I\'m done'),
            style: TextButton.styleFrom(

              backgroundColor: Colors.blue,
            ),
            onPressed: () async {
              if (isFemale != null) {
                await _firestore.collection(loggedInUser.toString()+'stats').add({'timestamp': DateTime.now().toUtc(), 'height' : height , 'weight': weight, 'age' : 'age' });

                Navigator.pushNamed(context, LoginHome.id);
              }

            },
          ),
        ],
      ),
    );
  }
}
