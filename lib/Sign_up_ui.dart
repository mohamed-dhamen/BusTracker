import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Sign_up extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Sign_upState();
}

class Sign_upState extends State {
  int radioValue = 0;
  final _auth = FirebaseAuth.instance;
  bool showProgress = false;

  TextEditingController RemailController = TextEditingController();
  TextEditingController RpasswwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("BusTracking"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 50, left: 20, right: 10),
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/bus.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5, left: 20, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome To ",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 26,
                          color: Colors.amber,
                        )),
                    Text("City Bus",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.black87,
                        )),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 50, left: 20, right: 20),
                  child: TextField(
                    controller: RemailController,
                    autocorrect: true,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Email Here...',
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.amber,
                      ),
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                  )),
              Container(
                  margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: TextField(
                    controller: RpasswwordController,
                    autocorrect: true,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Password Here...',
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.green,
                      ),
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                  )),
              Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const Text("Admin",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue)),
                            Radio(
                                value: 0,
                                groupValue: radioValue,
                                onChanged: (val) {
                                  _handleRadioValueChange(val as int);
                                }),
                            const Text(
                              "user",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            Radio(
                                value: 1,
                                groupValue: radioValue,
                                onChanged: (val) {
                                  _handleRadioValueChange(val as int);
                                }),
                          ],
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          height: 50,
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ElevatedButton(
                            child: const Text(
                              'Register',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            onPressed: () {
                              registerwithEmailPassword(
                                  RemailController.text.toString(),
                                  RpasswwordController.text.toString());
                            },
                          )),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const Text("already Sign up",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w700)),
                            const Spacer(),
                            const Text("Sign In !",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      radioValue = value;

      switch (radioValue) {
        case 0:
          break;
        case 1:
          break;
      }
    });
  }

  void registerwithEmailPassword(String email, String password) async {
    if (email != null && password != null) {
      try {
        final newuser = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        if (newuser != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
          setState(() {
            showProgress = false;
          });
        }
      } catch (e) {}
    }
  }
}
