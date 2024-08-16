import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kilimoapp/models/finance.dart';
import 'package:kilimoapp/models/service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kilimoapp/models/finacial.dart';

class FinacialDetailsPages extends StatefulWidget {
  const FinacialDetailsPages({super.key, required this.finacialdetailspages});

  final Finance finacialdetailspages;

  @override
  State<FinacialDetailsPages > createState() => _FinacialDetailsPagesState();
}

class _FinacialDetailsPagesState extends State<FinacialDetailsPages > {
  bool showingMore = false;
  late TapGestureRecognizer readMoreGestureRecognizer;

  // helps to address the return type function to the address
  void launchURL(Uri uri, bool inApp) async {
    try{
      if(await canLaunchUrl(uri)){
        if(inApp){
          await launchUrl(
              uri,
              mode: LaunchMode.inAppWebView);
        }
        else{await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      }
    }catch (e) {
      print(e.toString());
    }
  }


  @override
  void initState() {
    readMoreGestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        setState(() {
          showingMore = !showingMore;

        });
      };
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    readMoreGestureRecognizer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BANK DETAIL FOR LOANS "),
        //actions:[
        //IconButton(onPressed: (){},
        // icon: Icon(Icons.arrow_back_ios),
      ),
      //],

      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      widget.finacialdetailspages.image,
                    ),
                  ))),
          Text(
            widget.finacialdetailspages.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Pick your LOAN",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Description",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          RichText(
              text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: showingMore
                          ? widget.finacialdetailspages.description
                          : "${widget.finacialdetailspages
                          .description.substring(0, widget.finacialdetailspages.description.length - 100)}",
                    ),
                    TextSpan(
                      recognizer: readMoreGestureRecognizer,
                      text: showingMore ? "Read less" : "Read more",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )
                  ])),
          InkWell(  //reusability
              onTap: () => launchURL(Uri.parse(widget.finacialdetailspages.link),false),

              child: Container(
                margin: EdgeInsets.all(20),
                height: 50,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: Text(
                  "Click for more Detail",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                )),
              )),
          // 0733800200
          InkWell(
              onTap: () => launchURL(Uri.parse('mailto:info@crdbank.co.tz'),false),
              child: Container(
                margin: EdgeInsets.all(20),
                height: 50,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: Text(
                  "Send Email",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                )),
              )
          ),

        ],

      ),
    );
  }
}

//.....READ ME.....
//for this part i used AGRIPLANT AGRICULTURE MOBILE APP IN FLUTTER part 3
