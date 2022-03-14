import 'package:dukkantek/dukkantek.dart';
import 'package:dukkantek/screens/login/login.dart';

class LoginView extends HookConsumerWidget {
  const LoginView({this.splashRef, Key? key}) : super(key: key);

  final WidgetRef? splashRef;

  static final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final changes = ref.watch(LoginPresenter.provider);
    final emailController = useTextEditingController(text: '');
    final emailFocus = useFocusNode();
    final passwordController = useTextEditingController(text: '');
    final passwordFocus = useFocusNode();

    useEffect(() {
      LoginValidator.effect(
        emailController,
        passwordController,
        ref,
      );
      return null;
    }, [emailController, passwordController]);

    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return WillPopScope(
        onWillPop: () async {
          ref.read(LoginPresenter.provider.notifier).reset();
          return true;
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              (isKeyboardVisible ? 100 : 300),
          child: Scaffold(
            backgroundColor: DTColors.white,
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// heading
                    "Login to Continue".text.bodyLarge().make(),
                    const SizedBox(height: 20),

                    /// email text field
                    email(emailController, emailFocus, ref),
                    const SizedBox(height: 20),

                    /// password text field
                    password(passwordController, passwordFocus, ref),
                    const SizedBox(height: 30),

                    /// Login button
                    "Login".ctaActive(
                      LoginInteractor.onLoginClick(
                          ref, _formKey, context, splashRef),
                      disable: changes.buttonDisabled,
                      loading: changes.loginClicked,
                    ),
                    const SizedBox(height: 20),

                    /// divider -or
                    'or'.dividerText(),
                    const SizedBox(height: 20),

                    /// Google login button
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
                    ).ctaSocial(
                        LoginInteractor.onGoogleLoginClick(
                            ref, context, splashRef),
                        loading: changes.googleLoginClicked),
                    // const Spacer()
                  ],
                ),
              ),
            ),
          ),
        ).paddingAll(20),
      );
    });
  }
}
