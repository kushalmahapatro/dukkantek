import 'package:dukkantek/dukkantek.dart';
import 'package:dukkantek/screens/splash/view/splash.dart';

class ProfileRoute {
  ProfileRoute._();

  static void backToSplash(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const SplashView()),
        (route) => false);
  }
}
