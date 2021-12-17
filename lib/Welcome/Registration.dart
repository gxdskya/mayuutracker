import 'package:csia/Settings/Settings.dart';
import 'package:flutter/material.dart';

import '../consts.dart';
import 'AuthenticationFields.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
//firebase imports
class Registration extends StatefulWidget {
  static String id = 'Registration';

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String password;
  String email;
  bool showSpinner = false;
  String errorMessage = '   ';
  final _auth = FirebaseAuth.instance;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
  void initState(){
    super.initState();
  }

  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: myTheme.primaryColor,
      appBar: AppBar(
        backgroundColor: myTheme.accentColor,
        title: Text('Register', style: kTextStyle),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

                Padding(
                  padding: EdgeInsets.all(20),
                  child: AuthenticationField(
                    //reused widget
                    errorMessage: errorMessage,
                    onSubmitted: () async{
                      setState(() {
                        showSpinner = true;
                      });
                      if(password.length<6){
                        setState(() {
                          errorMessage = 'Your password was less than 6 characters. Please try a different password that is at least 6 characters';
                        });
                        //error message
                      }
                      else{
                        try{

                          final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                          if (newUser != null){
                            setState(() {
                              showSpinner = false;
                            });
                            print(newUser.user.email +' has successfully registered');
                            Navigator.pushNamed(context, Settings.id);
                          }

                        }
                        catch(exception){
                          print('something happened');
                          setState(() {
                            showSpinner = false;
                            errorMessage = 'We were unable to register you. Please check your internet connection and try again later.';
                          });
                        }
                      }




                  },title: 'Register',
                    controllerEmail: _emailController,
                    onEmailChange: (value){
                      email = value;
                    },

                    controllerPassword: _passwordController,
                    onPasswordChange: (value){
                      password = value;
                    },
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
