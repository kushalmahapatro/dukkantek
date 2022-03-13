import 'package:dukkantek/dukkantek.dart';
import 'package:dukkantek/screens/login/presenter/login_presenter.dart';

class LoginInteractor {
  LoginInteractor._();
  static ClickFunction onLoginClick(
    WidgetRef ref,
    GlobalKey<FormState> formKey,
    BuildContext context,
  ) {
    return ClickFunction("Login clicked", onClick: () async {
      if (formKey.currentState?.validate() ?? false) {
        ref.read(LoginPresenter.provider.notifier).loginLoader(true);

        formKey.currentState!.save();
        final model = ref.read(LoginPresenter.provider.notifier);
        LoginPresenter.onLogin(
            model.state.email, model.state.password, context, ref);
      }
    });
  }

  static ClickFunction onGoogleLoginClick(
    WidgetRef ref,
    BuildContext context,
  ) {
    return ClickFunction("Google login clicked", onClick: () async {
      ref.read(LoginPresenter.provider.notifier).googleLoginLoader(true);

      LoginPresenter.onGoogleLogin(context, ref);
    });
  }
}
