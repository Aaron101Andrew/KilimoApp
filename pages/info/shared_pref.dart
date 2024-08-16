import 'package:shared_preferences/shared_preferences.dart';

// this class helps to have local database inspite of Firebase database
class SharedPreferenceHelper{

  static String userIdKey="USERKEY";
  static String userNameKey="USERNAMEKEY";
  static String userEmailKey="USEREMAILKEY";
  static String userProfileKey= "USEREPROFILEKEY";

  Future<bool>saveUserId(String getUserId)async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return prefs.setString(userIdKey, getUserId);
  }

  Future<bool>saveUserName(String getUserName)async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, getUserName);
  }
  Future<bool>saveUserEmail(String getUserEmail)async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return prefs.setString(userEmailKey, getUserEmail);
  }

  //used to get use profile pic
  Future<bool>saveUserProfile(String
  getUserProfile)async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return prefs.setString(
        userProfileKey,
        getUserProfile);
  }

  Future<String?> getUserId()async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return prefs.getString(userIdKey,);
  }

  Future<String?> getUserName()async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);// user name key was written from shared preferrence
  }

  Future<String?> getUserEmail()async{
    SharedPreferences pref= await SharedPreferences.getInstance();
    return pref.getString(userEmailKey);
  }

  //helps to get user URL
  Future<String?>getUserProfile(String
  getUserProfile)async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return prefs.getString(userProfileKey);
  }


}