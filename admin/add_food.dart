//import 'dart:html';

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kilimoapp/pages/info/database.dart';
import 'package:kilimoapp/widget/widget_support.dart';
import 'package:random_string/random_string.dart';
class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final List<String>items=['Rice', 'Wheat', 'Maize', 'Sorghum']; //this is the list that will pass on drop down menu
  String? value;
  TextEditingController namecontroller= new TextEditingController();
  TextEditingController pricecontroller= new TextEditingController();//helps to controll
  TextEditingController detailcontroller= new TextEditingController();
  final ImagePicker _picker= ImagePicker();
  File? selectedImage; //helps to select the picture on the file location

   Future getImage()async{
     var image= await _picker.pickImage(source: ImageSource.gallery);

     selectedImage= File(image!.path);
     setState(() {

     });
   }

   UploadItem()async{
     print("First out put");
     if(selectedImage!=null&& namecontroller.text!=""&&pricecontroller.text!=""&& detailcontroller.text!="");
     String addId= randomAlphaNumeric(10);
     print("Second out put");
     Reference firebaseStorageRef= FirebaseStorage.instance.ref().child("blogImage").child(addId);
      final UploadTask task= firebaseStorageRef.putFile(selectedImage!);
     print("third out put");
      //creat url of the image that will upload on firebase its creates Url of the image that have been uploaded in the firebase if it create download Url we can get acces of that URL
      var downlaodUrl= await(await task).ref.getDownloadURL();

Map<String, dynamic> addItem={
  "Image":downlaodUrl,
      "Name":namecontroller.text,
  "Price":pricecontroller.text,
  "Detail": detailcontroller.text,
};
await DatabaseMethods().addFoodItem(addItem, value!).then((value){

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.orangeAccent,
      content: Text(
        "Food has been added Successfully",
        style: TextStyle(fontSize: 18.0),)));
});
   }

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading is been used to show the icon from the left side of App bar.
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new_outlined, color: Color(0xFF373866),)),
           centerTitle: true,
         title: Text("Add Item",
           style: Appwidget.HeadlineTextFeildStyle(),),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 50.0,),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        Text("Upload the Item Picture", style: Appwidget.semiBooldTextFeildStyle(),),
             SizedBox(height: 20.0),
              selectedImage==null?
              GestureDetector(
                onTap: (){
                  getImage();
                },
                child: Center(
                  child: Material(
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        border:Border.all(color: Colors.black,
                            width:1.5),
                          borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: selectedImage == null ? const Text("image not selected") : Image.file( // helps the image to cover the complete width and heigth
                              selectedImage! //this condition should be repeated again
                                ,fit: BoxFit.cover,
                          ) ,

                        ),
                      )
                    ),
                  ),
                ),
              ):
              Center(
                child: Material(
                  elevation: 4.0,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        border:Border.all(color: Colors.black,
                            width:1.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.file(// pass selected image where the image have been installed so as the image will cover the complete
                        selectedImage!
                      ,  fit: BoxFit.cover,
                      )
                  ),
                ),
              ),

              SizedBox(height: 30.0,),
              Text("Item Name", style: Appwidget.semiBooldTextFeildStyle(),),
            SizedBox(height: 10.0,),
               Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(border: InputBorder.none, hintText: "Enter Item Name", hintStyle: Appwidget.LightTextFeildStyle()),
                ),
              ),
              SizedBox(height: 30.0,),
              Text("Item Price", style: Appwidget.semiBooldTextFeildStyle(),),
              SizedBox(height: 10.0,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xFFececf8),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TextField(
                  controller: pricecontroller,
                  decoration: InputDecoration(border: InputBorder.none,
                      hintText: "Enter Item Price", hintStyle: Appwidget.LightTextFeildStyle()),
                ),
              ),
              SizedBox(height: 30.0,),
              Text("Item Detail", style: Appwidget.semiBooldTextFeildStyle(),),
              SizedBox(height: 10.0,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xFFececf8),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TextField(
                  maxLines: 6, //increase the length of text field(text field size)
                  controller: detailcontroller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Item Detail",
                      hintStyle: Appwidget.LightTextFeildStyle()),
                ),
              ),
              SizedBox(height: 20.0,),
              Text(
                "Select Category",
                style: Appwidget.semiBooldTextFeildStyle(),
              ),
              SizedBox(height: 20.0,),
              Container(
                padding:  EdgeInsets.symmetric(horizontal: 10.0),
                width: MediaQuery.of(context).size.width, //gives wide range of selection
                decoration: BoxDecoration(color: Color(0xFFececf8), borderRadius: BorderRadius.circular(10)),
                child: DropdownButtonHideUnderline( //gives specific category for food item that should be uploaded
                  child: DropdownButton<String>(
                    items: items //it should be "fooditem"
                        .map((item) => DropdownMenuItem<String>(
                      value: item,
                        child: Text(
                          item, style:
                        const TextStyle(
                            fontSize: 18.0, color: Colors.black),))).toList(),
                   //onchanged helps to update the value
                    onChanged: ((value)=> setState(() {
                      this.value=value;
        
                })),
                    dropdownColor: Colors.white,
                    hint: Text("Select Category"),
                    iconSize: 36,
                    icon:Icon(
                      Icons.arrow_drop_down, //shows the user that there is drop down button
                      color: Colors.black,
                    ),
                    value: value,),),
              ),
               SizedBox(height:30.0,),
               GestureDetector(
                 onTap: (){
                   UploadItem();
                 },
                 child: Center(
                   child: Material(
                     elevation: 5.0,
                     borderRadius: BorderRadius.circular(10),
                     child: Container(
                       padding: EdgeInsets.symmetric(vertical: 5.0),
                       width: 150,
                       decoration: BoxDecoration(
                           color: Colors.black,
                           borderRadius: BorderRadius.circular(10)) ,
                         child: Center(
                           child: Text(
                             "Add",
                             style: TextStyle(
                                 color: Colors.white,
                                 fontSize: 20.0,
                               fontWeight: FontWeight.bold),),
                         ),
                     ),
                   ),
                 ),
               ),
            ],),),
      ),
    );
  }
}
