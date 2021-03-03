import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> userData= Map();
  bool isLoading= false ;
 // login

  void signUp({@required Map<String, dynamic> userData, @required String pass,@required VoidCallback onSuccess, @required VoidCallback onFail}) {
    isLoading =true;
    notifyListeners();
    _auth.createUserWithEmailAndPassword(email: userData["email"], password: pass).then(
            (user)  async{
              firebaseUser= user;
              await _saveUserData(userData);
              onSuccess();
              isLoading= false;
              notifyListeners();
            }).catchError((e){
            onFail();
            isLoading= false;
            notifyListeners();
    });



  }


  // cadatro
void signIn() async{
    isLoading=true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 3));

    isLoading= false;
    notifyListeners();

}


  // recuperar senha
void recoverPass(){

}

Future<Null> _saveUserData(Map<String,dynamic> userData) async{
    this.userData= userData;
    await Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData);
}

  // usuarioa logado
void isLoginIn(){

}




}