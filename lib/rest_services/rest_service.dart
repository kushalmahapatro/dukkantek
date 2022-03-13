import 'package:connectivity/connectivity.dart';
import 'package:dukkantek/dukkantek.dart';
import 'package:dukkantek/rest_services/app_exceptions.dart';
import 'package:dukkantek/rest_services/dio_instance.dart';

enum ScreenError { noError, internet, unknown }

class RestService {
  Future<bool> checkConnectivity() async {
    final ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();

    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }

  Future<Dio> getDio([Map<String, dynamic>? headers]) async {
    final Dio dioClient = await DioInstance().getDioInstance(headers);
    return dioClient;
  }

  Future<RestServiceResponse> get(
    String url, {
    Map<String, dynamic>? headers,
    String mockJsonName = '',
  }) async {
    dynamic responseJson;
    ScreenError error = ScreenError.noError;
    if (mockJsonName.isNotEmpty) {
      responseJson = jsonDecode(await rootBundle.loadString(
        'assets/mock_response/$mockJsonName',
      ));
    } else {
      if (await checkConnectivity()) {
        try {
          final Dio dioClient = await getDio(headers);
          final Response<dynamic> response =
              await dioClient.getUri<dynamic>(Uri.parse(url));
          responseJson = _returnResponse(response, url,
              headers: await DioInstance().getGlobalHeaders(headers));
        } on SocketException {
          socketConnectionError();
          error = ScreenError.internet;
        } on Exception catch (e) {
          error = ScreenError.unknown;

          debugPrint(e.toString());
        }
      } else {
        debugPrint('No internet connection for :$url');
        error = ScreenError.internet;
      }
    }

    return RestServiceResponse(responseJson, error: error);
  }

  Future<String> imageDownload(String url, String downloadPath,
      Function(int, int) fileDownloadUpdate) async {
    await Dio().download(url, downloadPath,
        onReceiveProgress: (int count, int total) {
      fileDownloadUpdate(count, total);
    });
    return downloadPath;
  }

  Future<RestServiceResponse> post(
    String url,
    dynamic body, {
    Map<String, dynamic>? headers,
    String mockJsonName = '',
    bool Function(int?)? validateStatus,
  }) async {
    dynamic responseJson;
    Map<String, List<String>> responseHeader = const <String, List<String>>{};
    ScreenError error = ScreenError.noError;
    if (mockJsonName.isNotEmpty) {
      responseJson = jsonDecode(await rootBundle.loadString(
        'assets/mock_response/$mockJsonName',
      ));
    } else {
      if (await checkConnectivity()) {
        try {
          final Dio dioClient = await getDio(headers);
          Options? requestOptions;
          if (validateStatus != null) {
            requestOptions = Options(
              followRedirects: false,
              validateStatus: validateStatus,
            );
          }
          final Response<dynamic> response = await dioClient.postUri<dynamic>(
              Uri.parse(url),
              data: body,
              options: requestOptions);
          responseHeader = response.headers.map;
          responseJson = _returnResponse(response, url,
              body: body,
              headers: await DioInstance().getGlobalHeaders(headers));
        } on SocketException {
          socketConnectionError();
          error = ScreenError.internet;
        } on Exception catch (e) {
          error = ScreenError.unknown;

          debugPrint(e.toString());
        }
      } else {
        debugPrint('No internet connection for :$url');
        error = ScreenError.internet;
      }
    }

    return RestServiceResponse(responseJson,
        error: error, headers: responseHeader);
  }

  Future<RestServiceResponse> put(String url, dynamic body,
      {Map<String, dynamic>? headers, String mockJsonName = ''}) async {
    dynamic responseJson;
    ScreenError error = ScreenError.noError;
    if (mockJsonName.isNotEmpty) {
      responseJson = jsonDecode(await rootBundle.loadString(
        'assets/mock_response/$mockJsonName',
      ));
    } else {
      if (await checkConnectivity()) {
        try {
          final Dio dioClient = await getDio(headers);
          final Response<dynamic> response =
              await dioClient.putUri<dynamic>(Uri.parse(url), data: body);
          responseJson = _returnResponse(response, url,
              body: body,
              headers: await DioInstance().getGlobalHeaders(headers));
        } on SocketException {
          socketConnectionError();
          error = ScreenError.internet;
        } on Exception catch (e) {
          error = ScreenError.unknown;

          debugPrint(
            e.toString(),
          );
        }
      } else {
        debugPrint('No internet connection for :$url');
        error = ScreenError.internet;
      }
    }

    return RestServiceResponse(responseJson, error: error);
  }

  Future<RestServiceResponse> delete(String url, dynamic body,
      {Map<String, dynamic>? headers, String mockJsonName = ''}) async {
    dynamic responseJson;
    ScreenError error = ScreenError.noError;
    if (mockJsonName.isNotEmpty) {
      responseJson = jsonDecode(await rootBundle.loadString(
        'assets/mock_response/$mockJsonName',
      ));
    } else {
      if (await checkConnectivity()) {
        try {
          final Dio dioClient = await getDio(headers);
          final Response<dynamic> response =
              await dioClient.deleteUri<dynamic>(Uri.parse(url), data: body);
          responseJson = _returnResponse(response, url,
              headers: await DioInstance().getGlobalHeaders(headers));
        } on SocketException {
          socketConnectionError();
          error = ScreenError.internet;
        } on Exception catch (e) {
          error = ScreenError.unknown;

          debugPrint(e.toString());
        }
      } else {
        debugPrint('No internet connection for :$url');
        error = ScreenError.internet;
      }
    }

    return RestServiceResponse(responseJson, error: error);
  }

  Future<dynamic> download(
    String url,
    String savePath,
  ) async {
    dynamic responseJson;
    try {
      final Dio dioClient = await getDio();
      final Response<dynamic> response =
          await dioClient.downloadUri(Uri.parse(url), savePath);
      responseJson = _returnResponse(response, url, isDownloadCall: true);
    } on SocketException {
      socketConnectionError();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }

    return responseJson;
  }
}

dynamic _returnResponse(
  Response<dynamic> response,
  String url, {
  dynamic body,
  Map<String, dynamic>? headers,
  bool isDownloadCall = false,
}) {
  switch (response.statusCode) {
    case 200:
      if (!isDownloadCall) {
        if (response.data is Map || response.data is List) {
          final dynamic responseJson = response.data;

          return responseJson;
        } else {
          try {
            final dynamic responseJson = jsonDecode(response.data.toString());
            return responseJson;
          } on Exception catch (_) {
            final dynamic responseJson = response.data?.toString();
            return responseJson;
          }
        }
      } else {
        return true;
      }
    case 400:
      badRequestException(response.data.toString());
      break;
    case 401:
    case 403:
      unauthorisedException(response.data.toString());
      break;
    case 500:
    default:
      fetchDataException(response.data.toString());
      break;
  }
}

void socketConnectionError() {
  throw FetchDataException('No Internet connection');
}

void badRequestException(String message) {
  throw BadRequestException(message);
}

void unauthorisedException(String message) {
  throw UnauthorisedException(message);
}

void fetchDataException(String statusCode) {
  final String error =
      'Error occured while Communication with Server with StatusCode : $statusCode';
  throw FetchDataException(
    error,
  );
}

final RestService restService = RestService();
