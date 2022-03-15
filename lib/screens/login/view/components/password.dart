import 'package:dukkantek/dukkantek.dart';
import 'package:dukkantek/screens/login/login.dart';

DTInputText password(
    TextEditingController controller, FocusNode focus, WidgetRef ref) {
  final change = ref.read(LoginPresenter.provider);

  return DTInputText(
      key: DTkeys.passwordFiled,
      focusNode: focus,
      labelText: "Password",
      hintText: "Enter 6 digits",
      onSaved: (String? value) {
        if (value != null) {
          ref.read(LoginPresenter.provider.notifier).savePassword(value);
        }
      },
      validator: (String? value) {
        return LoginValidator.validatePassword(value ?? '', focus, ref);
      },
      controller: controller,
      inputType: TextInputType.text,
      obscure: change.obscure,
      suffix: Icon(
        change.obscure ? Icons.visibility : Icons.visibility_off,
        color: DTColors.primary,
        key: DTkeys.obscure,
      ).onClick(LoginInteractor.onObscureChange(ref)));
}
