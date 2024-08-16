

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kilimoapp/admin/admin_login.dart';
import 'package:kilimoapp/farmerdata/login_screen.dart';
import 'package:kilimoapp/pages/login.dart';
import 'package:kilimoapp/pages/bottomnav.dart';
import 'package:kilimoapp/widget/widget_support.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../farmers/farmersdisplay.dart';
import 'info/database.dart';
import 'info/shared_pref.dart';

 class Signup extends StatefulWidget {
   const Signup({super.key});

   @override
   State<Signup> createState() => _SignUpState();
 }
//THE PROJECT HAS ENDED AT 15:43 HOURS
 class _SignUpState extends State<Signup> {

   String email = "",
       password = "",
       name = "";

   TextEditingController namecontroller = new TextEditingController();

   TextEditingController passwordcontroller = new TextEditingController();

   TextEditingController mailcontroller = new TextEditingController();

   final _formkey = GlobalKey<FormState>();

   registration() async {
     if (password != null) {
       try {
         UserCredential userCredential = await FirebaseAuth.instance
             .createUserWithEmailAndPassword(email: email, password: password);

         ScaffoldMessenger.of(context).showSnackBar((const SnackBar(
             backgroundColor: Colors.redAccent,
             content: Text(
               "Registered Succesfuly", style: TextStyle(fontSize: 20.0),))));
         //helps to show detail of customer on the firebase
         String Id = randomAlphaNumeric(10);
         Map<String, dynamic > addUserInfo={
       "Name":namecontroller.text,
       "Email":mailcontroller.text,
       "Id": Id,
     };
         await DatabaseMethods().addUserDetail(addUserInfo, Id);
         await SharedPreferenceHelper().saveUserName(namecontroller.text);
         await SharedPreferenceHelper().saveUserEmail(mailcontroller.text);
         await SharedPreferenceHelper().saveUserId(Id);

         Navigator.pushReplacement(
             context, MaterialPageRoute(builder: (context) => BottomNav()));
       } on FirebaseException catch (e) {
         if (e.code == 'weak-password') {
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
               backgroundColor: Colors.orangeAccent,
               content: Text("Password Provided is too weak",
                 style: TextStyle(fontSize: 18.0),)));
         }

         else if (e.code == "email-already-in-use") {
           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
             backgroundColor: Colors.orangeAccent,
             content: Text(
               "Account Already exists", style: TextStyle(fontSize: 18.0),),));
         }
       }catch(e){
         log("Exception captured ${e.toString()}",name:"ERROR iN LOGIN");
     }
     }
   }
     @override
     Widget build(BuildContext context) {
       return Scaffold(
           body: SingleChildScrollView(
           child: Stack(
             children: [
               Container( // linear gradient helps to join two mixed colors
                 width: MediaQuery
                     .of(context)
                     .size
                     .width,
                 height: MediaQuery
                     .of(context)
                     .size
                     .height / 2.5,
                 decoration: const BoxDecoration(
                     gradient: LinearGradient(
                         begin: Alignment.bottomLeft,
                         end: Alignment.bottomRight,
                         colors: [
                           Color(0xFFff5c30),
                           Color(0xFFff5c30),
                         ])),
               ),
               Container(
                 margin: EdgeInsets.only(top: MediaQuery
                     .of(context)
                     .size
                     .height / 3),
                 height: MediaQuery
                     .of(context)
                     .size
                     .height,
                 width: MediaQuery
                     .of(context)
                     .size
                     .width,
                 decoration: const BoxDecoration(
                     color: Colors.white, borderRadius: BorderRadius.only(
                     topLeft: Radius.circular(30),
                     topRight: Radius.circular(30))),
                 child: const Text(""),
               ),
               Container(
                 margin: const EdgeInsets.only(
                     top: 60.0, left: 20.0, right: 20.0),
                 child: Column(children: [
                   Center(
                     child: Image.asset("images/logo.png",
                       width: MediaQuery
                           .of(context)
                           .size
                           .width / 1.5, fit: BoxFit.cover,),
                   ),
                   const SizedBox(height: 30.0,),
                   Material(
                     elevation: 5.0,
                     borderRadius: BorderRadius.circular(20),
                     child: Container(
                       padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                       width: MediaQuery
                           .of(context)
                           .size
                           .width,
                       decoration: BoxDecoration(color: Colors.white,
                           borderRadius: BorderRadius.circular(20)),
                       child: Form(
                         key:_formkey,
                         child: Column(children: [
                           const SizedBox(height: 30.0,),
                           Text("Signup",
                             style: Appwidget.semiBooldTextFeildStyle(),),
                           TextFormField(
                             controller: namecontroller,
                             validator: (value){
                               if (value==null|| value.isEmpty){
                                 return 'Please Enter Name';
                               }
                               return null;
                             },
                             decoration: InputDecoration(
                                 hintText: 'Name',
                                 hintStyle: Appwidget.semiBooldTextFeildStyle(),
                                 prefixIcon: const Icon(Icons.person_outlined)),
                           ),
                           const SizedBox(height: 30.0,),
                           TextFormField(
                             controller: mailcontroller,
                             validator: (value){
                               if (value==null|| value.isEmpty){
                                 return 'Please Enter E-mail';
                               }
                               return null;
                             },

                             decoration: InputDecoration(
                                 hintText: 'Email',
                                 hintStyle: Appwidget.semiBooldTextFeildStyle(),
                                 prefixIcon: const Icon(Icons.email_outlined)),
                           ),

                           const SizedBox(height: 50.0,),
                           TextFormField(
                             controller: passwordcontroller,
                             validator: (value){
                               if (value==null|| value.isEmpty){
                                 return 'Please Enter Password';
                               }
                               return null;
                             },

                             obscureText: true,
                             decoration: InputDecoration(
                                 hintText: 'Password',
                                 hintStyle: Appwidget.semiBooldTextFeildStyle(),
                                 prefixIcon: const Icon(Icons.password_outlined)),
                           ),

                           const SizedBox(height: 50.0,),// its repeated codded 15:39
                         GestureDetector(
                           onTap: ()async{
                             if(_formkey.currentState!.validate()){
                               setState(() {
                                 email= mailcontroller.text;
                                 name= namecontroller.text;
                                 password= passwordcontroller.text;
                               });
                             }
                             registration();
                           },
                           child: Material(
                                 elevation: 5.0,
                                 borderRadius: BorderRadius.circular(20),
                                 child: Container(
                                   padding: const EdgeInsets.symmetric(vertical:8.0),
                                   width: 200,
                                   decoration: BoxDecoration(
                                       color: const Color(0xffff5722),
                                       borderRadius: BorderRadius.circular(20)),
                                   child: const Center(
                                     child: Text(
                                       "SignUp",
                                       style: TextStyle(
                                         color: Colors.white,
                                         fontSize: 18.0,
                                         fontFamily: 'Poppins1',
                                         fontWeight: FontWeight.bold),
                                       ),
                                     ),
                                   ),
                                 ),
                         ),
                         ],),
                       ),
                     ),
                   ),
       //             const SizedBox(height: 30.0,),
       //             GestureDetector(
       //                 onTap: () {
       //                   Navigator.push(context, MaterialPageRoute(builder: (
       //                       context) => const LogIn()));
       //                 },
       //                 child: Text("Already have a Customer Login?",
       //                   style: Appwidget.semiBooldTextFeildStyle(),)),



       // //The OTP HAS BEEN CANCELLED DUE TO END OF FREE TIME
       //     const SizedBox(height: 30.0),
       // Center(
       // child: ElevatedButton(
       // onPressed: () {
       //   Navigator.push(context, MaterialPageRoute(builder: (
       //       context) => const LoginScreen()));
       // },
       // child: Text("Register for Farmer Only",
       // style: TextStyle(
       // color: Colors.blue,
       // fontSize: 20.0,
       // fontWeight: FontWeight.bold))),
       //
       // ),
                   const SizedBox(height: 20.0,),
                   GestureDetector(
                       onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (
                             context) => const LogIn()));
                       },
                       child: Text("Already have farmer Login account?",
                         style: Appwidget.semiBooldTextFeildStyle(),)),
                   const SizedBox(height: 20.0),
                   Center(
                     child: ElevatedButton(
                         onPressed: () {
                           Navigator.push(context, MaterialPageRoute(builder: (
                               context) => const AdminLogin()));

                         },
                         child: Text("Admin Only",
                             style: TextStyle(
                                 color: Colors.blue,
                                 fontSize: 20.0,
                                 fontWeight: FontWeight.bold))),

                   ),
                   const SizedBox(height: 20.0),
                   Center(
                     child: ElevatedButton(
                         onPressed: () {
                           Navigator.push(context, MaterialPageRoute(builder: (
                               context) => const Farmersdisplay()));

                         },
                         child: Text("CRUD FOR FARMERS",
                             style: TextStyle(
                                 color: Colors.blue,
                                 fontSize: 20.0,
                                 fontWeight: FontWeight.bold))),

                   ),


                 ],),
               ),


             ],),
         )
       );
     }
   }
