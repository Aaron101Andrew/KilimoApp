import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class DatabaseMethods{
  //CREATE
  Future addEmployeeDetails(Map<String, dynamic> employeeInfoMap, String id)async{
    print('======> Endpoint =====>');
   return await FirebaseFirestore.instance
       .collection("Employee")
       .doc(id)
       .set(employeeInfoMap);

  }
  //to get all the details from the firebase database
  //READ
Future<Stream <QuerySnapshot>> getEmployeeDetails()async{
    return await FirebaseFirestore.instance.collection("Employee").snapshots();
}

//UPDATE
  Future updateEmployeeDetail(String id, Map<String, dynamic> updateInfo) async{
    return await FirebaseFirestore.instance.collection("Employee").doc(id).update(updateInfo);
  }

  //DELETE
  Future deleteEmployeeDetail(String id,)async{
    return await FirebaseFirestore.instance.collection("Employee").doc(id).delete(); //delete() was added for the icon to work.
  }
}