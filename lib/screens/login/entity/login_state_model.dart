class LoginStateModel {
  LoginStateModel(
      {this.obscure = true,
      this.buttonDisabled = true,
      this.loginClicked = false,
      this.googleLoginClicked = false,
      this.email = '',
      this.password = ''});

  final bool obscure;
  final bool buttonDisabled;
  final bool loginClicked;
  final bool googleLoginClicked;
  final String email;
  final String password;

  LoginStateModel copyWith({
    bool? obscure,
    bool? buttonDisabled,
    bool? loginClicked,
    bool? googleLoginClicked,
    String? email,
    String? password,
  }) {
    return LoginStateModel(
      obscure: obscure ?? this.obscure,
      buttonDisabled: buttonDisabled ?? this.buttonDisabled,
      loginClicked: loginClicked ?? this.loginClicked,
      googleLoginClicked: googleLoginClicked ?? this.googleLoginClicked,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
