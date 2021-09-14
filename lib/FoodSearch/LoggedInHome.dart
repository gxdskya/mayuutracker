import 'package:csia/FoodSearch/foodSearch.dart';
import 'package:csia/Settings/Settings.dart';
import 'package:csia/VidPlayer/VidPlayer.dart';
import 'package:flutter/material.dart';

class LoginHome extends StatelessWidget {
  static String id = 'loginHome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          TextButton(onPressed: (){
            Navigator.pushNamed(context, FoodSearchHome.id);
          }, child: Text('Record Meals'),),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, VidPlayer.vidPlayerID);
            },
            child: Text('Go workout'),
          ),
          TextButton(onPressed: (){
            Navigator.pushNamed(context, Settings.id);

          }, child: Text('Go to settings'))
        ],
      ),
    );
  }
}
