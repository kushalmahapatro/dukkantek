import 'package:dio/adapter.dart';
import 'package:dukkantek/dukkantek.dart';

class DioInstance {
  factory DioInstance() {
    return _instance;
  }

  DioInstance._internal();

  DioInstance.resetinternal() {
    _instance = DioInstance._internal();
  }

  static DioInstance _instance = DioInstance._internal();

  Dio dio = Dio();

  Future<Dio> getDioInstance([Map<String, dynamic>? headers]) async {
    dio.options = BaseOptions(
        baseUrl: "https://api.dukkantek.com",
        headers: await getGlobalHeaders(headers),
        connectTimeout: 30000);
    return dio;
  }

  Future<List<int>> getKeyBytes() async {
    return (await rootBundle.load('assets/keys/stylishop.key'))
        .buffer
        .asInt8List();
  }

  Future<List<int>> getCertificateChainBytes() async {
    return (await rootBundle.load('assets/keys/stylishop.pem'))
        .buffer
        .asInt8List();
  }

  Future<void> addSecurityKeys() async {
    final List<int> certificateChainBytes = await getCertificateChainBytes();
    final List<int> keyBytes = await getKeyBytes();

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      final SecurityContext sc = SecurityContext(withTrustedRoots: true)
        ..useCertificateChainBytes(certificateChainBytes)
        ..usePrivateKeyBytes(keyBytes);
      HttpClient(context: sc).badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
      return client;
    };
  }

  Future<Map<String, dynamic>> getGlobalHeaders(
      Map<String, dynamic>? headers) async {
    final Map<String, dynamic> globalHeaders = <String, dynamic>{};
    globalHeaders['Content-Type'] = 'application/json';

    if (headers != null && headers.isNotEmpty) {
      headers.forEach((String key, dynamic value) {
        globalHeaders[key] = value;
      });
    }

    return globalHeaders;
  }
}
