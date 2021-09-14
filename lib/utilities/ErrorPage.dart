import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.close_rounded),
            Text('ERROR: Please check your internet connection. If problem persists, please submit an error ticket'),
          ],
        ),
      ),
    );
  }
}
