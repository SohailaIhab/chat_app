import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';



class SignupPage extends StatefulWidget {
 SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
static String? _mail;
static String? password;
bool loading=false;

  @override
  void initState() { }
  
  final _formKey = GlobalKey<FormState>();
  final TextEditingController myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loading,
      child: Form(
        key: _formKey,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:Center(
               child: Container(
                width: 300,
                child: SingleChildScrollView(
                  child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                             const Text(
                    "SIGN UP",
                    style: TextStyle(
                      color: Color.fromRGBO(4,164,156,3),
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                            const  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: myController,
                    validator: (name) {
                      if (name != null && name.isEmpty != true) {
                        return null;
                      }
                      return "Not valied";
                    },
                    decoration:const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Name"),
                    ),
                  ),
                             const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: (mail) {
                      _mail=mail.toString().trim();
                      if (_mail != null &&
                          _mail!.isEmpty != true &&
                          _mail!.contains("@") &&
                          _mail!.contains(".com")) {
                        return null;
                      }
                      return 'Invalid Email';
                    },
                    decoration:const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email",
                    ),
                  ),
                             const SizedBox(
                    height: 15,
                  ),
                  TextFormField(obscureText :true,
                    validator: (pass) {
                      password=pass.toString().trim();
                      if (password != null && password!.length > 7) {
                        return null;
                      }
                      return "Weak";
                    },
                    decoration:const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Password",
                
                    ),
                  ),
                            const  SizedBox(
                    height: 15,
                  ), TextFormField(obscureText :true,
                    validator: (ConfirmPassword) {
                      if (ConfirmPassword == password) {
                        return null;
                      }
                      return "You Should Enter The Same Password";
                    },
                    decoration:const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Confirm Password",
                
                    ),
                  ),
                            const  SizedBox(
                    height: 15,
                  ),
                          ElevatedButton(  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(4,164,156,3),
                    ),
                           onPressed: () async{ 
                          if (_formKey.currentState!.validate()){
                            loading=true;
                            setState(() {
                              
                            });
                          try{ 
                          await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _mail!,password: password!);
                     
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Account Created Successfully')));
                
                    }on FirebaseAuthException catch(ex){
                     if(ex.code=='email-already-in-use'){
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('This email already exists')));
                     }
                      }}loading=false;
                  
                   
                   setState(() {
                      });
                    },
                    
                    
                    child:const Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                            const  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     const Text("Already Have an Account? "),
                     TextButton(
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                        child: const Text("Log in"),
                      )
                    ],
                  ),
                            ],
                          ),
                ),
          ),
        ),
        ))),
    );
  }
}
