import 'package:dukkantek/dukkantek.dart';
import 'package:dukkantek/screens/login/login.dart';

DTInputText email(
    TextEditingController controller, FocusNode focus, WidgetRef ref) {
  return DTInputText(
    key: DTkeys.emailField,
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
