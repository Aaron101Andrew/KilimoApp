import 'package:cloud_firestore/cloud_firestore.dart';
// acces database online
class DatabaseMethods{
Future addUserDetail(Map<String, dynamic> userInfoMap, String id)async{
  return await FirebaseFirestore.instance
      .collection('users')
      .doc(id)
      .set(userInfoMap);
}
Future addFoodItem(Map<String, dynamic> userInfoMap, String name)async{
  return await FirebaseFirestore.instance
      .collection(name)
      .add(userInfoMap);
}
//"stream" helps to get all the documents from the firestore database
Future<Stream<QuerySnapshot>> getFoodItem(String name)async{
  return await FirebaseFirestore.instance.collection(name).snapshots();
}

//directing the food to be stored and to get all the added food to the cart
  Future addFoodToCart(Map<String, dynamic> userInfoMap, String id) async{
     return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection("Cart")
        .add(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getFoodCart(String id) async{
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Cart")
        .snapshots();
  }

}