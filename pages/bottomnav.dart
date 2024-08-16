import 'dart:developer';

import "package:curved_navigation_bar/curved_navigation_bar.dart";
import 'package:flutter/material.dart';
//import 'package:kilimoapp/pages/signup.dart';
import 'package:kilimoapp/pages/home.dart';
import 'package:kilimoapp/pages/order.dart';
import 'package:kilimoapp/pages/profile.dart';
import 'package:kilimoapp/pages/services_page.dart';
import 'package:kilimoapp/pages/financial_service.dart';


class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
 int currentTabIndex=0;

 late List<Widget> pages;
 late Widget currentpage;
 late Home homepage;
 late Profile profile;
 late Order order;
 late FinancialService financialService;
 late ServicesPage services;

  @override
  void initState(){
    homepage=const Home();
    order=const Order();
    profile=const Profile();
    financialService=const FinancialService();
    services= const ServicesPage();
    pages=[homepage,order,financialService,services, profile];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.white,
        color: Colors.black,
        animationDuration: const Duration(milliseconds: 500),
        onTap:(int index){
          setState(() {
            currentTabIndex=index;
          });
        },
        items: [
        const Icon(Icons.home_outlined,
          color: Colors.white,),
        const Icon(
          Icons.shopping_bag_outlined,
          color: Colors.white,
        ),
        const Icon(
          Icons.wallet_outlined,
          color: Colors.white,
        ),
          const Icon(
            Icons.cleaning_services,
            color: Colors.white,
          ),
        const Icon(
          Icons.person_outline,
          color: Colors.white,
        ),
      ],),
      body: pages[currentTabIndex],
    );
  }
}
