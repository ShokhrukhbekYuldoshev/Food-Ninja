import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_ninja/src/data/services/firebase_auth.dart';
import 'package:hive/hive.dart';

class SettingsRepository {
  // log out the user
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    FirebaseAuthService(FirebaseAuth.instance).signOut();
    bool isDarkMode = await Hive.box('myBox').get('isDarkMode');
    await Hive.box('myBox').clear();
    await Hive.box('myBox').put('isDarkMode', isDarkMode);
  }
}
