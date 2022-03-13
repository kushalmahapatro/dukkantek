import 'package:dukkantek/dukkantek.dart';
import 'package:dukkantek/screens/login/entity/api_return.dart';
import 'package:dukkantek/screens/login/login.dart';

Future<ApiReturn> loginApi(String emailId, String password,
    BuildContext context, WidgetRef? splashRef) async {
  String mock = '';
  if (emailId.toLowerCase() == "km@dukkantek.com" &&
      password.toLowerCase() == "123456") {
    /// success API response mock
    mock = "login/login_success.json";
  } else {
    /// failure API response mock
    mock = "login/login_failure.json";
  }

  String basicAuth = 'Basic ' + base64Encode(utf8.encode('$emailId:$password'));
  RestServiceResponse resp = await restService.post(
      "/login", <String, String>{"email": emailId},
      headers: <String, String>{'authorization': basicAuth},
      mockJsonName: mock);

  String returnMsg = "";
  String name = "";
  String email = "";
  bool val = false;

  switch (resp.error) {
    case ScreenError.noError:
      {
        LoginResponse loginResp = LoginResponse.fromJson(resp.response);
        if ((loginResp.status ?? false) &&
            ((loginResp.statusCode ?? "") == "200")) {
          returnMsg = "Welcome ${loginResp.response?.name ?? ''}";
          val = true;
          name = loginResp.response?.name ?? '';
          email = loginResp.response?.email ?? '';
        } else {
          returnMsg = loginResp.error?.msg ?? "";
        }
      }
      break;

    case ScreenError.internet:
      returnMsg = "Internet connectivity issue";
      break;

    case ScreenError.unknown:
      returnMsg = "Something went wrong";
      break;
  }

  await Future.delayed(const Duration(milliseconds: 1200));
  return ApiReturn(val, returnMsg, name, email);
}
