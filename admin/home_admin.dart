import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kilimoapp/admin/add_food.dart';
import 'package:kilimoapp/widget/widget_support.dart';
class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50.0, left:20.0, right: 20.0),
     child: Column(
       children: [
         Center(child: Text("Home Admin", style: Appwidget.HeadlineTextFeildStyle(),),),
        SizedBox(height: 50.0,),
         GestureDetector(
           onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddFood()));
           },
           child: Material(
            elevation: 10.0,
            borderRadius: BorderRadius.circular(10),
            child: Center(
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white, // is the color for choice of categories
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(children: [
                  Padding(padding: EdgeInsets.all(6.0),
                  child: Image.asset("images/food.jpg", height: 100, width: 100, fit:BoxFit.cover ,),),
                SizedBox(width: 30.0,),
                  Text("Add Food Items", style: TextStyle(color: Colors.black, fontSize: 20.0,
                      fontWeight: FontWeight.bold),)
                ],),
              ),
            ),

                   ),
         )
       ],
     ),
    );
  }
}
