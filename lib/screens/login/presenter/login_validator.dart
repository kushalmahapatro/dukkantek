import 'package:dukkantek/dukkantek.dart';
import 'package:dukkantek/screens/login/presenter/login_presenter.dart';

class LoginValidator {
  LoginValidator._();

  static bool _emailError = true;
  static bool _passwordError = true;

  /// validate entered email
  // ignore: body_might_complete_normally_nullable
  static String? validateEmail(String value, FocusNode focus) {
    if (value.isNotEmpty) {
      if (value.isValidEmailAddress) {
        _emailError = false;
        return null;
      } else {
        _emailError = true;
        return "Please provide a valid email address";
      }
    } else {
      if (focus.hasFocus) {
        _emailError = true;
        return "Please enter a valid value";
      }
    }
  }

  /// validate entered password
  // ignore: body_might_complete_normally_nullable
  static String? validatePassword(String value, FocusNode focus) {
    if (value.isNotEmpty) {
      if (value.length > 5) {
        _passwordError = false;
        return null;
      } else {
        _passwordError = true;
        return "Please enter 6 digits";
      }
    } else {
      if (focus.hasFocus) {
        _passwordError = true;
        return "Please enter a valid value";
      }
    }
  }

  /// check for empty email and password and also for error, if none found enable the button
  static void Function()? effect(TextEditingController email,
      TextEditingController password, WidgetRef ref) {
    email.addListener(() async {
      await Future.delayed(const Duration(milliseconds: 300));
      bool val = disabled(email, password);
      ref.read(LoginPresenter.provider.notifier).updateButtonState(val);
    });
    password.addListener(() async {
      await Future.delayed(const Duration(milliseconds: 300));
      bool val = disabled(email, password);
      ref.read(LoginPresenter.provider.notifier).updateButtonState(val);
    });
    return null;
  }

  /// enable or disable the button
  static bool disabled(
          TextEditingController email, TextEditingController password) =>
      email.text.toString().isEmpty ||
      password.text.toString().isEmpty ||
      _emailError ||
      _passwordError;
}
