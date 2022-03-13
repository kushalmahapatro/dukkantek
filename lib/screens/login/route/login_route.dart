import 'package:dukkantek/dukkantek.dart';
import 'package:dukkantek/screens/launch/view/launch_view.dart';

import '../../splash/view/splash.dart';

class LoginRoute {
  LoginRoute._();

  static void moveToLaunchScreen(BuildContext context, WidgetRef? splashRef) {
    if (splashRef != null && splashRef.read(SplashPresenter.provider) == 1) {
      Navigator.pop(context);
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
      return const LaunchView();
    }));
  }
}
