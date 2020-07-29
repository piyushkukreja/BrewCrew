import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/authenticate/authenticate.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    //below line access the user data from the stream
    final user = Provider.of<User>(context);


    //return wither home or authenticate widget
    if(user == null) {
      return Authenticate();
    }else {
      return Home();
    }
    
  }
}