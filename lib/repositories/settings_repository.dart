import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_ninja/services/firebase_auth.dart';
import 'package:hive/hive.dart';

class SettingsRepository {
  // log out the user
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    FirebaseAuthService(FirebaseAuth.instance).signOut();
    bool isDarkMode = Hive.box('myBox').get('isDarkMode');
    Hive.box('myBox').clear();
    Hive.box('myBox').put('isDarkMode', isDarkMode);
  }
}
