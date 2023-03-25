import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_3/sign_up.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    // TODO: implement initState
  }
  var _formKey = GlobalKey<FormState>();
  static String? _mail;
  static String? password;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loading,
      child: Form(
          key: _formKey,
          child: Scaffold(
              body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Container(
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
                      "LOG IN",
                      style: TextStyle(
                        color: Color.fromRGBO(4,164,156,3),
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      validator: (mail) {
                        _mail = mail.toString().trim();

                        /* if (mail != null &&
                        mail.isEmpty != true &&
                        mail.contains("@") &&
                        mail.contains(".com")) {
                      return null;
                    }
                    return 'Error, Try again';*/
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: true,
                      validator: (pass) {
                        password = pass.toString().trim();
                        /* if (pass != null && pass.length > 7) {
                      return null;
                    }
                    return "Week";*/
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Password",
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(4,164,156,3)
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          loading = true;
                          setState(() {
                            
                          });
                          try {
                              
                              await  logIn();
                              Navigator.pushNamed(context, 'chat');
                                }

                                 on FirebaseAuthException catch (e) {
                                  if(e.code=='wrong-password'){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Wrong Password')));}
                                    else if(e.code=='user-not-found'){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('There is no user with that email, try to Register first')));
                                    }

                                 }loading=false;
                                 //Navigator.pushNamed(context, '/home');
                                 setState(() {
                                   
                                 });
                        }

                       
                      },
                      child: const Text(
                        "Log in",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("You don't have account ? "),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              Navigator.pushNamed(context, "signUp");
                            });
                          },
                          child: const Text("Sign Up"),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ))),
    );
  }

  Future logIn() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: _mail!, password: password!);
  }
}
