import 'dart:io';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/customized_button.dart';
import '../../widgets/customized_textfield.dart';
import '../app.dart';
import '../th.dart';
import 'forgot_password.dart';
/*
import 'package:flutter_application_1/screens/forgot_password.dart';
import 'package:flutter_application_1/screens/signup_screen.dart';
import 'package:flutter_application_1/widgets/customized_textfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_application_1/screens/Human ressources managerScreen.dart';
import 'package:flutter_application_1/screens/TherapistScreen.dart';

import 'package:flutter_application_1/auth/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
*/






//import '../services/firebase_auth_service.dart';
//import '../widgets/customized_button.dart';




class loginscreen extends StatefulWidget {
  loginscreen({Key? key}) : super(key: key);

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Future <void> __signInwithemailandpassword(BuildContext context) async {
    final FirebaseAuth _auth = FirebaseAuth.instance ;
    try {
      final String email = _emailController.text ;
      final String password = _passwordController.text ;
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password) ;


      var querysnapshot = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: _emailController.text).where('password', isEqualTo: _passwordController.text).limit(1).get();
      _emailController.clear();
      _passwordController.clear();


      if (querysnapshot.docs.isNotEmpty){
        Map<String,dynamic> data =querysnapshot.docs.first.data() ;
        String fieldvalue = data["role"];
        print(fieldvalue);
        switch (fieldvalue){
          case 'Human ressources manager' :
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => App(username: data["username"],role: fieldvalue,),));
            break ;
          case 'Therapist' :
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Th(username: data["username"],role: fieldvalue,)),);
            break ;

        }}}on FirebaseException catch (e) {
      debugPrint("error is ${e.message}");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Invalid username or password. Please register again or make sure that the username and password are correct."),

        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black,width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_sharp),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                ),

                //welcome back

                // ignore: prefer_const_constructors
                Center(
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(10,0,10,10),
                    child: Text("Welcome Back ! ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),

                //email && pswd
                const SizedBox(
                  height: 30,
                ),



                CustomizedTextfield(
                  myController: _emailController,
                  hintText: "Enter your Email",
                  isPassword: false,
                ),
                CustomizedTextfield(
                  myController: _passwordController,
                  hintText: "Enter your Password",
                  isPassword: true,
                ),

                // forgot pswd
                const SizedBox(
                  height: 7,
                ),

                Center(
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(260,8,30,0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ForgotPassword()));
                        },
                        child: const Text("Forgot Password?",
                            style: TextStyle(
                              color: Color(0xff6A707C),
                              fontSize: 15,
                            )),
                      ),
                    ),
                  ),
                ),

                //login
                const SizedBox(
                  height: 20,
                ),


                Center(
                  child: CustomizedButton(
                    buttonText: "Login",
                    buttonColor: Colors.black,
                    textColor: Colors.white,
                    onPressed: () async {
                      __signInwithemailandpassword(context);
                    },
                  ),
                ),


                const SizedBox(
                  height: 20,
                ),




                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.height * 0.15,
                        color: Colors.grey,
                      ),
                      const Text("Or Login with"),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.height * 0.18,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            FontAwesomeIcons.facebookF,
                            color: Colors.blue,
                          ),
                          onPressed: () {},
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),

                        child: IconButton(
                          icon: const Icon(
                            FontAwesomeIcons.google,

                          ),
                          onPressed: () {},




                        ),
                      ),
                    ),


                    Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            FontAwesomeIcons.apple,
                            // color: Colors.blue,
                          ),
                          onPressed: () {},
                        )
                    ),


                  ],

                ),





              ],
            ),
          ),
        ),
      ),
    );
  }
}

