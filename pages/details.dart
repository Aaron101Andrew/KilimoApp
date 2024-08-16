import 'package:flutter/material.dart';
import 'package:kilimoapp/pages/info/database.dart';
import 'package:kilimoapp/pages/info/shared_pref.dart';
import 'package:kilimoapp/pages/order.dart';
import 'package:kilimoapp/widget/widget_support.dart';
//import 'package:cloud_firestore/cloud_firestore.dart;

class Details extends StatefulWidget {
   String image, name, detail,price;

   Details({required this.detail, required this.image, required this.name, required this.price,});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int a=1; int total=0;
  String? id;

  //to get user id
  getthesharedpref()async{
    id= await SharedPreferenceHelper().getUserId();
    setState(() {

    });
  }

 ontheload()async{
    await getthesharedpref(); // is called to support widget gestthesharedpref
   setState(() {

   });
 }

  @override
  void initState(){
    super.initState();
    ontheload();
    total=int.parse(widget.price);
  }

  @override // after adding this file we go back at "home.dart" to add
  // gesture detector
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
GestureDetector(
  onTap: (){
    Navigator.pop(context);
  },
  child: const Icon(Icons.arrow_back_ios_new_outlined,
    color: Colors.black,),
),

//Image.network is been used to get image from the metwork
            Image.network(
              widget.image, width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/2.5, fit: BoxFit.fill,),
          const SizedBox(height: 15.0,),
            Row(
              children:[
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(widget.name,
                 style: Appwidget.semiBooldTextFeildStyle(),),
               ],
           ),
                const Spacer(),
                GestureDetector(
                  onTap: (){
                    if(a>1) {// condition helps the number not decrees to 0
                      --a;
                      total=total-int.parse(widget.price);
                    }
                    setState(() {

                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black,
                        borderRadius: BorderRadius.circular(8)),
                    child:const Icon(Icons.remove, color:Colors.white,),
                  ),
                ),
                const SizedBox(width: 20.0,),
                Text(a.toString(), style: Appwidget.semiBooldTextFeildStyle(),),
                const SizedBox(width: 20.0,),
                GestureDetector(
                  onTap: (){
                    ++a;
                    total=total+int.parse(widget.price);
                        setState(() {

                        });
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black,
                        borderRadius: BorderRadius.circular(8)),
                    child:const Icon(Icons.add, color:Colors.white,),
                  ),
                ),
         ],),
            const SizedBox(height: 20.0,),
             Text(
             widget.detail, maxLines: 4,
           style: Appwidget.LightTextFeildStyle(),
            ),
            Row(children: [
              Text("Delivery Time",
              style: Appwidget.semiBooldTextFeildStyle(),),
              const SizedBox(width: 25.0,),
              const Icon(Icons.alarm, color:Colors.black54,),
              const SizedBox(width: 5.0,),
              Text("30mins", style: Appwidget.semiBooldTextFeildStyle(),)
            ],),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom:40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total price", style: Appwidget.semiBooldTextFeildStyle(),),
                      Text("\Tshs"+total.toString(), style: Appwidget.HeadlineTextFeildStyle(),),
                    ],),
                  GestureDetector(
                    onTap: () async{
                      Map<String, dynamic> addFoodCart={
                        "Name":widget.name,
                        "Quantity":a.toString(),
                        "Total":total.toString(),
                        "Image":widget.image
                      };
                      await DatabaseMethods().addFoodToCart(addFoodCart, id!);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.orangeAccent,
                          content: Text(
                            "Food added to cart",
                            style: TextStyle(fontSize: 18.0),)));

                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width/2,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                        child:Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                         Text("Add to  Cart", style: TextStyle(color: Colors.white, fontSize: 16.0,
                        fontFamily: 'Poppins',),),
                        const SizedBox(width: 30.0,),
                          Container(
                          padding: const EdgeInsets.all(3),
                        decoration:  BoxDecoration(
                          color: Colors.grey, borderRadius: BorderRadius.circular(8)
                        ),
                          child: const Icon(Icons.shopping_cart_outlined,
                              color: Colors.white),
                        ),
                          const SizedBox(width: 10.0,)
                      ],)
                    ),
                  )
                ],
              ),
            )
          ],
        ),),
      ),
    );
  }
}
