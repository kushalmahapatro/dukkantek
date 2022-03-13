import 'package:dukkantek/dukkantek.dart';
import 'package:dukkantek/screens/launch/view/launch_view.dart';

class LoginRoute {
  LoginRoute._();

  static void moveToLaunchScreen(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
      return const LaunchView();
    }));
  }
}
