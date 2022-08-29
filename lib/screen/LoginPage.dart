import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sush_bank/abonnes.dart';
import 'package:sush_bank/home/HomePage.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  Abonnes abonnes = Abonnes("", "");
  String url = "http://localhost:8080/login";

  Future save() async {
    var res = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'login': abonnes.user_name, 'password': abonnes.user_password}));
    print(res.body);
    if (res.body != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: new Text("CONNEXION"),
      ),
      body: Padding(

          key: _formKey,

          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Image.asset(
                'images/banklogo.png',
                width: 500,
                height: 300,
                fit: BoxFit.fill,
              ),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Bienvenue !',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Connectez-vous pour continuer !',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(

                  obscureText: true,
                  controller: TextEditingController(text: abonnes.user_name),
                  /*onChanged: (val) {
                    abonnes.login = val;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Code client vide';
                    }
                    return null;
                  },*/
                  
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Code client',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: TextEditingController(text: abonnes.user_password),
                  /*onChanged: (val) {
                    abonnes.password = val;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Code secret vide';
                    }
                    return null;
                  },*/

                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Code secret',
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  //forgot password screen
                },
                textColor: Colors.blue,
                child: Text('Code secret oublié'),
              ),
              Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.green,
                    child: Text('SE CONNECTER'),
                    onPressed: () {

                      if (_formKey.currentState.validate()) {
                        save();
                        new MaterialPageRoute(
                              builder: (context) => new HomePage());
                      }

                      /*Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new HomePage()));
                      print(nameController.text);
                      print(passwordController.text);*/
                    },
                  )),
            ],
          )),
    );
  }
}
