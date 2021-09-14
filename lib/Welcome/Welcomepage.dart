
import 'package:csia/Welcome/Login.dart';
import 'package:csia/Welcome/Registration.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  static String id = 'welcome';
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            print('hello, world!');
          },
        ),
        body: Center(
          child: Column(
            children: [
              Text('MyHealthDiary'),
              TextButton(child: Text('Login'),onPressed: (){
                Navigator.pushNamed(context, Login.id);
              },),
              TextButton(onPressed: (){
                Navigator.pushNamed(context, Registration.id);
              },
                  child: Text('Register')),
            ],
          ),
        ),
      ),
    );
  }
}
