class LoginStateModel {
  LoginStateModel(
      {this.obscure = true,
      this.buttonDisabled = true,
      this.loginClciked = false,
      this.googleLoginClciked = false,
      this.email = '',
      this.password = ''});

  final bool obscure;
  final bool buttonDisabled;
  final bool loginClciked;
  final bool googleLoginClciked;
  final String email;
  final String password;

  LoginStateModel copyWith({
    bool? obscure,
    bool? buttonDisabled,
    bool? loginClciked,
    bool? googleLoginClciked,
    String? email,
    String? password,
  }) {
    return LoginStateModel(
      obscure: obscure ?? this.obscure,
      buttonDisabled: buttonDisabled ?? this.buttonDisabled,
      loginClciked: loginClciked ?? this.loginClciked,
      googleLoginClciked: googleLoginClciked ?? this.googleLoginClciked,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
