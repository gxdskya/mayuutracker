
import 'package:csia/Welcome/Login.dart';
import 'package:csia/Welcome/Registration.dart';
import 'package:flutter/material.dart';
import 'package:csia/consts.dart';

class Welcome extends StatelessWidget {
  static String id = 'welcome';
  @override

  Widget build(BuildContext context) {

    return MaterialApp(
      theme: myTheme,

      home: Scaffold(
        backgroundColor: myTheme.primaryColor,

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                  child: Text('Le Food Diary', style: kTextStyle.copyWith(fontStyle: FontStyle.italic, fontSize: 40),)
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton(child: Text('Login', style: kTextStyle,),onPressed: (){
                  Navigator.pushNamed(context, Login.id);
                }, style: kButtonStyle),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton(onPressed: (){
                  Navigator.pushNamed(context, Registration.id);
                },
                    child: Text('Register', style: kTextStyle),style: kButtonStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
