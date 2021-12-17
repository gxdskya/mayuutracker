import 'package:flutter/material.dart';

final kTextStyle = TextStyle(fontSize: 25, color: Color(0xFF0C0A3E));

final kButtonStyle = ButtonStyle(

  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF69353F)),
  padding: MaterialStateProperty.all(EdgeInsets.all(20)),


);

final ThemeData myTheme = ThemeData(
    primaryColor: Color(0xFFD5B0AC),
    focusColor: Color(0xFF0C0A3E),
    accentColor: Color(0xFF69353F),
    hoverColor: Color(0xFF914D76),
    splashColor: Color(0xFF708D81),
    sliderTheme: SliderThemeData(
      inactiveTrackColor: Color(0xFF914D76),
      activeTrackColor: Color(0xFF0C0A3E),
      overlayColor: Color(0xFF69353F),
      thumbColor: Color(0xFF0C0A3E),
    ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.deepPurple[300])
);

final kInputDecoration = InputDecoration(
  border: OutlineInputBorder(),
  focusColor: Color(0xFF914D76),
  fillColor: Color(0xFFD5B0AC),
  hoverColor: Color(0xFF69353F),
  contentPadding: EdgeInsets.all(5),
);