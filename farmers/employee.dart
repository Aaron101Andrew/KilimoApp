import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kilimoapp/admin/add_food.dart';
import 'package:kilimoapp/farmers/service/database.dart';
import 'package:random_string/random_string.dart';

class Employee extends StatefulWidget {

  const Employee({super.key});

  @override
  State<Employee> createState() => EmployeeState();
}

class EmployeeState extends State<Employee> {
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController agecontroller = new TextEditingController();
  TextEditingController nidacontroller = new TextEditingController();
  TextEditingController farmlocationcontroller = new TextEditingController();
  TextEditingController farmownershipcontroller =new TextEditingController();
  TextEditingController farmlendingnamecontroller = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Row(
                //put the title text  in the center
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Text(
                "FDIS: Farm &",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Farmer Data",
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              )
            ])),
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0),
              child: Column(
                  //arrange the text to the right hand side
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Name",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: namecontroller,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                      "NIDA",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: nidacontroller,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),

                    // const Text(
                    //   "AGE",
                    //   style: TextStyle(
                    //       color: Colors.black,
                    //       fontSize: 24.0,
                    //       fontWeight: FontWeight.bold),
                    // ),
                    // const SizedBox(
                    //   height: 10.0,
                    // ),
                    // Container(
                    //   padding: EdgeInsets.only(left: 10.0),
                    //   decoration: BoxDecoration(
                    //       border: Border.all(),
                    //       borderRadius: BorderRadius.circular(10)),
                    //   child: TextField(
                    //     controller: agecontroller,
                    //     decoration: InputDecoration(border: InputBorder.none),
                    //   ),
                    // ),
                     const SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                      "Farm Location",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: farmlocationcontroller,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    const Text(
                      "Farm Ownership",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: farmownershipcontroller,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),

                    const Text(
                      "Farmer Lending Name",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: farmlendingnamecontroller,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),


                    const SizedBox(height: 30.0),
                    Center(
                        child: ElevatedButton(
                            onPressed: () async{
                              String Id= randomAlphaNumeric(15);
                              Map<String, dynamic> employeeInfoMap={
                                "Name": namecontroller.text,
                                "NIDA": nidacontroller.text,
                                "Id": Id,
                                "farmLocation": farmlocationcontroller.text,
                                "Farm Ownership": farmownershipcontroller.text,
                                "Farm lending name":farmlendingnamecontroller.text,
                              };
           await DatabaseMethods().addEmployeeDetails(employeeInfoMap, Id).then((value) {
             print('done');
             //debugPrint
             Fluttertoast.showToast(
                 msg: "Employee Details has been uploaded successfully",
                 toastLength: Toast.LENGTH_SHORT,
                 gravity: ToastGravity.CENTER,
                 timeInSecForIosWeb: 1,
                 backgroundColor: Colors.red,
                 textColor: Colors.white,
                 fontSize: 16.0
             );

           });
                            },
                            child: const Text("Add",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)))),

                    Center(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (
                                context) => const AddFood()));

                          },
                          child: Text("Add Items For Sale",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold))),

                    ),

                    //ElevatedButton(onPressed: (){}, child: Text("Add"))
                  ])),
        ));
  }
}
