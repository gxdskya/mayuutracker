import 'package:csia/FoodSearch/foodSearch.dart';
import 'package:csia/Settings/Settings.dart';
import 'package:csia/VidPlayer/VidPlayer.dart';
import 'package:flutter/material.dart';
import 'package:csia/consts.dart';
class LoginHome extends StatelessWidget {
  static String id = 'loginHome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myTheme.primaryColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextButton(
                style: kButtonStyle,
                onPressed: (){
                Navigator.pushNamed(context, FoodSearchHome.id);
              }, child: Text('Record Meals', style: kTextStyle,),),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextButton(
                style: kButtonStyle,
                onPressed: () {
                  Navigator.pushNamed(context, VidPlayer.vidPlayerID);
                },
                child: Text('Go workout', style: kTextStyle),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextButton(
                  style: kButtonStyle,
                  onPressed: (){

                Navigator.pushNamed(context, Settings.id);


              }, child: Text('Go to settings', style: kTextStyle) ),
            )
          ],
        ),
      ),
    );
  }
}
