import 'package:csia/FoodSearch/LoggedInHome.dart';
import 'package:csia/consts.dart';
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
  Color backgroundColor1 = myTheme.accentColor;
  Color backgroundColor2 = myTheme.accentColor;
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
      backgroundColor: myTheme.primaryColor,

      appBar: AppBar(title: Text('Settings', style: kTextStyle), backgroundColor: myTheme.accentColor, ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Please enter your stats', style: kTextStyle),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextButton(child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(FontAwesomeIcons.mars, color: myTheme.focusColor,),
                      ),style: TextButton.styleFrom(backgroundColor: backgroundColor1), onPressed: (){
                        setState(() {
                          backgroundColor1 = myTheme.hoverColor;
                          backgroundColor2 = myTheme.accentColor;
                          isFemale = false;

                        });
                      },),
                    ),
                    SizedBox(width: 20,),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextButton(child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(FontAwesomeIcons.venus, color: myTheme.focusColor),
                      ), style: TextButton.styleFrom(backgroundColor: backgroundColor2),onPressed: (){
                        setState(() {
                          backgroundColor1 = myTheme.accentColor;
                          backgroundColor2 = myTheme.hoverColor;
                          isFemale = true;
                        });
                      },),
                    ),
                  ],
                ),
              ),
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
            Text(height.toString(), style: kTextStyle),
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
            Text(weight.toString(), style: kTextStyle,),
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
            Text(age.toString(), style: kTextStyle),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextButton(
                child: Text('I\'m done', style: kTextStyle),
                style: kButtonStyle,
                onPressed: () {

                  if (isFemale != null) {
                    _firestore.collection(loggedInUser.email.toString()+'stats').add({'timestamp': DateTime.now().toUtc(), 'height' : height , 'weight': weight, 'age' : 'age' });

                    Navigator.pop(context);
                    print('done');
                  }

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
