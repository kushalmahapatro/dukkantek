import 'package:dukkantek/dukkantek.dart';
import 'package:dukkantek/screens/splash/presenter/splash_presenter.dart';
import 'package:dukkantek/screens/splash/route/splash_route.dart';

class SplashInt {
  SplashInt._();

  static ClickFunction getStartedClick(
      BuildContext ctx, WidgetRef ref, AnimationController controller) {
    return ClickFunction("get started clicked", onClick: () {
      ref.read(SplashPresenter.provider.notifier).changeState(1);

      SplashRoute.showLogin(ctx, ref, controller);
    });
  }
}
