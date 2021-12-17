import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:csia/consts.dart';

class AuthenticationField extends StatefulWidget {
  final TextEditingController controllerEmail;
  final TextEditingController controllerPassword;
  final Function onEmailChange;
  final Function onPasswordChange;
  final Function onSubmitted;
  final String title;
  final String errorMessage;
  AuthenticationField({this.onSubmitted, this.title, this.controllerEmail, this.controllerPassword, this.onEmailChange, this.onPasswordChange, this.errorMessage});
  @override
  _AuthenticationFieldState createState() => _AuthenticationFieldState();
}

class _AuthenticationFieldState extends State<AuthenticationField> {


  @override
  void initState(){
    super.initState();
  }

  Widget build(BuildContext context) {
    return Column(

      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Text(widget.errorMessage, style: TextStyle(
            color: Colors.red
          ),),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            decoration: kInputDecoration.copyWith(hintText: 'Email'),
            controller: widget.controllerEmail,
            onChanged: widget.onEmailChange,
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            decoration: kInputDecoration.copyWith(hintText: 'Password'),
            controller: widget.controllerPassword,
            onChanged: widget.onPasswordChange,
            obscureText: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextButton(onPressed: widget.onSubmitted, child: Text(widget.title, style: kTextStyle,), style: kButtonStyle),
        ),

      ],
    );
  }

}
