import 'dart:ui';

import 'package:flutter/material.dart';
//import 'package:kilimoapp/pages/finacialdetailspages.dart';
import 'package:kilimoapp/models/finance.dart';
import '../data/financial.dart';
//import 'package:kilimoapp/data/financialdetailspages.dart';
import 'package:kilimoapp/pages/finacial_details_pages.dart';

class FinancialService extends StatelessWidget {
  const FinancialService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Financial Service",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ))
          ],
        ),
      ),
      body: GridView.builder(
        itemCount: finance.length,
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FinacialDetailsPages(finacialdetailspages: finance[index]),));

            },
            child: SafeArea(
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(finance[index].image),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Text(
                        finance[index].name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
