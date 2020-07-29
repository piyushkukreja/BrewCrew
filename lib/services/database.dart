import "package:cloud_firestore/cloud_firestore.dart";
import 'package:brew_crew/models/brew.dart';
import "package:brew_crew/models/user.dart";

class DatabaseService
{
  final String uid;
  DatabaseService({this.uid});//constructor of this class to get the user id to create a collection document
  //the uid will be the same as FireAuth's user id as they will be linked this way
  //collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('brews');//creates a collection(database)
  //if the collection doesnt exist firestore will create it for us

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.document(uid).setData({ ///input is like a map
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  //brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot)
  {
    return snapshot.documents.map((doc){ //map method cycles through the list of documents in the firestore
      return Brew(
        name: doc.data['name'] ?? '',
        strength: doc.data['strength'] ?? 0,
        sugars: doc.data['sugars'] ?? ''
      );
    }).toList();//this will not return a list but an iterable
  }

  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot)
  {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength'],
    );
  }


  //get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots()
      .map(_brewListFromSnapshot);
  }

  //get user doc stream ; listening for data inside a particular document of the user
  Stream<UserData>get userData {
    return brewCollection.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }


}