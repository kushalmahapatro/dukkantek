import 'package:dukkantek/dukkantek.dart';
import 'package:dukkantek/screens/launch/view/launch_view.dart';
import 'package:dukkantek/screens/splash/view/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs.init();
  Future.delayed(const Duration(seconds: 1), () {
    bool loggedIn = isLoggedIn;
    runApp(ProviderScope(child: Dukkantek(isLoggedIn: loggedIn)));
  });
}

class Dukkantek extends StatelessWidget {
  const Dukkantek({Key? key, this.isLoggedIn = false}) : super(key: key);

  final bool isLoggedIn;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dukkantek',
      theme: DTTheme.theme,
      home: isLoggedIn ? const LaunchView() : const SplashView(),
    );
  }
}
