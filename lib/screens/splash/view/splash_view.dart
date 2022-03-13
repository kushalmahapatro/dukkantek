import 'package:dukkantek/dukkantek.dart';
import 'package:dukkantek/screens/splash/interactor/splash_interactor.dart';
import 'package:dukkantek/screens/splash/presenter/splash_presenter.dart';

class SplashView extends HookConsumerWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(SplashPresenter.provider);
    final changes = ref.read(SplashPresenter.provider.notifier);

    final controller =
        useAnimationController(duration: const Duration(milliseconds: 500));

    return Scaffold(
      backgroundColor: changes.bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: [
                const SizedBox(height: 30),

                /// top logo
                logo(changes),
                const SizedBox(height: 20),

                /// heading
                'Empowering your business through digital transformation'
                    .text
                    .headline(color: changes.textColor)
                    .center
                    .make(),
                const SizedBox(height: 10),

                /// caption
                'A technology partner that improves your business.'
                    .text
                    .bodySmall(color: changes.textColor)
                    .make()
              ],
            ).paddingAll(20),

            /// image and button
            Expanded(
              child: Column(
                children: [
                  /// image
                  Expanded(
                      child: DtAssets.logoStore.assetImage(fit: BoxFit.cover)),

                  /// button
                  'Get Started'
                      .ctaActive(
                          SplashInt.getStartedClick(context, ref, controller))
                      .paddingSymmetric(horizontal: 20, vertical: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Widget logo(change) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      DtAssets.logo.assetImage(color: change.logoColor, height: 45),
      DtAssets.logoText.assetImage(color: change.logoColor, height: 40)
    ],
  );
}
