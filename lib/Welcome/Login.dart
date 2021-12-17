import 'package:csia/FoodSearch/LoggedInHome.dart';
import 'package:csia/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:csia/Welcome/AuthenticationFields.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class Login extends StatefulWidget {
  static String id = 'Login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  final _auth = FirebaseAuth.instance;
  String password;
  String email;
  String errorMessage = '    ';
  bool showSpinner = false;
  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myTheme.primaryColor,
      appBar: AppBar(title: Text('Login', style: kTextStyle), backgroundColor: myTheme.accentColor,),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: AuthenticationField(
                    controllerEmail: _emailController,
                    controllerPassword: _passwordController,
                    onPasswordChange: (value){
                      password = value;

                    },
                    onEmailChange: (value){
                      email = value;
                    },
                    errorMessage: errorMessage,
                    onSubmitted: () async{
                      setState(() {
                        showSpinner = true;
                      });
                      try{
                        final signedUser = await _auth.signInWithEmailAndPassword(email: email, password: password);
                        if (signedUser != null){
                          Navigator.pushNamed(context, LoginHome.id);
                          print(signedUser.user.email + ' has signed in successfully');

                          //push to screen and load data
                          showSpinner = false;
                          setState(() {

                          });


                        }


                      }
                      catch(e){
                        setState(() {
                          showSpinner = false;
                          errorMessage = 'Sorry, we could not log you in. Please check your email and password to ensure that they are spelt correctly. If problem persists, please contact customer services.';
                        });
                      }
                    },
                    title: 'Login',

                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
