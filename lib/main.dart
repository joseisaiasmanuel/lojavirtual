import 'package:flutter/material.dart';
import 'package:loja_virtual/screen/screen_home.dart';
import 'package:loja_virtual/screen/login_screen.dart';
import 'package:loja_virtual/screen/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

import 'models/user_model.dart';


void main()=> runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   return ScopedModel<UserModel>(
     model: UserModel(),
     child:MaterialApp(
     title: "Flutter'S Clothing",
     theme: ThemeData(
         primarySwatch: Colors.blue,
         primaryColor: Color.fromARGB(255, 4, 125, 141)

     ),
     debugShowCheckedModeBanner: false,
     home: HomeScreen(),

   )
   );
  }
}



