import 'package:dukkantek/dukkantek.dart';
import 'package:dukkantek/screens/login/presenter/login_presenter.dart';
import 'package:dukkantek/screens/login/presenter/login_validator.dart';

DTInputText email(
    TextEditingController controller, FocusNode focus, WidgetRef ref) {
  return DTInputText(
    focusNode: focus,
    labelText: "Email",
    hintText: "abc@gmail.com",
    onSaved: (String? value) {
      if (value != null) {
        ref.read(LoginPresenter.provider.notifier).saveEmail(value);
      }
    },
    validator: (String? value) {
      return LoginValidator.validateEmail(value ?? '', focus);
    },
    controller: controller,
    inputType: TextInputType.emailAddress,
  );
}
