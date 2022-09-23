import 'package:get/get.dart';
import 'package:lentera_ilmu/screens/navigation.dart';
import 'package:lentera_ilmu/screens/welcome/welcome.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeController extends GetxController {
  var welcome = true;
  bool isLogin = false;
  void setWelcome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("welcome", false);
    return Get.to(() => const BottomNavBar());
  }

  String version = "";
  getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    update();
  }

  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    welcome = prefs.getBool("welcome") == false;
    isLogin = prefs.getBool("is_login") ?? false;
    // Get.to(() => Welcome());
    if (welcome == false) {
      return Get.to(() => Welcome());
    } else {
      return Get.to(() => const BottomNavBar());
    }
  }
}
