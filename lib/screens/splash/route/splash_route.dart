import 'package:dukkantek/dukkantek.dart';
import 'package:dukkantek/screens/login/view/login_view.dart';
import 'package:dukkantek/screens/splash/presenter/splash_presenter.dart';

class SplashRoute {
  SplashRoute._();

  static void showLogin(
      BuildContext ctx, WidgetRef ref, AnimationController controller) {
    showModalBottomSheet<bool>(
      transitionAnimationController: controller,
      elevation: 8,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      backgroundColor: DTColors.white,
      builder: (BuildContext context) {
        return LoginView();
      },
      context: ctx,
    ).then(
        (value) => ref.read(SplashPresenter.provider.notifier).changeState(0));
  }
}
