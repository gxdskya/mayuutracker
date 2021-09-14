import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


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
        Text(widget.errorMessage, style: TextStyle(
          color: Colors.red
        ),),
        TextField(
          controller: widget.controllerEmail,
          onChanged: widget.onEmailChange,
        ),
        TextField(
          controller: widget.controllerPassword,
          onChanged: widget.onPasswordChange,
          obscureText: true,
        ),
        TextButton(onPressed: widget.onSubmitted, child: Text(widget.title),),

      ],
    );
  }

}
