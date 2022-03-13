import 'package:dukkantek/dukkantek.dart';
import 'package:dukkantek/screens/profile/route/profile_route.dart';

class ProfileInteractor {
  ProfileInteractor._();

  static ClickFunction onLogoutClicked(BuildContext context) {
    return ClickFunction("logout clicked", onClick: () {
      clearAllData();
      ProfileRoute.backToSplash(context);
    });
  }
}
