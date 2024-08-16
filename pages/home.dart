import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kilimoapp/pages/info/database.dart';

import '../widget/widget_support.dart';
import 'details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool icecream=false, pizza=false, salad=false, burger=false;

  //"stream" helps to get all the data from the firestore database; the databse was been setted up on the "database.dart" file
  Stream? fooditemStream;

  ontheload()async{
   fooditemStream = await DatabaseMethods().getFoodItem("Rice");
   setState(() {

   });
  }

  @override
  void initState(){
    ontheload();
    super.initState();
  }

  Widget allItemsVertically(){

    return StreamBuilder(
        stream: fooditemStream,
        builder: (context, AsyncSnapshot snapshot){
          return snapshot.hasData
              ? ListView.builder(
              padding: EdgeInsets.zero,
              // itemCount: 1,
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,//help to scroll in direction given
              itemBuilder: (context, index){
                DocumentSnapshot ds=snapshot.data.docs[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=> Details(
                          detail: ds["Detail"], name: ds["Name"],
                          price:ds["Price"], image: ds["Image"],
                        )));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 20.0, bottom: 20.0,),
                    child: Material(
                      elevation:5.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                ds["Image"], //"ds" helps on getting in the network
                                height: 120, width: 120,
                                fit: BoxFit.cover,),
                            ),
                            Text(ds["Name"],
                              style: Appwidget.boldTextFeildStyle(),),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text("Fresh and Healthy",
                              style: Appwidget.LightTextFeildStyle(),),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              "\Tshs"+ds["Price"],
                              style: Appwidget.semiBooldTextFeildStyle(),
                            )
                          ],),
                      ),
                    ),
                  ),
                );
              }): const CircularProgressIndicator();
        });
  }


  Widget allItems(){
//stream builder helps to get all the image from the database(firebase),
    return StreamBuilder(
        stream: fooditemStream,
        builder: (context, AsyncSnapshot snapshot){
return snapshot.hasData
    ? ListView.builder(
  padding: EdgeInsets.zero,
    // itemCount: 1,
    itemCount: snapshot.data.docs.length,
    shrinkWrap: true,
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index){
DocumentSnapshot ds=snapshot.data.docs[index];//to get the index of the document
return GestureDetector(
  onTap: (){
    Navigator.push(context, MaterialPageRoute(
        builder: (context)=> Details(
          detail: ds["Detail"], name: ds["Name"],
          price:ds["Price"], image: ds["Image"],
        )));
  },
  child: Container(
    margin: const EdgeInsets.only(right: 20.0, bottom: 20.0),
    child: Material(
      elevation:5.0,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                ds["Image"], //"ds" helps on getting in the network
                height: 150, width: 150,
                fit: BoxFit.cover,),
            ),
            Text(ds["Name"],
              style: Appwidget.boldTextFeildStyle(),),
            const SizedBox(
              height: 5.0,
            ),
            Text("Fresh and Healthy",
              style: Appwidget.LightTextFeildStyle(),),
            const SizedBox(
              height: 5.0,
            ),
             Text(
              "\Tshs"+ds["Price"],
              style: Appwidget.semiBooldTextFeildStyle(),
            )
          ],),
      ),
    ),
  ),
);
}): const CircularProgressIndicator();
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50.0, left: 20.0,),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text(
                  "Hello Client",
                  style: Appwidget.boldTextFeildStyle()
               ),
               Container(
                 margin: const EdgeInsets.only(left: 20.0),
                 padding: const EdgeInsets.all(3),
                 decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
                 child: const Icon(Icons.shopping_cart_outlined, color:Colors.white,),
               )
             ],
           ),
            const SizedBox(height: 30.0,),
            Text(
                "Market Service",
                style: Appwidget.HeadlineTextFeildStyle()
            ),
            Text(
                  "Buy direct from the farmers",
                style: Appwidget.LightTextFeildStyle()
            ),
            const SizedBox(height: 20.0,),
           Container(
             margin:const EdgeInsets.only(right: 20.0),
               child: showItem()),

              const SizedBox(height: 30.0,),

              Container(
                height: 280,
                child: allItems() ),

            allItemsVertically(),
             // allItems(),
            ],),
        ),
      ) ,
    );
  }

  Widget showItem(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async{
            icecream=true;
            pizza=false;
            salad=false;
            burger=false;
            fooditemStream= await DatabaseMethods().getFoodItem("Rice");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: icecream?
                  Colors.black: Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(8),
              child: Image.asset("images/ice-cream.png", //"color: pizza?Colors.white: Colors.black" was removed so as the image should be seen cleared
                  height: 40, width:40, fit: BoxFit.cover, ),),
          ),
        ),
        GestureDetector(
          onTap: () async{
            icecream=false;
            pizza=true;
            salad=false;
            burger=false;
            fooditemStream= await DatabaseMethods().getFoodItem("Wheat");
            setState(() { });
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: pizza?
                  Colors.black: Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(8),
              child: Image.asset("images/pizza.png",
                  height: 40, width:40, fit: BoxFit.cover,
                  //"color: pizza?Colors.white: Colors.black" was removed so as the image should be seen cleared
              ),),
          ),
        ),
        GestureDetector(
          onTap: () async{
            icecream=false;
            pizza=false;
            salad=true;
            burger=false;
            fooditemStream= await DatabaseMethods().getFoodItem("Maize");
            setState(() { });
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: salad?
                  Colors.black: Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(8),
              child: Image.asset("images/salad.png",
                  height: 40, width:40, fit: BoxFit.cover,
                  //"color: pizza?Colors.white: Colors.black" was removed so as the image should be seen cleared
                  ),),
          ),
        ),
        GestureDetector(
          onTap: () async{
            icecream=false;
            pizza=false;
            salad=false;
            burger=true;
            fooditemStream= await DatabaseMethods().getFoodItem("Other");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: burger?
                  Colors.black: Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(8),
              child: Image.asset("images/burger.png",
                  height: 40, width:40, fit: BoxFit.cover,
              ),),
          ),
        ),

      ],
    );
  }
}
