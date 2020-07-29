import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import "package:firebase_auth/firebase_auth.dart";

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;//a stream to notify if the user is signed in or not

  //create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }


  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
    .map(_userFromFirebaseUser);

  }


  //sign in anyonymously
  Future signInAnon() async {
    try{
      AuthResult  result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email& password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }

  }



  //register with email& password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      //create a new document for the user with the uid

      await DatabaseService(uid:user.uid).updateUserData('0', 'brew crew member', 100);

      return _userFromFirebaseUser(user);
    } catch(e) {
        print(e.toString());
        return null;
    }

  }
  
  //sign out
  Future signout() async {
    try{
      return await _auth.signOut();
    }catch(e) {
      print('Cannot sign out'+e.toString());
      return null;
    }
  }

}