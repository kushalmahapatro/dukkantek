import 'package:dukkantek/dukkantek.dart';

class SplashPresenter {
  SplashPresenter._();
  static final provider = StateNotifierProvider((ref) {
    return Watcher();
  });
}

class Watcher extends StateNotifier<int> {
  Watcher() : super(0);

  Color bgColor = DTColors.white;
  Color textColor = DTColors.primary;
  Color? logoColor;

  void changeState(int value) {
    state = value;
    if (value == 1) {
      bgColor = DTColors.primary;
      textColor = DTColors.white;
      logoColor = DTColors.white;
    } else {
      bgColor = DTColors.white;
      textColor = DTColors.primary;
      logoColor = null;
    }
  }
}
