import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screen/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';


class LoginScreen extends StatelessWidget {
  final  _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Entrar"),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
                child: Text(
                  "CRIAR CONTA",
                  style: TextStyle(fontSize: 15.0),
                ),
                textColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>SignUpScreen()));
                })
          ],
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context,child,model){
            if(model.isLoading)
              return Center(child: CircularProgressIndicator(),);
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: "E-mail"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text){
                      if(text.isEmpty || !text.contains("@")) return "E-mail Inválido";
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Senha"),
                    obscureText: true,
                    validator: (text){
                      if(text.isEmpty || text.length<6) return"A senha deve conter 6 caracter";
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () {},
                      child:
                      Text("Esqueci minha senha", textAlign: TextAlign.right),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    height: 44.0,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: 44,
                      child: RaisedButton(
                        child: Text(
                          "Entrar",
                          style: TextStyle(fontSize: 18),
                        ),
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {}
                        },
                      ),
                    ),
                  )

                ],
              ),
            );
          },
        )
    );
  }
}
