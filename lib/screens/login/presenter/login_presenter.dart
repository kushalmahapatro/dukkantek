import 'package:dukkantek/dukkantek.dart';

import 'package:dukkantek/screens/login/entity/login_state_model.dart';
import 'package:dukkantek/screens/login/presenter/api/google_login_api.dart';
import 'package:dukkantek/screens/login/presenter/api/login_api.dart';

class LoginPresenter {
  LoginPresenter._();

  static final provider = StateNotifierProvider((ref) {
    return Watcher();
  });

  static void onLogin(String email, String password, BuildContext context,
      WidgetRef ref) async {
    String res = await loginApi(email, password, context);
    ref.read(provider.notifier).loginLoader(false);
    showSnackBar(context, res);
  }

  static void onGoogleLogin(BuildContext context, WidgetRef ref) async {
    String res = await googleLoginApi(context);
    ref.read(provider.notifier).googleLoginLoader(false);
    showSnackBar(context, res);
  }

  static void setUserPrefs(String email, String name) {
    setUserEmail(email);
    setUserName(name);
    setIsLoggedIn(true);
  }
}

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
    state = state.copyWith(loginClciked: value);
  }

  void googleLoginLoader(bool value) {
    state = state.copyWith(googleLoginClciked: value);
  }
}
