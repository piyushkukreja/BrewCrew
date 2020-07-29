import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import "package:flutter/material.dart";

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth  = AuthService();
  final _formKey = GlobalKey<FormState>(); //formstate to check for validations(basic) inside the form itself
  bool loading = false;//for the loading screen

  //text field state
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign In to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () {
              widget.toggleView();
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical:20.0, horizontal: 50.0),
        child: Form(
          key: _formKey, //associating the form key with the form for validations
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),//sized box for spacing between components of column
              TextFormField(  //email field
              decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val.isEmpty ? 'Please enter some value' : null, //satisfies the validate method for the form
                onChanged: (val) {  //any changes to value of field gets stored in 'val'
                  setState(() => email = val);
                },
                ),
                SizedBox(height: 20.0),
                TextFormField(  //password field
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  validator: (val) => val.length < 6 ? 'Please enter 6+ chars value' : null, //satisfies the validate method for the form
                  obscureText: true, //to hide passwords as dots
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(  //sign in button at the bottom of the form
                  color: Colors.pink[400],
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {  // async as it will take some time to sign in
                    if (_formKey.currentState.validate())//validates the form on current state as true or false
                    {
                      //loading screen should only appear between validation and signing in
                      setState(() => loading = true);
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if(result == null) {
                        setState(() => {
                            error = "Could not sign in with those credentials!",
                            loading = false,
                          });
                      }
                    }
                  }
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14.0,
                  ),
                ),
            ],
            ),
          ),
        ),
      );
  }
}