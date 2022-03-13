import 'package:dukkantek/dukkantek.dart';
import 'package:dukkantek/screens/login/entity/api_return.dart';

import 'package:dukkantek/screens/login/entity/login_state_model.dart';
import 'package:dukkantek/screens/login/login.dart';

class LoginPresenter {
  LoginPresenter._();

  /// provider to control state
  static final provider =
      StateNotifierProvider<Watcher, LoginStateModel>((ref) {
    return Watcher();
  });

  /// login button click login for api call
  static void onLogin(String email, String password, BuildContext context,
      WidgetRef ref, WidgetRef? splashRef) async {
    ApiReturn res = await loginApi(email, password, context, splashRef);
    ref.read(provider.notifier).loginLoader(false);
    showSnackBar(context, res.message);
    if (res.status) {
      successRoute(res, context, splashRef);
    }
  }

  /// google login button click logic for api call
  static void onGoogleLogin(
      BuildContext context, WidgetRef ref, WidgetRef? splashRef) async {
    ApiReturn res = await googleLoginApi(context, splashRef);
    ref.read(provider.notifier).googleLoginLoader(false);
    showSnackBar(context, res.message);
    if (res.status) {
      successRoute(res, context, splashRef);
    }
  }

  /// update shared preference with the successful login data , email and name
  static void setUserPrefs(String email, String name) {
    setUserEmail(email);
    setUserName(name);
    setIsLoggedIn(true);
  }

  /// login success update and route
  static void successRoute(
      ApiReturn res, BuildContext context, WidgetRef? splashRef) {
    LoginPresenter.setUserPrefs(res.email, res.name);

    LoginRoute.moveToLaunchScreen(context, splashRef);
  }
}

/// watcher to check the change in states
class Watcher extends StateNotifier<LoginStateModel> {
  Watcher() : super(LoginStateModel());

  void updateButtonState(bool value) {
    state = state.copyWith(buttonDisabled: value);
  }

  void saveEmail(String value) {
    state = state.copyWith(email: value);
  }

  void savePassword(String value) {
    state = state.copyWith(password: value);
  }

  void updateObscure() {
    state = state.copyWith(obscure: !state.obscure);
  }

  void loginLoader(bool value) {
    state = state.copyWith(loginClicked: value);
  }

  void googleLoginLoader(bool value) {
    state = state.copyWith(googleLoginClicked: value);
  }
}
