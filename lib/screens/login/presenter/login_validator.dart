import 'package:dukkantek/dukkantek.dart';
import 'package:dukkantek/screens/login/presenter/login_presenter.dart';

class LoginValidator {
  LoginValidator._();

  static bool _emailError = true;
  static bool _passwordError = true;

  static String emailString = '';
  static String passwordString = '';

  /// validate entered email
  static String? validateEmail(String value, FocusNode focus, WidgetRef? ref) {
    emailString = value;
    String? returnString;
    if (value.isNotEmpty) {
      if (value.isValidEmailAddress) {
        _emailError = false;
        returnString = null;
      } else {
        _emailError = true;
        returnString = "Please provide a valid email address";
      }
    } else {
      if (focus.hasFocus) {
        _emailError = true;
        returnString = "Please enter a valid value";
      }
    }
    if (ref != null) {
      Future.delayed(const Duration(milliseconds: 300)).then((value) {
        bool val = disabledCheck(emailString, passwordString);
        ref.read(LoginPresenter.provider.notifier).updateButtonState(val);
      });
    }

    return returnString;
  }

  /// validate entered password
  static String? validatePassword(
      String value, FocusNode focus, WidgetRef? ref) {
    passwordString = value;
    String? returnString;

    if (value.isNotEmpty) {
      if (value.length > 5) {
        _passwordError = false;
        returnString = null;
      } else {
        _passwordError = true;
        returnString = "Please enter 6 digits";
      }
    } else {
      if (focus.hasFocus) {
        _passwordError = true;
        returnString = "Please enter a valid value";
      }
    }
    if (ref != null) {
      Future.delayed(const Duration(milliseconds: 300)).then((value) {
        bool val = disabledCheck(emailString, passwordString);
        ref.read(LoginPresenter.provider.notifier).updateButtonState(val);
      });
    }
    return returnString;
  }

  /// enable or disable the button
  static bool disabledCheck(String email, String password) =>
      email.toString().isEmpty ||
      password.toString().isEmpty ||
      _emailError ||
      _passwordError;
}
