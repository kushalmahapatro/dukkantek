import 'package:dukkantek/dukkantek.dart';
import 'package:dukkantek/screens/login/interactor/login_interactor.dart';
import 'package:dukkantek/screens/login/presenter/login_presenter.dart';
import 'package:dukkantek/screens/login/presenter/login_validator.dart';
import 'package:dukkantek/screens/login/view/components/email.dart';
import 'package:dukkantek/screens/login/view/components/password.dart';

class LoginView extends HookConsumerWidget {
  LoginView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(LoginPresenter.provider);
    final emailController = useTextEditingController(text: '');
    final emailFocus = useFocusNode();
    final passwordController = useTextEditingController(text: '');
    final passwordFocus = useFocusNode();
    final changes = ref.read(LoginPresenter.provider.notifier);

    useEffect(() {
      LoginValidator.effect(
        emailController,
        passwordController,
        ref,
        _formKey,
      );
      return null;
    }, [emailController, passwordController]);

    return SizedBox(
      height: MediaQuery.of(context).size.height - 300,
      child: Scaffold(
        backgroundColor: DTColors.white,
        body: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              "Login to Continue".text.bodyLarge().make(),
              const SizedBox(height: 20),
              email(emailController, emailFocus, ref),
              const SizedBox(height: 20),
              password(passwordController, passwordFocus, ref),
              const SizedBox(height: 30),
              "Login".ctaActive(
                LoginInteractor.onLoginClick(ref, _formKey, context),
                disable: changes.debugState.buttonDisabled,
                loading: changes.debugState.loginClciked,
              ),
              const SizedBox(height: 20),
              'or'.dividerText(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DtAssets.google.assetImage(height: 30),
                  const SizedBox(width: 10),
                  'Login with Google'
                      .text
                      .button(color: DTColors.primary)
                      .make()
                ],
              ).ctaSocial(LoginInteractor.onGoogleLoginClick(ref, context),
                  loading: changes.debugState.googleLoginClciked),
              const Spacer()
            ],
          ),
        ),
      ),
    ).paddingAll(20);
  }
}
