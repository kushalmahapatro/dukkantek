import 'package:dukkantek/dukkantek.dart';
import 'package:dukkantek/screens/login/presenter/login_presenter.dart';
import 'package:dukkantek/screens/login/presenter/login_validator.dart';

DTInputText password(
    TextEditingController controller, FocusNode focus, WidgetRef ref) {
  final change = ref.read(LoginPresenter.provider.notifier);

  return DTInputText(
      focusNode: focus,
      labelText: "Password",
      hintText: "Enter 6 digits",
      onSaved: (String? value) {
        if (value != null) {
          ref.read(LoginPresenter.provider.notifier).savePassword(value);
        }
      },
      validator: (String? value) {
        return LoginValidator.validatePassword(value ?? '', focus);
      },
      controller: controller,
      inputType: TextInputType.text,
      obscure: change.state.obscure,
      suffix: GestureDetector(
        onTap: () {
          change.updateObscure();
        },
        child: Icon(
          change.state.obscure ? Icons.visibility : Icons.visibility_off,
          color: DTColors.primary,
        ),
      ));
}
