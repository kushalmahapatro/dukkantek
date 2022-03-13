import 'package:dukkantek/rest_services/rest_service.dart';

class RestServiceResponse {
  RestServiceResponse(this.response,
      {this.error = ScreenError.noError,
      this.headers = const <String, List<String>>{}});

  final dynamic response;
  final ScreenError error;
  final Map<String, List<String>> headers;
}
