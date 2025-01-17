


import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper{

  static final SharedPreferenceHelper instance = SharedPreferenceHelper._ctor();

  factory SharedPreferenceHelper(){
    return instance;
  }

  SharedPreferenceHelper._ctor();

  static late SharedPreferences prefs;

  static Future<void> initialize()async{
    prefs = await SharedPreferences.getInstance();
  }

  static void setCountry(country){
    prefs.setString("Country", country);
  }

  static String getCountry(){
    return prefs.getString("Country")??"us";
  }




}