class LoginResponse {
  bool? status;
  String? statusCode;
  String? statusMsg;
  Response? response;
  Error? error;

  LoginResponse(
      {this.status,
      this.statusCode,
      this.statusMsg,
      this.response,
      this.error});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    statusMsg = json['statusMsg'];
    response =
        json['response'] != null ? Response.fromJson(json['response']) : null;
    error = json['error'] != null ? Error.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusCode'] = statusCode;
    data['statusMsg'] = statusMsg;
    if (response != null) {
      data['response'] = response!.toJson();
    }
    if (error != null) {
      data['error'] = error!.toJson();
    }
    return data;
  }
}

class Response {
  String? name;
  String? email;
  String? mob;
  String? loginType;

  Response({this.name, this.email, this.mob, this.loginType});

  Response.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    mob = json['mob'];
    loginType = json['loginType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['mob'] = mob;
    data['loginType'] = loginType;
    return data;
  }
}

class Error {
  String? msg;

  Error({this.msg});

  Error.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    return data;
  }
}
