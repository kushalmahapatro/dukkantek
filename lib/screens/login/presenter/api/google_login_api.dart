import 'package:dukkantek/dukkantek.dart';
import 'package:dukkantek/screens/login/login.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<String> googleLoginApi(
    BuildContext context, WidgetRef? splashRef) async {
  /// Google login API call
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  String returnMsg = "";
  try {
    GoogleSignInAccount? account = await _googleSignIn.signIn();
    if ((account?.id ?? '').isNotEmpty) {
      returnMsg = "Welcome ${account?.displayName ?? ''}";
      LoginPresenter.setUserPrefs(
          account?.email ?? '', account?.displayName ?? '');

      Future.delayed(const Duration(milliseconds: 1200), () {
        LoginRoute.moveToLaunchScreen(context, splashRef);
      });
    } else {
      returnMsg = "Problem occured while trying to login with Google";
    }
  } catch (error) {
    debugPrint(error.toString());
    returnMsg = "Problem occured while trying to login with Google";
  }

  return returnMsg;
}
