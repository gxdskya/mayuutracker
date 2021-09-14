import 'package:csia/FoodSearch/LoggedInHome.dart';
import 'package:csia/Welcome/Registration.dart';
import 'package:flutter/material.dart';
import 'ScrollingNavigation.dart';
import 'package:csia/Welcome/Welcomepage.dart';
import 'package:csia/FoodSearch/foodSearch.dart';
import 'package:csia/Welcome/Login.dart';
import 'package:csia/VidPlayer/VidPlayer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:csia/utilities/ErrorPage.dart';
import 'package:csia/Settings/Settings.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{

  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Welcome.id,
      routes: {
        VidPlayer.vidPlayerID : (context) => VidPlayer(),//navigate to vid player page
        Welcome.id :(context) => Welcome(), //navigate to the welcome page
        Login.id: (context) => Login(), //navigate to the login page
        Registration.id: (context) => Registration(),
        Settings.id: (context) => Settings(),
        FoodSearchHome.id: (context) => FoodSearchHome(),
        SearchStateful.id: (context) => SearchStateful(),
        LoginHome.id: (context) => LoginHome(),
      },
    );
  }
}



//use this command flutter run -d chrome --web-renderer html