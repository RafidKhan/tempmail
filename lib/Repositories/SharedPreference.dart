import 'package:shared_preferences/shared_preferences.dart';

class SharedPreff {

  static SharedPreff to = SharedPreff();
  initial()async{
    prefss = await SharedPreferences.getInstance();
  }

  SharedPreferences? prefss;
}
