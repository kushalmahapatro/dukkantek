import 'package:dukkantek/dukkantek.dart';
import 'package:dukkantek/screens/login/entity/login_response.dart';
import 'package:dukkantek/screens/login/presenter/login_presenter.dart';
import 'package:dukkantek/screens/login/route/login_route.dart';

Future<String> loginApi(
    String email, String password, BuildContext context) async {
  String mock = '';
  if (email.toLowerCase() == "km@dukkantek.com" &&
      password.toLowerCase() == "123456") {
    mock = "login/login_success.json";
  } else {
    mock = "login/login_failure.json";
  }

  String basicAuth = 'Basic ' + base64Encode(utf8.encode('$email:$password'));
  RestServiceResponse resp = await restService.post(
      "/login", <String, String>{"email": email},
      headers: <String, String>{'authorization': basicAuth},
      mockJsonName: mock);

  String returnResp = '';

  switch (resp.error) {
    case ScreenError.noError:
      {
        LoginResponse loginResp = LoginResponse.fromJson(resp.response);
        if ((loginResp.status ?? false) &&
            ((loginResp.statusCode ?? "") == "200")) {
          returnResp = "Welcome ${loginResp.response?.name ?? ''}";

          LoginPresenter.setUserPrefs(
              loginResp.response?.email ?? '', loginResp.response?.name ?? "");

          Future.delayed(const Duration(milliseconds: 1200), () {
            LoginRoute.moveToLaunchScreen(context);
          });
        } else {
          returnResp = loginResp.error?.msg ?? "";
        }
      }
      break;

    case ScreenError.internet:
      returnResp = "Internet connectivity issue";
      break;

    case ScreenError.unknown:
      returnResp = "Something went wrong";
      break;
  }

  await Future.delayed(const Duration(seconds: 2));
  return returnResp;
}
