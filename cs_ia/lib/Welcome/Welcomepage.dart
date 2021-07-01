
import 'package:flutter/material.dart';
import 'package:csia/FoodSearch/Networking.dart';

class Welcome extends StatelessWidget {

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
          child: Container(
            child: TextButton(
              child: Text('press me'),
              onPressed: ()
              {
                Networking networking = Networking();

              },
            ),
          ),
        ),
      ),
    );
  }
}
