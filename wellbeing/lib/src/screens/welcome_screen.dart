import 'package:flutter/material.dart';

import '../../widgets/customized_button.dart';
import 'login_screen.dart';
//import 'package:flutter_application_1/screens/login_screen.dart';
//import 'package:flutter_application_1/screens/signup_screen.dart';
//import 'package:flutter_application_1/widgets/customized_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        //background image


        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/background.png"))
        ),


        // register or login


        child: Padding(
          padding: const EdgeInsets.fromLTRB(30,10,30,60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,

            children: [

              CustomizedButton(

                buttonText: "Login",
                buttonColor: Colors.black,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => loginscreen()));
                },
              ),



            ],
          ),
        ),

      ),
    );
  }
}