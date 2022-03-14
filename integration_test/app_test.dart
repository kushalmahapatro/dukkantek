import 'package:dukkantek/dukkantek.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dukkantek/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('end-to-end test', () {
    testWidgets('Login widget test', (WidgetTester tester) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      SharedPreferences.setMockInitialValues({}); //set values here

      pref.setBool(prefsLoginValue, false);

      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      final getStartedButton = find.byKey(DTkeys.getStarted).first;

      await tester.tap(getStartedButton);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      final emailField = find.byKey(DTkeys.emailField).first;
      final passwordField = find.byKey(DTkeys.passwordFiled).first;

      final obscure = find.byKey(DTkeys.obscure).first;
      await tester.tap(obscure);

      await tester.enterText(emailField, 'kgmail.com');
      await tester.pumpAndSettle(const Duration(seconds: 2));

      final emailError = find.text('Please provide a valid email address');
      expect(emailError, findsOneWidget);
      debugPrint("invalid email validated");

      await tester.enterText(emailField, '');
      await tester.pumpAndSettle(const Duration(seconds: 2));

      final emailBlank = find.text('Please enter a valid value');
      expect(emailBlank, findsOneWidget);
      debugPrint("blank email validated");

      await tester.enterText(emailField, 'km@dukkantek.com');
      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(emailError, findsNothing);
      expect(emailBlank, findsNothing);
      debugPrint("correct email validated");

      await tester.enterText(passwordField, '123');
      await tester.pumpAndSettle(const Duration(seconds: 2));

      final passwordError = find.text('Please enter 6 digits');
      expect(passwordError, findsOneWidget);
      debugPrint("invalid password validated");

      await tester.enterText(passwordField, '');
      await tester.pumpAndSettle(const Duration(seconds: 2));

      final passwordBlank = find.text('Please enter a valid value');
      expect(passwordBlank, findsOneWidget);
      debugPrint("blank password validated");

      await tester.enterText(passwordField, '123456');
      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(passwordError, findsNothing);
      expect(passwordBlank, findsNothing);
      debugPrint("correct password validated");

      await tester.pumpAndSettle(const Duration(seconds: 2));

      final loginButton = find.byKey(DTkeys.loginButton).first;

      await tester.tap(loginButton);

      await tester.pumpAndSettle(const Duration(seconds: 2));
    });
  });
}
