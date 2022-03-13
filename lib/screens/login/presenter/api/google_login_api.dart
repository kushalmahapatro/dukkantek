import 'package:dukkantek/dukkantek.dart';
import 'package:dukkantek/screens/login/entity/api_return.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<ApiReturn> googleLoginApi(
    BuildContext context, WidgetRef? splashRef) async {
  /// Google login API call
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  String returnMsg = "";
  String name = "";
  String email = "";
  bool val = false;
  try {
    GoogleSignInAccount? account = await _googleSignIn.signIn();
    if ((account?.id ?? '').isNotEmpty) {
      returnMsg = "Welcome ${account?.displayName ?? ''}";
      val = true;
      email = account?.email ?? '';
      name = account?.displayName ?? '';
    } else {
      returnMsg = "Problem occured while trying to login with Google";
    }
  } catch (error) {
    debugPrint(error.toString());
    returnMsg = "Problem occured while trying to login with Google";
  }

  await Future.delayed(const Duration(milliseconds: 1200));
  return ApiReturn(val, returnMsg, name, email);
}
