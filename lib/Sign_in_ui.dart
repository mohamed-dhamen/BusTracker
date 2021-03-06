import 'dart:collection';
import 'package:bustracker/Model/StationsInfo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Sign_up_ui.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BusTracking",
      theme: ThemeData(primaryColor: Colors.blue),
      home: SignIn(),
    );
  }
}

class SignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SignInState();
}

class SignInState extends State {
  final _auth = FirebaseAuth.instance;
  bool showProgress = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StationInfoModel.getStationData();
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
                    controller: emailController,
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
                    controller: passwwordController,
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
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                  onPressed: () {
                    loginWithEmailPassword(emailController.text.toString(),
                        passwwordController.text.toString());
                    print(emailController.text.toString());
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    width: double.infinity,
                    child: Text("Sign in",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Row(
                  children: [
                    const Text("Forget ?",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                            fontWeight: FontWeight.w700)),
                    const Spacer(),
                    const Text("new user  ",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        onSurface: Colors.transparent,
                        shadowColor: Colors.transparent,
                        //make color or elevated button transparent
                      ),
                      onPressed: () {
                        print("Email :" + emailController.text.toString());
                        print(
                            "Password :" + passwwordController.text.toString());
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Sign_up()));
                      },
                      child: const Text("Sign up",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.green,
                              fontWeight: FontWeight.w700)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void loginWithEmailPassword(String email, String password) async {
    try {
      final newUser = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(newUser.toString());
      if (newUser != null) {
        print('Login with Sucess');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
        emailController.clear();
        passwwordController.clear();
      } else {
        print('somthing wrang');
      }
    } catch (e) {}
  }
}
