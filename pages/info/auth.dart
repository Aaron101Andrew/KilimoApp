import 'package:firebase_auth/firebase_auth.dart';

class AuthMethod{
  final FirebaseAuth auth= FirebaseAuth.instance;

  getCurrentUser()async{
    return await auth.currentUser;
  }
   Future SignOut()async{
    await FirebaseAuth.instance.signOut();
   }
   Future deleteuser()async{
    User? user= await FirebaseAuth.instance.currentUser;
    user?.delete();
   }
}