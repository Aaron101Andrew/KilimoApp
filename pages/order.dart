import 'dart:async';

//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:kilimoapp/pages/info/database.dart';

//import 'package:kilimoapp/farmers/service/database.dart';
//import 'package:kilimoapp/pages/details.dart';
import 'package:kilimoapp/pages/info/shared_pref.dart';
import 'package:kilimoapp/widget/widget_support.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String? id;
  int total = 0;

  void startTimer() {
    Timer(Duration(seconds: 3), () {
      setState(() {


      });
    });
  }

  getthesharedpref() async {
    id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    foodStream = await DatabaseMethods().getFoodCart(id!);
    setState(() {});//is a specific user Id
  }

  @override
  void initState() {
    ontheload();
    startTimer();
    super.initState();
  }

  Stream? foodStream;

  Widget foodCart() {
    return StreamBuilder(
        stream: foodStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  // itemCount: 1,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  //help to scroll in direction given
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    total = total + int.parse(ds["Total"]);
                    return Container(
                      margin: EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 10.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Container(
                                height: 90,
                                width: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(child: Text(ds["Quantity"])),
                              ),
                              SizedBox(width: 20.0),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: Image.network(
                                    ds["Image"],
                                    height: 90,
                                    width: 90,
                                    fit: BoxFit.cover,
                                  )),
                              SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                // helps to put the text on the left side.
                                children: [
                                  Text(
                                    ds["Name"],
                                    style: Appwidget.semiBooldTextFeildStyle(),
                                  ),
                                  Text(
                                    "\Tshs" + ds["Total"],
                                    style: Appwidget.semiBooldTextFeildStyle(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : const CircularProgressIndicator();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
                elevation: 2.0,
                child: Container(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Center(
                        child: Text(
                      "Food Cart",
                      style: Appwidget.HeadlineTextFeildStyle(),
                    )))),
            SizedBox(
              height: 20.0,
            ),
            Container(
                height: MediaQuery.of(context).size.height / 2,
                child: foodCart()),
            Spacer(),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Price",
                    style: Appwidget.boldTextFeildStyle(),
                  ),
                  Text(
                    "\Tshs" + total.toString(),
                    style: Appwidget.boldTextFeildStyle(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
              margin:
                  const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
              child: Center(
                  child: Text(
                "CheckOut",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
