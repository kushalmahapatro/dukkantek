import 'package:dukkantek/dukkantek.dart';
import 'package:dukkantek/screens/login/entity/login_state_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dukkantek/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('end-to-end test', () {
    testWidgets('Login widget test', (WidgetTester tester) async {
      prefs.init();
      await tester.pumpAndSettle(const Duration(seconds: 1));

      SharedPreferences.setMockInitialValues({prefsLoginValue: false});
      final provider = FutureProvider((ref) => LoginStateModel());

      await tester.pumpWidget(
        const ProviderScope(
          child: app.Dukkantek(
            isLoggedIn: false,
          ),
        ),
      );

      await tester.pumpAndSettle(const Duration(seconds: 1));

      final getStartedButton = find.byKey(DTkeys.getStarted).first;

      await tester.tap(getStartedButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      final emailField = find.byKey(DTkeys.emailField).first;
      final passwordField = find.byKey(DTkeys.passwordFiled).first;

      final obscure = find.byKey(DTkeys.obscure).first;
      await tester.tap(obscure);
      await tester.pumpAndSettle();

      /// invalid email test
      Finder emailError = await invalidEmailTest(tester, emailField);

      /// blank email test
      Finder emailBlank = await blankEmailTest(tester, emailField);

      /// valid email test
      await validEmailTest(
          tester, emailField, emailError, emailBlank, "km@gmail.com");

      /// invalid password test
      Finder passwordError = await invalidPasswordTest(tester, passwordField);

      /// blank password test
      Finder passwordBlank = await blankPasswordTest(tester, passwordField);

      /// valid password test
      await validPasswordTest(
          tester, passwordField, passwordError, passwordBlank, "kushal");

      Finder invalidCredential;

      final loginButton = find.byKey(DTkeys.loginButton).first;
      await tester.tap(loginButton);
      await tester.pump(const Duration(seconds: 2));
      invalidCredential = find.text('Invalid Credentials');
      expect(invalidCredential, findsWidgets);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      debugPrint(
          "Invalid credential validated- not matching password and email");

      await validEmailTest(
          tester, emailField, emailError, emailBlank, "km@dukkantek.com");
      await tester.tap(loginButton);
      await tester.pump(const Duration(seconds: 2));
      invalidCredential = find.text('Invalid Credentials');
      expect(invalidCredential, findsWidgets);
      await tester.pumpAndSettle();
      debugPrint("Invalid credential validated- not matching password");

      await validPasswordTest(
          tester, passwordField, passwordError, passwordBlank, "123456");
      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      final welcomeMessage = find.text('Welcome Kushal Mahapatro');
      expect(welcomeMessage, findsWidgets);
      debugPrint("Login success validated");

      await tester.pumpAndSettle(const Duration(seconds: 3));
    });
  });

  tearDownAll(() {
    debugPrint("End-to-End testing done");
  });
}

Future<void> validPasswordTest(WidgetTester tester, Finder passwordField,
    Finder passwordError, Finder passwordBlank, String password) async {
  await tester.enterText(passwordField, password);
  await tester.pumpAndSettle(const Duration(seconds: 2));
  expect(passwordError, findsNothing);
  expect(passwordBlank, findsNothing);
  debugPrint("correct password validated");
  await tester.pumpAndSettle();
}

Future<Finder> blankPasswordTest(
    WidgetTester tester, Finder passwordField) async {
  await tester.enterText(passwordField, '');
  await tester.pumpAndSettle(const Duration(seconds: 2));
  final passwordBlank = find.text('Please enter a valid value');
  expect(passwordBlank, findsOneWidget);
  debugPrint("blank password validated");
  await tester.pumpAndSettle(const Duration(seconds: 2));
  return passwordBlank;
}

Future<Finder> invalidPasswordTest(
    WidgetTester tester, Finder passwordField) async {
  await tester.enterText(passwordField, '123');
  await tester.pumpAndSettle(const Duration(seconds: 2));
  final passwordError = find.text('Please enter 6 digits');
  expect(passwordError, findsOneWidget);
  debugPrint("invalid password validated");
  return passwordError;
}

Future<void> validEmailTest(WidgetTester tester, Finder emailField,
    Finder emailError, Finder emailBlank, String email) async {
  await tester.enterText(emailField, email);
  await tester.pumpAndSettle(const Duration(seconds: 2));
  expect(emailError, findsNothing);
  expect(emailBlank, findsNothing);
  debugPrint("correct email validated");
}

Future<Finder> blankEmailTest(WidgetTester tester, Finder emailField) async {
  await tester.enterText(emailField, '');
  await tester.pumpAndSettle(const Duration(seconds: 1));
  final emailBlank = find.text('Please enter a valid value');
  expect(emailBlank, findsOneWidget);
  debugPrint("blank email validated");
  return emailBlank;
}

Future<Finder> invalidEmailTest(WidgetTester tester, Finder emailField) async {
  await tester.enterText(emailField, 'kgmail.com');
  await tester.pumpAndSettle(const Duration(seconds: 1));
  final emailError = find.text('Please provide a valid email address');
  expect(emailError, findsOneWidget);
  debugPrint("invalid email validated");
  return emailError;
}
