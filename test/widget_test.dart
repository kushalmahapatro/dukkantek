// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dukkantek/dukkantek.dart';
import 'package:dukkantek/screens/login/presenter/presenter.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dukkantek/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group("Login validation tests", () {
    test("email validation test", () {
      String? res = LoginValidator.validateEmail("k@k.com", FocusNode()) ?? '';
      expect(res, "Please provide a valid email address");
    });

    test("password validation test", () {
      String? res = LoginValidator.validatePassword("123", FocusNode()) ?? '';
      expect(res, "Please enter 6 digits");
    });
  });

  tearDownAll(() {
    debugPrint("We are done");
  });
}
