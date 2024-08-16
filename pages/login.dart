import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kilimoapp/pages/bottomnav.dart';
import 'package:kilimoapp/pages/forgotpassword.dart';
import 'package:kilimoapp/pages/signup.dart';
//import 'package:kilimoapp/widget/content_model.dart';
import 'package:kilimoapp/widget/widget_support.dart';


class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

String email="", password="";

final _formkey = GlobalKey<FormState>();

TextEditingController useremailcontroller= new TextEditingController();
TextEditingController userpasswordcontroller= new TextEditingController();

userLogin()async{
  try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomNav()));//
  }on FirebaseAuthException catch(e){
    if(e.code=='user-not-found'){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar
        (content: Text("No User Found for that Email",
        style: TextStyle(fontSize: 18.0, color: Colors.black),),));
    } else if(e.code=='wrong-password'){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar
  (content: Text("No User Found for that Email",
  style: TextStyle(fontSize: 18.0, color: Colors.black),),));
    }
    else if(e.code=='wrong-password'){
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
  "Wrong Password Provided by user",
  style: TextStyle(fontSize: 18.0, color: Colors.black),
)));
    }

  }
}
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children:[
            Container(// linear gradient helps to join two mixed colors
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/2.5,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                      end: Alignment.bottomRight,
                      colors: [
                Color(0xFFff5c30),
                Color(0xFFff5c30),
              ]) ),
            ),
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/3),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30), topRight: Radius.circular(30))),
              child: Text(""),
              ),
         Container(
           margin: const EdgeInsets.only(top: 100.0, left:20.0, right: 20.0),
           child: Column(children: [
            Center(
        child: Image.asset("images/logo.png",
            width: MediaQuery.of(context).size.width/1.5, fit: BoxFit.cover,),
            ),
             const SizedBox(height: 50.0,),
             Material(
         elevation: 5.0,
           borderRadius: BorderRadius.circular(20),
         child: Container(
           padding: EdgeInsets.only(left: 20.0, right: 20.0),
           width: MediaQuery.of(context).size.width,
           height: MediaQuery.of(context).size.height/2,
           decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
           child: Form(
             key: _formkey,
             child: Column(
               children: [
               const SizedBox(height: 30.0,),
               Text(
                 "Login",
                 style: Appwidget.semiBooldTextFeildStyle(),),
              SizedBox(height: 30.0,),
               TextFormField(
                   controller: useremailcontroller,
                   validator: (value){
                     if(value==null || value.isEmpty){
                       return 'Please Enter Email';
                     }
                     return null;//if you don't want to show anything in validation section you have to pass "null"
                   },
             decoration:InputDecoration(
                      hintText: 'Email',
                      hintStyle:Appwidget.semiBooldTextFeildStyle(),
               prefixIcon: const Icon(Icons.email_outlined)),
               ),
               const SizedBox(height: 30.0,),
               TextFormField(
                 controller: userpasswordcontroller,//
                 validator: (value){
                   if(value==null || value.isEmpty){
                     return 'Please Enter Password';
                   }
                   return null;
                 },
//When obscureText is set to true, the characters entered in the text field are replaced by a specified obscuring character (usually a dot or asterisk) to hide the actual text from being visible. This feature is commonly used to enhance security and privacy by masking sensitive information like passwords as they are being typed.
                  obscureText: true,
                 decoration:InputDecoration(
                     hintText: 'Password',
                     hintStyle:Appwidget.semiBooldTextFeildStyle(),
                     prefixIcon:  const Icon(Icons.password_outlined)),
               ),
               const SizedBox(height: 20.0,),
               GestureDetector(
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPassword()));
                 },
                 child: Container(
                   alignment: Alignment.topRight,
                     child: Text("Forgot Password?", style: Appwidget.semiBooldTextFeildStyle(),)),
               ),
               const SizedBox(height: 80.0,),
               GestureDetector(
                 onTap: (){
                   if(_formkey.currentState!.validate()){
                     setState(() {
                       email=useremailcontroller.text;
                       password=userpasswordcontroller.text;
                     });
                   }
                   userLogin();
                 },
                 child: Material(
                   elevation: 5.0,
                     borderRadius: BorderRadius.circular(20),
                   child: Container(
                         padding: const EdgeInsets.symmetric(vertical: 8.0),
                         width: 150,
                         decoration: BoxDecoration(color: const Color(0xffff5722),borderRadius: BorderRadius.circular(20)),
                         child: const Center(child: Text("LOGIN", style:TextStyle(color:Colors.white, fontSize: 18.0, fontFamily:'Poppins1',fontWeight: FontWeight.bold))),
                       ),
                 ),
               )
             ],),
           ),
         ),
             ),
             const SizedBox(height: 50.0,),
             GestureDetector(
           onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=> Signup()));
           },
           child: Text("Dont have an account? Sign up", style: Appwidget.semiBooldTextFeildStyle(),))
             
             
           ],),
         )
        
        ],),),
      ),
    );
  }
}
